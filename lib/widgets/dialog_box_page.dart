import 'package:catatanku/widgets/mybutton_page.dart';
import 'package:flutter/material.dart';

class DialogBoxPage extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBoxPage({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    const color = Color(0xff9F73AB);
    return AlertDialog(
      content: Container(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Add list",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: color),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyButtonPage(text: "Save", onPressed: onSave),
                MyButtonPage(text: "Cancel", onPressed: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
