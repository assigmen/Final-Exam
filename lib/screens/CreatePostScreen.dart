import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Add this for image picking functionality
import 'dart:io'; // To use File for the image

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  File? _image; // Variable to store the picked image

  final ImagePicker _picker = ImagePicker();

  // Method to pick an image
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Method to handle post creation logic
  void _createPost() {
    // Logic to handle the post creation, like sending data to the backend
    // You can access the values like _titleController.text, _descriptionController.text, etc.
    print('Title: ${_titleController.text}');
    print('Description: ${_descriptionController.text}');
    print('Category: ${_categoryController.text}');
    if (_image != null) {
      print('Image selected: ${_image!.path}');
    }
    // Reset fields after creating post
    _titleController.clear();
    _descriptionController.clear();
    _categoryController.clear();
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image Section
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _image == null
                    ? Center(child: Icon(Icons.add_a_photo, color: Colors.grey))
                    : Image.file(
                  _image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // Title Field with Pencil Icon
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            SizedBox(height: 16.0),

            // Description Field with Lines Icon
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.line_style),
              ),
              maxLines: 4, // To allow multiple lines of text
            ),
            SizedBox(height: 16.0),

            // Category Field with Bullet Points Icon
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Select Category',
                prefixIcon: Icon(Icons.format_list_bulleted),
              ),
            ),
            SizedBox(height: 32.0),

            // Create Button
            ElevatedButton(
              onPressed: _createPost,
              child: Text('CREATE'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
