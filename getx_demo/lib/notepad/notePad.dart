import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:getx_demo/notepad/textController.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class Notepad extends StatefulWidget {
  const Notepad({super.key});

  @override
  State<Notepad> createState() => _NotepadState();
}

class _NotepadState extends State<Notepad> {
  final TextController controller = Get.put(TextController());
  final TextEditingController editController = TextEditingController();
  final TextEditingController updateController = TextEditingController();
  int _currentIndex = 0;

  void _addNote() {
    if (editController.text.trim().isNotEmpty) {
      controller.addNote(editController.text.trim());
      editController.clear();
      Get.snackbar("Success", "Note added successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade300,
          colorText: Colors.black);
    }
  }

  void _updateNoteDialog(int index) {
    updateController.text = controller.noteList[index].text;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update Note"),
          content: TextField(
            controller: updateController,
            decoration: const InputDecoration(hintText: "Edit your note"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (updateController.text.isNotEmpty) {
                  controller.updateNote(index, updateController.text);
                  Get.back();
                }
              },
              child: const Text("Update"),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Text(
          "All Notes",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: editController,
              decoration: const InputDecoration(
                hintText: 'Write a note...',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            const SizedBox(height: 10),
            Expanded(
                child: Obx(() => MasonryGridView.builder(
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: controller.noteList.length,
                      itemBuilder: (context, index) {
                        final note = controller.noteList[index];
                        return GestureDetector(
                          onTap: () => _updateNoteDialog(index),
                          child: Card(
                            color: const Color.fromARGB(255, 240, 238, 228),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    note.text,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    DateFormat('dd MMM yyyy, hh:mm a')
                                        .format(note.timestamp), // Show date
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () =>
                                          controller.deleteNote(index),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ))),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.blue.shade300,
        onPressed: _addNote,
        child: const Icon(Icons.add, color: Colors.black, size: 30),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.blue.shade300,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        showSelectedLabels: true,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // You can implement navigation logic here based on `_currentIndex`
          if (_currentIndex == 1) {
            Get.snackbar("Search", "Search feature coming soon!",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.blue.shade200,
                colorText: Colors.black);
          } else if (_currentIndex == 2) {
            Get.snackbar("Menu", "Menu feature coming soon!",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.blue.shade200,
                colorText: Colors.black);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
        ],
      ),
    );
  }
}
