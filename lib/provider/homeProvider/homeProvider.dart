// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider_paten/services/api_master.dart';

class HomeProvider with ChangeNotifier {
  String? _message;
  bool _isFileUploaded = false;

  String? get message => _message;
  bool get isFileUploaded => _isFileUploaded;

  Future<void> uploadFile(
      String comment, String milestoneId, List<File> files) async {
    const path = '/rc-main/track/api/submit-attached-more-document';

    try {
      final response = await ApiMaster().fire(
        path: path,
        method: HttpMethod.$post,
        contentType: ContentType.formData,
        multipartFields: {
          'milestone_add_more_comments': comment,
          'milestone_id': milestoneId,
        },
        files: files,
        multipartFileType: MultipartFileType.image,
      );

      if (response != null && response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['message'] == "file uploaded successfully") {
          _message = data['message'];
          _isFileUploaded = true;
        } else {
          _message = 'File upload failed';
          _isFileUploaded = false;
        }
      } else {
        _message = 'File upload failed';
        _isFileUploaded = false;
      }
    } catch (e) {
      _message = 'An error occurred: $e';
      _isFileUploaded = false;
    }

    notifyListeners();
  }

  void clearMessage() {
    _message = null;
    _isFileUploaded = false;
    notifyListeners();
  }
}
