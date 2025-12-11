import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['BASE_URL'] ?? 'https://api.finsum.uz/api/v1',
        connectTimeout: Duration(
          milliseconds: int.parse(dotenv.env['TIMEOUT'] ?? '30000'),
        ),
        receiveTimeout: Duration(
          milliseconds: int.parse(dotenv.env['TIMEOUT'] ?? '30000'),
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final apiKey = dotenv.env['API_KEY'];
          if (apiKey != null) {
            options.headers['X-API-Key'] = apiKey;
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  // Demo: Login with phone
  Future<Map<String, dynamic>> login(String phone) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    return {
      'success': true,
      'message': 'Code sent successfully',
      'data': {
        'session_id': 'demo_session_12345',
      },
    };
  }

  // Demo: Verify code
  Future<Map<String, dynamic>> verifyCode(String phone, String code) async {
    await Future.delayed(const Duration(seconds: 2));
    // Accept any 6-digit code for demo
    if (code.length == 6) {
      return {
        'success': true,
        'message': 'Code verified successfully',
        'data': {
          'token': 'demo_token_abcdef123456',
          'user_id': 'user_12345',
        },
      };
    }
    return {
      'success': false,
      'message': 'Invalid code',
    };
  }

  // Demo: Verify passport
  Future<Map<String, dynamic>> verifyPassport({
    required String series,
    required String number,
    required String birthDate,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return {
      'success': true,
      'message': 'Passport verified successfully',
      'data': {
        'verified': true,
        'full_name': 'Demo User',
      },
    };
  }

  // Demo: Get user info
  Future<Map<String, dynamic>> getUserInfo() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'success': true,
      'data': {
        'id': 'user_12345',
        'full_name': 'Jamshid Usmonov',
        'phone': '+998901234567',
        'status': 'verified',
        'avatar_url': '',
        'limit': 15000000,
        'available_limit': 15000000,
        'purchases': [],
        'scoring_history': [
          {
            'id': '1',
            'date': '2024-01-15',
            'score': 85,
            'status': 'approved',
          },
          {
            'id': '2',
            'date': '2024-02-20',
            'score': 90,
            'status': 'approved',
          },
        ],
      },
    };
  }
}
