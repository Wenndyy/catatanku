import 'package:catatanku/models/notes_model.dart';
import 'package:catatanku/providers/notes_provider.dart';
import 'package:catatanku/widgets/detail_note_page.dart';
import 'package:catatanku/widgets/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ActionType { create, update }

extension ActionTypeExtension on ActionType {
  bool get isCreate => this == ActionType.create;
  bool get isUpdate => this == ActionType.update;
}

class NotesOperationBottomSheet extends StatefulWidget {
  const NotesOperationBottomSheet({
    super.key,
    required this.action,
    required this.provider,
    this.note,
  });

  final ActionType action;
  final NotesModel? note;
  final NotesProvider provider;

  static Future<void> show(
    BuildContext context, {
    required NotesProvider provider,
    NotesModel? note,
  }) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return NotesOperationBottomSheet(
          action: note != null ? ActionType.update : ActionType.create,
          provider: provider,
          note: note,
        );
      },
    );
  }

  @override
  State<NotesOperationBottomSheet> createState() =>
      _NotesOperationBottomSheetState();
}

class _NotesOperationBottomSheetState extends State<NotesOperationBottomSheet> {
  final TextEditingController _judulCOntroller = TextEditingController();

  final TextEditingController _catatanControler = TextEditingController();

  NotesModel? get note => widget.note;
  NotesProvider get provider => widget.provider;

  String get judul => _judulCOntroller.text;
  String get catatan => _catatanControler.text;

  @override
  void initState() {
    super.initState();

    if (note != null) {
      _judulCOntroller.text = note!.judul;
      _catatanControler.text = note!.catatan;
    }
  }

  @override
  Widget build(BuildContext context) {
    const color = Color(0xff9F73AB);
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _judulCOntroller,
            decoration: const InputDecoration(
              hintText: 'Judul',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: color),
              ),
            ),
          ),
          TextField(
            controller: _catatanControler,
            maxLines: 2,
            decoration: const InputDecoration(
              hintText: 'Catatan',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: color),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              final newData = NotesModel(
                id: widget.note?.id ?? '',
                judul: judul,
                catatan: catatan,
              );
              if (widget.action.isUpdate) {
                provider.updateData(note: newData).then((value) {
                  Get.offAll(HomePage());
                  setState(() {});
                });
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: color),
            child: Text(widget.action.isCreate ? 'Create' : 'Update'),
          )
        ],
      ),
    );
  }
}
