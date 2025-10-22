import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:salsa_app/core/utils/api_constant.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstant.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );

    dio.interceptors.add(PrettyDioLogger());
  }

  static Future<Response> getData({
    required String url,
    dynamic query,
    String? bearerToken,
    String lang = 'en',
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      if (bearerToken != null) "Authorization": "Bearer $bearerToken",
      'Accept': 'application/json',
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    dynamic query,
    dynamic data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      if (token != null) "Authorization": "Bearer $token",
      'Accept': 'application/json',
    };
    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> deleteData({
    required String url,
    dynamic query,
    dynamic data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      if (token != null) "Authorization": "Bearer $token",
      'Accept': 'application/json',
    };
    return await dio.delete(url, queryParameters: query, data: data);
  }

  static Future<Response> putData({
    required String url,
    dynamic query,
    dynamic data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      if (token != null) "Authorization": "Bearer $token",
      'Accept': 'application/json',
    };
    return await dio.put(url, queryParameters: query, data: data);
  }

  static Future<Response> patchData({
    required String url,
    dynamic query,
    dynamic data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      if (token != null) "Authorization": "Bearer $token",
      'Accept': 'application/json',
    };
    return await dio.patch(url, queryParameters: query, data: data);
  }
}
