import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:offersapp/api/model/BannersResponse.dart';
import 'package:offersapp/api/model/RegistrationResponse.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';
import 'PrettyDioLogger.dart';
import 'StringResponseConverter.dart';
import 'model/OffersData.dart';
import 'model/UserData.dart';

part 'restclient.g.dart';

const String BASE_URL = "https://macsof.in/advertiseApp/services/";
// const PLACE_HOLDER_PROFILE = "assets/images/profile_pic.png";

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  static Future<RestClient> getRestClient({BuildContext? context}) async {
    // LoginResponse? user = await AuthMethods().getUserDetails();
    BaseOptions options = new BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 60 * 1000 // 60 seconds
        );
    // String baseUrl = FlavorConfig.instance.variables["baseUrl"];
    // print(baseUrl);
    options.baseUrl = BASE_URL;
    final dio = Dio(options);
    dio.interceptors.clear();
    dio.interceptors.add(StringResponseConverter());
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options); //modify your request
        },
        onResponse: (response, handler) {
          if (response != null) {
            //on success it is getting called here
            return handler.next(response);
          } else {
            return null;
          }
        },
        onError: (DioError e, handler) async {
          if (e.response != null) {
            if (e.response?.statusCode == 401) {
              if (context != null) {
                // print("Token Expired. Logged out.");
                showSnackBar(context, "Token Expired. Logged out.");
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('user');
                //Provider.of<UserProvider>(context, listen: false).logout();
              }
              return null;
            }
          }
          // try{
          //   DioError err = e as DioError;
          //   var message = ResponceMessage.fromJson(json.decode(err.response!.data));
          //   APIException(message);
          //   return handler.next(e);
          // }catch(e1){
          //   return handler.next(e1);
          // }

          return handler.next(e);
        },
      ),
    );
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: false,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
    }

    dio.options.headers["auth-key"] = "earncashRestApi";
    final client = RestClient(dio);
    return client;
  }

  //===User management [START]

  @POST("users/login")
  Future<UserData> doLogin(@Body() Map<String, String> loginRequestBody);

  @POST("users/create")
  Future<RegistrationResponse> doRegister(@Body() Map<String, String> loginRequestBody);

  @GET("offers/getOffers")
  Future<List<OffersData>> getOffers();

  @GET("offers/getBanner")
  Future<BannersResponse> getBanners();
}
