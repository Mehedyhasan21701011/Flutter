import 'package:get/get.dart';

class Note {
  String text;
  DateTime timestamp;

  Note({
    required this.text,
    required this.timestamp,
  });
}

class TextController extends GetxController {
  var noteList = <Note>[].obs; // Make it reactive

  void addNote(String note) {
    noteList.add(Note(text: note, timestamp: DateTime.now()));
  }

  void updateNote(int index, String newNote) {
    if (index >= 0 && index < noteList.length) {
      noteList[index] = Note(text: newNote, timestamp: DateTime.now());
    }
  }

  void deleteNote(int index) {
    if (index >= 0 && index < noteList.length) {
      noteList.removeAt(index);
    }
  }
}
