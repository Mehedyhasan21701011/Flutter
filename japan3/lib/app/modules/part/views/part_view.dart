import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/part_controller.dart'; // adjust path as needed

class PartView extends GetView<PartController> {
  const PartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.part.title), // assuming StoryPart has title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.part.isTranslation
                  ? _translationSection(context)
                  : _mcqSection(context),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: controller.submit,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size.fromHeight(48),
                ),
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// MCQ section
  Widget _mcqSection(BuildContext context) {
    final opts = controller.part.options!;
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.part.text,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (controller.part.imageUrl != null &&
              controller.part.imageUrl!.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: controller.part.imageUrl!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 180,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 180,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                    size: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          Text(
            controller.part.question,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ...List.generate(opts.length, (i) {
            return RadioListTile<int>(
              value: i,
              groupValue: controller.selectedIndex.value,
              onChanged: (v) => controller.selectedIndex.value = v ?? -1,
              title: Text(opts[i]),
            );
          }),
        ],
      );
    });
  }

  /// Translation section
  Widget _translationSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.part.text,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (controller.part.imageUrl != null &&
            controller.part.imageUrl!.isNotEmpty) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: controller.part.imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 180,
                width: double.infinity,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Container(
                height: 180,
                width: double.infinity,
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: const Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        TextField(
          controller: controller.textController,
          decoration: InputDecoration(
            hintText: controller.part.question,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          minLines: 2,
          maxLines: 4,
        ),
        if (controller.part.translationKeyword != null) ...[],
      ],
    );
  }
}
