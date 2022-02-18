
import 'dart:io';

import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:clean_app/features/login/auth/authentication_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as gx;

enum Method { POST, GET, PUT, DELETE, PATCH}

const BASE_URL = pathServer;

class HttpDioService {

  Dio? _dio;
  Dio? defaultDio;

  static header() => {"Content-Type": "application/json"};

  Future<HttpDioService> init() async {
    _dio = Dio(BaseOptions(baseUrl: BASE_URL, headers: header()));
    defaultDio = Dio();
    initInterceptors();
    return this;
  }

  void initInterceptors() {

    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) async {
          requestOptions.followRedirects = false;
          var tokenApp = await getCurrentTokenUser();
              if(tokenApp!=emptyString){
                requestOptions.headers['Content-Type'] = "application/json";
                requestOptions.headers['Authorization'] = "Bearer $tokenApp";
              }
          print("REQUEST[${requestOptions.method}] => PATH: ${requestOptions.path}"
              "=> REQUEST VALUES: ${requestOptions.queryParameters} => HEADERS: ${requestOptions.headers}");
          print("REQUEST BODY => ${requestOptions.data}");
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          print("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response);
        },
        onError: (error, handler) async {
          print("Error[${error.response?.statusCode}]");

          //Validate the unauthorized
          //if (error.response?.statusCode == 401 || error.response?.statusCode == 403) {
          if (error.response?.statusCode == 401) {
            await refreshToken();
            final cloneReq = await _dio?.request(error.requestOptions.path,
                          data: error.requestOptions.data,
                          queryParameters: error.requestOptions.queryParameters);

            var newToken = await getCurrentTokenUser();
            
            if(newToken!=emptyString){
                cloneReq?.headers.add("Content-Type", "application/json");
                cloneReq?.headers.add("Authorization", "Bearer $newToken");
            }

            handler.resolve(cloneReq!);
          }

          return handler.next(error);
        },
      ),
    );
  }

  Future<dynamic> request(
      {required String url,
      required Method method,
      Map<String, dynamic>? params}) async {
    Response response;

    try {
      if (method == Method.POST) {
        response = await _dio!.post(url, data: params);
      } else if (method == Method.DELETE) {
        response = await _dio!.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio!.patch(url);
      } else if (method == Method.PUT) {
        response = await _dio!.put(url, data: params);
      } else {
        response = await _dio!.get(url, queryParameters: params);
      }

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else if (response.statusCode == 400) {
        throw Exception("Wrong Pass");
      } else {
        throw Exception("Something does wen't wrong");
      }
    } on SocketException catch (e) {
      print(e);
      throw Exception("Not Internet Connection");
    } on FormatException catch (e) {
      print(e);
      throw Exception("Bad response format");
    } on DioError catch (e) {
      print(e);
      throw Exception(e);
    } catch (e) {
      print(e);
      throw Exception("Something wen't wrong");
    }
  }


  Future<String> getCurrentTokenUser() async {
    var userRepository = UserRepositoryImpl();
    return await userRepository.getToken();
  }

  Future<String> getCurrentRefreshToken() async {
    var userRepository = UserRepositoryImpl();
    return await userRepository.getRefreshToken();
  }

  Future<void> refreshToken() async {

    var refreshToken = await getCurrentRefreshToken();
    var userRepository = UserRepositoryImpl();
    try {
      final response = await defaultDio?.post('https://auth-cvm.auth.us-east-1.amazoncognito.com/oauth2/token', 
        data: {
          'grant_type': 'refresh_token', 
          'client_id': '2v9kfta1dhqv01dtm6blf3m48g',
          'refresh_token': refreshToken
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType
        )
      );
      
      if (response?.statusCode == 200) {
        userRepository.saveToken(response?.data['id_token']);
      } else {
        final AuthenticationController _authenticationController = gx.Get.find();
        _authenticationController.signOut();
      }
    } catch (e) {
      final AuthenticationController _authenticationController = gx.Get.find();
      _authenticationController.signOut();
      print(e);
      throw Exception("Something wen't wrong to get token in refresh Token");
    }

  }


}