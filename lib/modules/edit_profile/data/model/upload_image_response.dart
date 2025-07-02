import '../../domain/entity/upload_image_response_entity.dart';

class UploadImageResponse {
  String? message;

  UploadImageResponse({this.message});

  UploadImageResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }

  UploadImageResponseEntity convertIntoEntity() {
    return UploadImageResponseEntity(message: message);
  }
}
