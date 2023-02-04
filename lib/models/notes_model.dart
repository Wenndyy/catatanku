import 'package:equatable/equatable.dart';

class NotesModel extends Equatable {
  final String id;
  final String judul;
  final String catatan;

  const NotesModel({
    required this.id,
    required this.judul,
    required this.catatan,
  });

  factory NotesModel.fromMap({
    required String id,
    required Map<String, dynamic> map,
  }) {
    return NotesModel(
      id: id,
      judul: map['judul'],
      catatan: map['catatan'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'judul': judul,
      'catatan': catatan,
    };
  }

  @override
  List<Object?> get props => [
        id,
        judul,
        catatan,
      ];
}
