import 'package:get/get.dart';

class getcontroler extends GetxController {
  var noteList = <String>[].obs;

  void noteAdd(String newNote) {
    noteList.add(newNote);
  }

  void deletenote(int index) {
    noteList.removeAt(index);
  }

  void updateNote(String newContent, int index) {
    noteList[index] = newContent;
  }
}
