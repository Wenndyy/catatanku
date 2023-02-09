import 'package:catatanku/providers/notes_provider.dart';
import 'package:catatanku/theme.dart';
import 'package:catatanku/widgets/homepage.dart';
import 'package:catatanku/widgets/note_operation_bottom_shet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailNote extends StatefulWidget {
  final String id;

  const DetailNote({super.key, required this.id});

  @override
  State<DetailNote> createState() => _DetailNoteState();
}

class _DetailNoteState extends State<DetailNote> {
  final provider = NotesProvider();
  @override
  void initState() {
    super.initState();
    provider.fetchDataById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
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
              //Navigator.of(context).pop();
            },
          ),
          elevation: 0,
          title: Text('Detail Note'),
        ),
        body: Consumer<NotesProvider>(
          builder: (context, notesProvider, child) {
            final notes = provider.notes;
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return notes.isEmpty
                ? const Center(
                    child: Text('Data tidak ditemukan'),
                  )
                : ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return Container(
                        margin:
                            const EdgeInsets.only(top: 24, right: 24, left: 24),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                note.judul,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                note.catatan,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: whiteColor,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 295,
                                    height: 55,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        NotesOperationBottomSheet.show(
                                          context,
                                          note: note,
                                          provider: provider,
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: blueColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                        ),
                                      ),
                                      child: Text(
                                        'Update',
                                        style: GoogleFonts.openSans(
                                            color: whiteColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
