import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/apis/apis_endpoints/apis_endpoints.dart';
import '../../model/upload_image_response.dart';

@lazySingleton
class UploadImageApiClient {
  final Dio dio;
  UploadImageApiClient(this.dio);
  Future<UploadImageResponse> uploadProfileImageWithDio(File imageFile) async {
    // final formData = FormData.fromMap({
    //   'photo': await MultipartFile.fromFile(
    //     imageFile.path,
    //     filename: 'user_${DateTime.now().millisecondsSinceEpoch}.jpg',
    //     contentType: MediaType('image', 'jpeg'),
    //   ),
    // });
    var formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
        contentType: MediaType(
          'image',
          'jpeg',
        ), // Adjust the content type as needed
      ),
    });

    var response = await dio.put(ApisEndpoints.uploadImage, data: formData);

    return UploadImageResponse.fromJson(response.data);
  }
}
