import 'package:flutter/material.dart';

class EditCaptionScreen extends StatefulWidget {
  final String initialCaption;

  const EditCaptionScreen({super.key, required this.initialCaption});

  @override
  State<EditCaptionScreen> createState() => _EditCaptionScreenState();
}

class _EditCaptionScreenState extends State<EditCaptionScreen> {
  late TextEditingController _captionController;

  @override
  void initState() {
    super.initState();
    _captionController = TextEditingController(text: widget.initialCaption);
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () {
                      // Return null if canceled
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'Edit Caption',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Return the updated text
                      Navigator.pop(context, _captionController.text);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.black12),
            
            // Text Editing Area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _captionController,
                  maxLines: null,
                  expands: true,
                  style: const TextStyle(fontSize: 16, height: 1.4),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write a caption...',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
