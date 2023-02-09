import 'package:catatanku/providers/notes_provider.dart';
import 'package:catatanku/theme.dart';
import 'package:catatanku/widgets/add_note_page.dart';
import 'package:catatanku/widgets/detail_note_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final provider = NotesProvider();
  @override
  void initState() {
    super.initState();
    provider.onBuild();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Scaffold(
        backgroundColor: darkColor,
        body: Consumer<NotesProvider>(
          builder: (context, noteProvider, child) {
            final notes = provider.notes;
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailNote(
                                  id: note.id,
                                )));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: darkLightColor,
                    margin: const EdgeInsets.only(top: 24, right: 24, left: 24),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                note.judul,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                              ),
                              TextButton(
                                  onPressed: () {
                                    provider.deleteData(id: note.id);
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            note.catatan,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            maxLines: 4,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddNotePage(
              provider: provider,
            ));
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => const AddNotePage()));
          },
          backgroundColor: blueColor,
          foregroundColor: whiteColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
