



import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  XFile? image;
  final imagePicker = ImagePicker();
  bool showSpinner = false;

  Future<void> pickImage() async{
    final img = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if(img != null){
      image = img;
      setState(() {

      });
    }
    else{
      image = img;
    }
  }

  Future<void> uploadImage()async {
    setState(() {
      showSpinner = true;
    });

    var stream = http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');

    var request = http.MultipartRequest('POST',uri);

    request.fields['title'] = 'static title';

    var multipartFile = http.MultipartFile(
      'image',
      stream,
      length,
    );
    request.files.add(multipartFile);
    var response = await request.send();

    if(response.statusCode == 200){
      setState(() {
        showSpinner = false;
        debugPrint('seccessful');
      });
    }
    else{
      debugPrint(response.statusCode.toString());
    }




  }


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('image picker'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image == null
                ? Center(
                    child: GestureDetector(
                      onTap: () {
                        pickImage();
                      },
                      child: const Text('upload image'),
                    ),
                  )
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  //to show image, you type like this.
                  File(image!.path),
                  fit: BoxFit.cover,
                  width: 150,
                  height: 150,

                ),
              ),
            ),
            const SizedBox(height: 20,),
            MaterialButton(onPressed: () => uploadImage(),color: Colors.blue, child: Text('upload Image', style: TextStyle(color: Colors.white), ),)
          ],
        ),
      ),
    );
  }
}
