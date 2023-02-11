import 'package:catatanku/models/notes_model.dart';
import 'package:catatanku/providers/notes_provider.dart';
import 'package:catatanku/shared/theme.dart';
import 'package:catatanku/widgets/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ActionType { update }

extension ActionTypeExtension on ActionType {
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
      backgroundColor: darkLightColor,
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return NotesOperationBottomSheet(
          action: ActionType.update,
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
            style: TextStyle(
              color: whiteColor,
            ),
            decoration: InputDecoration(
              hintText: 'Judul',
              hintStyle: TextStyle(color: whiteColor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: blueColor),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: _catatanControler,
            style: TextStyle(
              color: whiteColor,
            ),
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'Catatan',
              hintStyle: TextStyle(color: whiteColor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: blueColor),
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
                  Get.offAll(const HomePage());
                  setState(() {});
                });
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: blueColor),
            child: const Text('Update'),
          )
        ],
      ),
    );
  }
}
