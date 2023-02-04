import 'package:catatanku/providers/notes_provider.dart';
import 'package:catatanku/widgets/editnotepage.dart';
import 'package:catatanku/widgets/homepage.dart';
import 'package:flutter/material.dart';
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
    const color = Color(0xff9F73AB);
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
        body: Consumer<NotesProvider>(
          builder: (context, notesProvider, child) {
            final notes = provider.notes;
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return notes.isEmpty
                ? Center(
                    child: Text('Data tidak ditemukan'),
                  )
                : ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return Container(
                        margin: EdgeInsets.only(top: 24, right: 24, left: 24),
                        child: Center(
                          child: Column(
                            children: [
                              Text(note.judul),
                              Text(note.catatan),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const EditNotePage()));
                                  },
                                  child: Text('Edit'))
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
