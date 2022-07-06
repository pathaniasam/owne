import 'dart:convert';
import 'dart:developer';

import 'dart:convert';


import 'package:dio/dio.dart' ;
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response,FormData;
import 'package:ownervet/repository/network_utils.dart';
import 'package:ownervet/routes/app_routes.dart';



class ApiHelper {
  static CancelToken? cancelToken;
  static Dio? _dio;

  static Dio createDio() {
    cancelToken = CancelToken();
    return Dio(BaseOptions(
      connectTimeout: 500000,
      receiveTimeout: 1000000000,
      baseUrl: NetworkUtils.BASE_URL,
    ));
  }

  static Dio googleDio() {
    cancelToken = CancelToken();
    return Dio(BaseOptions(
      connectTimeout: 500000,
      receiveTimeout: 1000000000,
      baseUrl: NetworkUtils.BASE_URL,
    ));
  }

  static Future<Response?> postImage(
    String subUrl, {
    Map? body,
    FormData? formData,
    String? authtoken,
    BuildContext? context,
  }) async {
    //print(BASE_URL + subUrl);

    var client = createDio();
    print('cleint' + client.toString());
    client.options.headers["Accept"] = "application/json";
    client.interceptors.add(LogInterceptor());

    if (authtoken != null) print("auth token null nhi c mera");
    //client.options.headers["Authorization"] = "Bearer " + authtoken!;
    // client.options.headers["Timezone"] = Timezone;
    //   print("--- header:---" + json.encode(client.options.headers));
    Response response;
    try {
      response = await client.post<String>(subUrl, data: formData,
          onSendProgress: (int sent, int total) {
        print("$sent $total");
      });

      print(response);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 403) {
        } else {
          print(e.response!.data);
          //   throw MyException(e.response.data);
        }
      } else {
        print(e.message);
        //  throw MyException(e.message);
      }
    }
  }

  static Future<Response?> post(
    String subUrl, {
    Map? body,
    FormData? formData,
    String? authtoken,
    BuildContext? context,
  }) async {
    if (body != null) body.removeWhere((k, v) => v == null);
    var client = createDio();

    if (authtoken != null) {

      client.options.headers["Authorization"] ="Bearer "+ authtoken!;

    }


    print(NetworkUtils.BASE_URL + subUrl);
   // print("Authorization"+ authtoken.toString());
  //  print("body"+body.toString());
    Response response;
   // log("--- body:" + formData);
    try {
      response = await client.post<String>(
        NetworkUtils.BASE_URL + subUrl,
        data: body != null
            ? json.encode(body)
            : formData != null
                ? formData
                : null,
      );
      log(response.data);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        print("StatusCode....yy"+e.response!.statusCode.toString());
        print("StatusCodez....yy"+e.response!.toString());

        if(e.response!.statusCode==406){
          //AppUtil.Snackbar(S.current.blocked, S.current.blockedAdmin);
         // GetStorage().erase();
          Future.delayed(Duration(seconds: 3)).then((value) {
            Get.offAllNamed(AppRoutes.LOGIN);
          });
        }

        return e.response;
      } else {
        print(e.message);
        print("Error 408");

        return e.response;
      }
    }
  }





  static Future<Response?> put(
    String subUrl, {
    Map? body,
    FormData? formData,
    String? authtoken,
    BuildContext? context,
  }) async {
    //   print(BASE_URL + subUrl);
    if (body != null) body.removeWhere((k, v) => v == null);
    var client = createDio();



    if (authtoken != null) {

      client.options.headers["Authorization"] ="Bearer "+ authtoken!;

    }

    // client.options.headers["Timezone"] = Timezone;
    //   print("--- header:---" + json.encode(client.options.headers));
    Response response;
    print("--- body:" + json.encode(body));
    try {
      response = await client.put<String>(
        subUrl,
        data: body != null
            ? json.encode(body)
            : formData != null
                ? formData
                : null,
      );
      print(response);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        //throw MyException(e.response.data);
      } else {
        print(e.message);
        // throw MyException(e.message);
      }
    }
  }

  static Future<Response?> delete(
    String subUrl, {
    Map? body,
    FormData? formData,
    String? authtoken,
    BuildContext? context,
  }) async {
    //   print(BASE_URL + subUrl);
    if (body != null) body.removeWhere((k, v) => v == null);
    var client = createDio();

    // client.options.headers["Content-Type"] = "application/json";
    client.interceptors.add(LogInterceptor());
    client.options.headers['Authorization'] = "Bearer "+authtoken!;
    // client.options.headers["Timezone"] = Timezone;
    //   print("--- header:---" + json.encode(client.options.headers));
    Response response;
    print("--- body:" + subUrl);
    try {
      response = await client.delete<String>(
        subUrl,
        data: body != null
            ? json.encode(body)
            : formData != null
                ? formData
                : null,
      );
      print(response);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        //  throw MyException(e.response.statusCode,e.response.statusMessage);
      } else {
        print(e.message);
        // throw MyException(e.response.statusCode,e.response.statusMessage);
      }
    }
  }

  static Future<Response?> pagination(
    String subUrl, {
    Map<String, dynamic>? params,
    String? authtoken,
    BuildContext? context,
  }) async {
/*    print(BASE_URL + subUrl);
    print("--- params:" + params.toString());
    print("------authoken"+authtoken);*/

    var client = createDio();
    client.options.headers["Accept"] = "application/json";

    client.options.headers["Content-Type"] = "application/json";
    if (authtoken != null){
      client.options.headers["Authorization"] = "Bearer " + authtoken;

    }

//    final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    //  client.options.headers["Timezone  "] = Timezone;
    final response = await client.get<String>(
      subUrl,
      queryParameters: params,
    );
    print("--- header:" + json.encode(client.options.headers));
    print(response);

    return response;
  }

  static Future<Response> get(String subUrl,
      {Map<String, dynamic>? params,
      String? authtoken,
      BuildContext? context,
      bool addBaseUrl = true}) async {
    print(params);
    var client = createDio();
    //   if (authtoken != null)

    log("query ${params.toString()}");

    if (authtoken != null) {

      client.options.headers["Authorization"] ="Bearer "+ authtoken;

    }


    //AppUtils.Snackbar("token", authtoken);
   // print("Header token"+ authtoken!);


    print(NetworkUtils.BASE_URL + subUrl);
    final response = await client.get<String>(
      addBaseUrl ? NetworkUtils.BASE_URL + subUrl : subUrl,
      queryParameters: params,
    );
    print("--- header:" + json.encode(client.options.headers));
    print(response);
    return response;
  }


  static Future<Response> getpagination(String subUrl,
      {Map<String, dynamic>? params,
        String? authtoken,
        BuildContext? context,
        bool addBaseUrl = true}) async {
    print(params);
    var client = createDio();
    //   if (authtoken != null)
    print("Token $authtoken");
    log("logToken $authtoken");
    log("query ${params.toString()}");



    client.options.headers["Authorization"] ="Bearer "+ authtoken!;
    //AppUtils.Snackbar("token", authtoken);
    print("Header token"+ authtoken!);


    print(NetworkUtils.BASE_URL + subUrl);
    final response = await client.get<String>(
      addBaseUrl ? NetworkUtils.BASE_URL + subUrl : subUrl,
      queryParameters: params,
    );
    print("--- header:" + json.encode(client.options.headers));
    print(response);
    return response;
  }


  static Future<Response> getWithoutContext(String subUrl,
      {Map<String, dynamic>? params,
      String? authtoken,
      bool addBaseUrl = true}) async {
    print(params);
    var client = createDio();
    //   if (authtoken != null)
    print("Token $authtoken");
    log("logToken $authtoken");
    log("query ${params.toString()}");
    print(NetworkUtils.BASE_URL + subUrl);

    client.options.headers["Authorization"] = authtoken;
    client.options.headers["date"] =
        "${DateTime.now().month.toString()..padLeft(2, "0")}-${DateTime.now().day.toString().padLeft(2, "0")}-${DateTime.now().year}";

    final response = await client.get<String>(
      addBaseUrl ? NetworkUtils.BASE_URL + subUrl : subUrl,
      queryParameters: params,
    );
    print("--- header:" + json.encode(client.options.headers));
    print(response);
    return response;
  }
}

class MyException {
  int statusCode;
  String message;

  MyException(this.statusCode, this.message);
}
