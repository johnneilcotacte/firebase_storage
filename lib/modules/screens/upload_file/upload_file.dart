import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_assignment/api/firebasestorage.dart';
import 'package:new_flutter_assignment/modules/appbar/custom_appbar.dart';
import 'package:new_flutter_assignment/modules/appbar/custom_drawer.dart';
import 'package:new_flutter_assignment/modules/screens/upload_file/button/custom_button.dart';

//https://www.youtube.com/watch?v=dmZ9Tg9k13U
//https://github.com/JohannesMilke/firebase_upload_example
//push notification - https://www.youtube.com/watch?v=MqqZ975VHro
class BonusPage extends StatefulWidget {
  @override
  _BonusState createState() => _BonusState();
}

class _BonusState extends State<BonusPage> {
  UploadTask? task;
  Uint8List? _image;
  FilePickerResult? file;
  String? _link;

  @override
  void initState() {
    super.initState();

    fireBaseOnMessage();
  }

  void onFireBaseOpenApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('onMessageApp occured. Message is: ');
      print(event.notification!.title);
    });
  }

  void fireBaseOnMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      final title = message.notification!.title;
      final body = message.notification!.body;
      showDialog(
          context: this.context, //instead of context alone
          builder: (context) {
            return SimpleDialog(
              contentPadding: EdgeInsets.all(10),
              children: [
                Text(title!),
                Text(body!),
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      endDrawer: CustomEndDrawer(),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: 'Attach Image',
                icon: Icons.attach_file,
                onClicked: selectFile,
              ),
              SizedBox(height: 8),
              Text(
                (file != null)
                    ? file!.names.first.toString()
                    : 'No File Selected',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 48),
              ButtonWidget(
                text: 'Upload Image',
                icon: Icons.cloud_upload_outlined,
                onClicked: uploadFile,
              ),
              SizedBox(height: 20),
              //task != null ? buildUploadStatus(task!) : Container(),
              (task != null && _link == null)
                  ? CircularProgressIndicator()
                  : Container(),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: double.infinity,
                color: Colors.black,
                child: Center(
                  child: (_link != null)
                      ? Text(
                          _link!,
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
                          'No Link Yet',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpeg', 'jpg']);

    if (result != null) {
      _image = result.files.first.bytes;
      setState(() {
        file = result;
      });
    } else {
      return;
    }
  }

  Future<void> uploadFile() async {
    if (file == null) return;

    final fileName = file!.names.first.toString();
    final destination = 'files/$fileName';

    task = await Firebase.uploadBytes(destination, _image!);

    setState(() {});

    if (task == null) return;

    await _downloadLink(task!.snapshot.ref);
    //final snapshot = await task!.whenComplete(() {});
    //final urlDownload = await snapshot.ref.getDownloadURL();
    //final urlDownload = await _downloadLink(task!.snapshot.ref);
    //print('Download-Link: $urlDownload');
  }

  Future<void> _downloadLink(Reference ref) async {
    final snapshot = await task!.whenComplete(() {});
    final link = await snapshot.ref.getDownloadURL();
    setState(() {
      _link = link;
    });
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
