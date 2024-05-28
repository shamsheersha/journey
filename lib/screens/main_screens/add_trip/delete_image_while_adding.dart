import 'dart:io';

import 'package:flutter/material.dart';

class DeleteImage {
  static Future<void> deleteImageWhileAddingTrip(BuildContext context,
      int index, List<File> selectedImages, Function onImageDeleted) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Image'),
          content: const Text('Are you sure?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {

                  onImageDeleted(index);

                  Navigator.pop(context);
                },
                child: const Text('Delete'))
          ],
        );
      },
    );
  }
}
