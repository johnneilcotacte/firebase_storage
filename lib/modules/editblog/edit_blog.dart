import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:new_flutter_assignment/models/blog.dart';
import 'package:new_flutter_assignment/providers/blogs_provider.dart';

//blogcard editor

class EditBlog extends HookWidget {
  final Blog blog;
  EditBlog({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _image = useState<Uint8List?>(blog.image); //please review this
    final _titlecontroller = useTextEditingController(
        text: blog.title); //add initial value to a textfield
    final _subtitlecontroller = useTextEditingController(text: blog.subtitle);
    final _contentcontroller = useTextEditingController(text: blog.content);
    final _blogProvider = useProvider(blogProvider);
    //link - https://pub.dev/packages/image_picker_web

    _updateBlogObject() {
      if (_image.value != null) {
        _blogProvider.updateBlog(
            updatedBlog: Blog(
                id: blog.id,
                title: _titlecontroller.text,
                subtitle: _subtitlecontroller.text,
                content: _contentcontroller.text,
                image: _image.value,
                date: ''));
        _titlecontroller.clear();
        _subtitlecontroller.clear();
        _contentcontroller.clear();
        _image.value = null;
      }
    }

    Future _pickImage() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['png', 'jpeg', 'jpg']);

      if (result != null) {
        _image.value = result.files.first.bytes;
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20 / 4),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextField(
                        controller: _titlecontroller,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Title'),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _subtitlecontroller,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Subtitle'),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _contentcontroller,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Content'),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: _updateBlogObject,
                        child: Text('Update'),
                      ),
                    ],
                  ),
                )),
            // Sidebar
            SizedBox(width: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20 / 4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Featured Image'),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity - 10,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                      ),
                      child: (_image.value != null)
                          ? FittedBox(
                              fit: BoxFit.fill,
                              child: Image.memory(_image.value!))
                          : null,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: _pickImage, child: Text('Upload Photo'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
