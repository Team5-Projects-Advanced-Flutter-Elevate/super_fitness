class ApiErrorModel {
  ApiErrorModel({required this.error});

  final String? error;

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(error: json["error"]);
  }

  @override
  String toString() {
    return "$error, ";
  }
}
