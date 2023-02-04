import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:catatanku/models/notes_model.dart';
import 'package:catatanku/providers/notes_provider.dart';
import 'package:catatanku/widgets/homepage.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key, this.note,  this.provider});

  final NotesModel? note;
  final NotesProvider? provider;

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _catatanControler = TextEditingController();

  NotesModel? get note => widget.note;
  NotesProvider? get provider => widget.provider;

  String get judul => _judulController.text;
  String get catatan => _catatanControler.text;

  @override
  void initState() {
    super.initState();

    if (note != null) {
      _judulController.text = note!.judul;
      _catatanControler.text = note!.catatan;
    }
  }

  /*  final CollectionReference _notes =
      FirebaseFirestore.instance.collection('notes'); */
  static const color = Color(0xff9F73AB);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xff624F82),
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(
                  hintText: 'Judul',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: color),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _catatanControler,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Catatan',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: color),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  width: 295,
                  height: 55,
                  child: TextButton(
                    onPressed: () {
                      final newDataUpdate = NotesModel(
                        id: widget.note?.id ?? '',
                        judul: judul,
                        catatan: catatan,
                      );
                      provider?.updateData(note: newDataUpdate,).whenComplete(() {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      });
                      _judulController.text = '';
                      _catatanControler.text = '';
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                    child: Text(
                      'Update',
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
