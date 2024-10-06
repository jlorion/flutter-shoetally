import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class StorageService with ChangeNotifier {
  final firebaseStorage = FirebaseStorage.instance;

  String generateRandomString(int length) {
  const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();

  return List.generate(length, (index) => characters[random.nextInt(characters.length)]).join();
}


  List<String> _imageUrls = [];
  bool _isLoading = false;
  bool _isUploading = false;

  //encapsulation (getters, setters)
  List<String> get imageUrls => _imageUrls;
  bool get isLoading => _isLoading;
  bool get isUploading => _isUploading;

  //get images with the userid
  Future<void> fetchImages() async {
    //start loading
    _isLoading = true;

    // get the download urls for each images;
    final ListResult result = await firebaseStorage.ref('images/').listAll();

    //get dowload urls for each images
    final urls =
        await Future.wait(result.items.map((ref) => ref.getDownloadURL()));

    _imageUrls = urls;
    _isLoading = false;

    //upadte ui
    notifyListeners();
  }

  Future<void> deleteImage(String imageUrl) async {
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

  String extractPathFromUrl(String url) {
    Uri uri = Uri.parse(url);

    String encodedPath = uri.pathSegments.last;

    return Uri.decodeComponent(encodedPath);
  }

  Future<XFile?> selectImage()async {
    final ImagePicker pickImage = ImagePicker();
    final XFile? image = await pickImage.pickImage(source: ImageSource.gallery);

    return image;
  } 

  Future<String> updloadImage(XFile? image) async{
    _isUploading = true;

    String fileName = generateRandomString(10);

    if (image == null) return "error";

    File file = File(image.path);

    String downloadUrl = "";

    try {
      String filePath = 'images/$fileName.png';
      //upload

      if (kIsWeb) {
        await firebaseStorage.ref(filePath).putData(await image.readAsBytes(), SettableMetadata(
          contentType: 'image/png',
        ));
      }else{
        await firebaseStorage.ref(filePath).putFile(file);
      }

      downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();
      _isUploading = false;

      print(downloadUrl);
      notifyListeners();
    } catch (err) {
      print("upload error: $err");
    }
    return downloadUrl;

  }
}
