
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class StorageService with ChangeNotifier{

  final firebaseStorage = FirebaseStorage.instance;


  List<String> _imageUrls = [];
  bool _isLoading = false;
  bool _isUploading = false;

  //encapsulation (getters, setters)
  List<String> get imageUrls => _imageUrls;
  bool get isLoading => _isLoading;
  bool get isUploading => _isUploading;


  //get images with the userid 
  Future<void> fetchImages() async{
    //start loading 
    _isLoading = true;
    
    // get the download urls for each images;
    final ListResult result = await firebaseStorage.ref('images/').listAll();

    //get dowload urls for each images 
    final urls = await Future.wait(result.items.map((ref)=> ref.getDownloadURL()));

    _imageUrls = urls;
    _isLoading = false;

    //upadte ui
    notifyListeners();

  }

  Future<void> deleteImage (String imageUrl) async{
    try {
      _imageUrls.remove(imageUrl);

      final String path = extractPathFromUrl(imageUrl);

      await firebaseStorage.ref(path).delete();

    } catch (err) {
      print("eroro deleting image: $err");
    } 

    //upadte ui
    notifyListeners();

  }

  String extractPathFromUrl(String url){
    Uri uri = Uri.parse(url);

    String encodedPath = uri.pathSegments.last;

    return Uri.decodeComponent(encodedPath);
  }

  Future<void> updloadImage(String fileName) async{
    _isUploading = true;

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    File file = File(image.path);

    try {
      String filePath = 'images/$fileName.png';
      //upload
      await firebaseStorage.ref(fileName).putFile(file);

      String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();
      _imageUrls.add(downloadUrl);
    } catch (err) {
      print("upload error: $err");
    }finally{
    _isUploading = false;
    notifyListeners();
    }


  }



}




