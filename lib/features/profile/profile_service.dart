import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:skillspro/common/http/http_helper.dart';

import '../../env.config.dart';

class ProfileService {
  final Dio dio;

  ProfileService({required this.dio});

  Future<HttpResponse<String>> saveDetails(Map<String, dynamic> details) async {
    try {
      final response = await dio.post("$baseUrl/profile", data: details);
      return HttpResponse<String>(response, 'Successful');
    } on DioException catch (e) {
      return HttpResponse<String>.exception(e);
    }
  }

  Future<HttpResponse<String>> addSkills(List<String> skills) async {
    try {
      final response = await dio.post("$baseUrl/profile/skills/add", data: jsonEncode(skills));
      return HttpResponse<String>(response, 'Successful');
    } on DioException catch (e) {
      return HttpResponse<String>.exception(e);
    }
  }
}
