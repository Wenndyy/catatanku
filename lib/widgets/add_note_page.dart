import 'package:catatanku/models/notes_model.dart';
import 'package:catatanku/providers/notes_provider.dart';
import 'package:catatanku/theme.dart';
import 'package:catatanku/widgets/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

enum ActionType {
  create,
}

extension ActionTypeExtension on ActionType {
  bool get isCreate => this == ActionType.create;
}

class AddNotePage extends StatefulWidget {
  const AddNotePage(
      {super.key,
      this.note,
      required this.provider,
      this.action = ActionType.create});

  final NotesModel? note;
  final NotesProvider provider;
  final ActionType action;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _catatanControler = TextEditingController();

  String get judul => _judulController.text;
  String get catatan => _catatanControler.text;

  NotesModel? get note => widget.note;
  NotesProvider? get provider => widget.provider;

  @override
  void initState() {
    super.initState();

    if (note != null) {
      _judulController.text = note!.judul;
      _catatanControler.text = note!.catatan;
    }
  }

  @override
  Widget build(BuildContext context) {
    const color = Color(0xff9F73AB);
    return ChangeNotifierProvider.value(
      value: provider,
      child: Scaffold(
        backgroundColor: darkColor,
        appBar: AppBar(
          backgroundColor: darkColor,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back,
              color: blueColor,
            ),
            onTap: () {
              Get.back();
              //Navigator.pop(context);
            },
          ),
          elevation: 0,
          title: Text('Add Note'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  TextFormField(
                    controller: _judulController,
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
                  TextFormField(
                    controller: _catatanControler,
                    style: TextStyle(
                      color: whiteColor,
                    ),
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Catatan',
                      hintStyle: TextStyle(color: whiteColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: blueColor),
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
                        onPressed: () async {
                          // final String judul = _judulController.text;
                          // final String catatan = _catatanControler.text;

                          final newData = NotesModel(
                            id: widget.note?.id ?? '',
                            judul: judul,
                            catatan: catatan,
                          );
                          if (widget.action.isCreate) {
                            provider?.addData(note: newData).then((value) {
                              Get.offAll(const HomePage());
                              setState(() {});
                            });
                          }
                          // await provider?.addData(note: newNote).whenComplete(
                          //   () {
                          //     Get.offAll(const HomePage());
                          //     // Navigator.pushReplacement(
                          //     //     context,
                          //     //     MaterialPageRoute(
                          //     //         builder: (context) => const HomePage()));
                          //   },
                          // );
                          // _judulController.text = '';
                          // _catatanControler.text = '';
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: blueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                        child: Text(
                          'Add',
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
          ],
        ),
      ),
    );
  }
}
