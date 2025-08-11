import 'package:firebase_project/app/modules/database/databasehelper.dart';
import 'package:firebase_project/app/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final logoutControl = LoginController();

  var noteList = [].obs;
  @override
  void onInit() {
    fetchNotes();
    super.onInit();
  }

  void fetchNotes() async {
    final data = await DatabaseHelper.instance.queryAllNotes();
    noteList.value = data;
  }

  void addNote(String title, String content) async {
    await DatabaseHelper.instance.insertNote({
      'title': title,
      'content': content,
    });
    fetchNotes();
  }

  void updateNote(int id, String title, String content) async {
    await DatabaseHelper.instance.updateNote({
      'id': id,
      'title': title,
      'content': content,
    });
    fetchNotes();
  }

  void deleteNote(int id) async {
    await DatabaseHelper.instance.deleteNote(id);
    fetchNotes();
  }
}
