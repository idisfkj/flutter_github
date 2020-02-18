import 'package:dio/dio.dart';
import 'package:flutter_github/http/interceptors.dart';

const String API_GITHUB_BASE_URL = 'https://api.github.com';
const String GITHUB_BASE_URL = 'https://github.com';

BaseOptions options = BaseOptions(
  baseUrl: API_GITHUB_BASE_URL,
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

var dio = Dio(options)..interceptors.add(AppInterceptors());
