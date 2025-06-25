class ApisEndpoints {
  static const String baseUrl = 'https://fitness.elevateegy.com';
  static const String foodBaseUrl = 'https://www.themealdb.com/api/json/v1/1/';
  static const String loginEndPoint = '/api/v1/auth/signin';
  static const String forgetPasswordEndPoint = '/api/v1/auth/forgotPassword';
  static const String resetPasswordEndPoint = '/api/v1/auth/resetPassword';
  static const String resetCodeEndPoint = '/api/v1/auth/verifyResetCode';
  static const String registerEndPoint = '/api/v1/auth/signup';
  static const String exerciseById = '/api/v1/exercises/by-muscle-difficulty?';
  static const String getFoodCategories = "categories.php";
  static const String getFoodByCategory = "filter.php";
  static const String musclesGroup = '/api/v1/muscles';
  static const String musclesGroupWorkouts = '/api/v1/musclesGroup/{id}';
}
