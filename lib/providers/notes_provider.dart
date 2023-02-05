import 'package:catatanku/models/notes_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NotesProvider extends ChangeNotifier {
  final _notes = <NotesModel>[];
  var _isLoading = false;

  List<NotesModel> get notes => _notes;
  bool get isLoading => _isLoading;

  final CollectionReference _noteCollection =
      FirebaseFirestore.instance.collection('notes');

  Future<void> onBuild() async {
    fetchData();
  }

  Future<void> fetchData() async {
    _isLoading = true;
    final response = await _noteCollection.get();
    final datas = response.docs;

    _notes.clear();
    for (final data in datas) {
      final jsonMap = data.data() as Map<String, dynamic>?;

      if (jsonMap != null) {
        notes.add(
          NotesModel.fromMap(
            id: data.id,
            map: jsonMap,
          ),
        );
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchDataById(String id) async {
    _isLoading = true;
    final response = await _noteCollection.doc(id).get();
    final jsonMap = response.data() as Map<String, dynamic>?;
    if (jsonMap != null) {
      _notes.clear();
      _notes.add(
        NotesModel.fromMap(
          id: response.id,
          map: jsonMap,
        ),
      );
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addData({required NotesModel note}) async {
    _loadingAndNotifyListenerWrapper(
      () async => await _noteCollection.add(
        note.toMap(),
      ),
    );
  }

  Future<void> updateData({
    required NotesModel note,
  }) async {
    _loadingAndNotifyListenerWrapper(
      () async => await _noteCollection.doc(note.id).update(
            note.toMap(),
          ),
    );
    await Future.delayed(const Duration(seconds: 2));
    fetchData();
  }

  Future<void> deleteData({required String id}) async {
    _loadingAndNotifyListenerWrapper(
      () async => await _noteCollection.doc(id).delete(),
    );
  }

  Future<void> _loadingAndNotifyListenerWrapper(AsyncCallback callback) async {
    _isLoading = true;
    notifyListeners();
    await callback.call();
    _isLoading = false;
    notifyListeners();
    fetchData();
  }
}
