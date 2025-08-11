import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final titleC = TextEditingController();
  final contentC = TextEditingController();

  var selectedNoteId = RxnInt(); // null or int

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Notebook')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleC,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: contentC,
              decoration: const InputDecoration(labelText: "Content"),
            ),
            Obx(
              () => Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedNoteId.value != null) {
                      controller.updateNote(
                        selectedNoteId.value!,
                        titleC.text.trim(),
                        contentC.text.trim(),
                      );
                      selectedNoteId.value = null;
                    } else {
                      controller.addNote(
                        titleC.text.trim(),
                        contentC.text.trim(),
                      );
                    }
                    titleC.clear();
                    contentC.clear();
                  },
                  child: Text(
                    selectedNoteId.value == null ? "Add Note" : "Update Note",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.noteList.length,
                  itemBuilder: (context, index) {
                    final note = controller.noteList[index];
                    return ListTile(
                      title: Text(note['title']),
                      subtitle: Text(note['content']),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                titleC.text = note['title'];
                                contentC.text = note['content'];
                                selectedNoteId.value = note['id'];
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.deleteNote(note['id']);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            ElevatedButton(
              onPressed: () {
                controller.logoutControl.logOut();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(600, 50), // width = 100, height = 50
                backgroundColor: const Color.fromARGB(
                  255,
                  245,
                  102,
                  62,
                ), // default background color
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ), // default text color
              ),
              child: const Text("Log_out", style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
}
