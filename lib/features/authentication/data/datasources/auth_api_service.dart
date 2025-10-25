import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:seed/features/authentication/data/models/auth_response_model.dart';

part 'auth_api_service.g.dart';

/// API service for authentication endpoints
@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  /// Login endpoint
  /// POST http://127.0.0.1:8000/api/auth/login
  @POST('/api/auth/login')
  Future<AuthResponseModel> login(@Body() Map<String, dynamic> body);

  /// Signup endpoint
  /// POST http://127.0.0.1:8000/api/auth/signup
  @POST('/api/auth/signup')
  Future<AuthResponseModel> signUp(@Body() Map<String, dynamic> body);
}
