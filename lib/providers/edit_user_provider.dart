import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';

class EditUserProvider extends ChangeNotifier {
  File? newPictureFile;
  String? imageL;

  void set localImage(String? image) {
    imageL = image;
  }

  //bool isSaving = false;

  Future<String?> uploadImage() async {
    if (this.newPictureFile == null) return null;

    //this.isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dvhj8f9bn/image/upload?upload_preset=tfg-preset');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return null;
    }

    this.newPictureFile = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }

  //   void updateSelectedProductImage( String path ) {

  //   this.selectedProduct.picture = path;
  //   this.newPictureFile = File.fromUri( Uri(path: path) );

  //   notifyListeners();

  // }

}
