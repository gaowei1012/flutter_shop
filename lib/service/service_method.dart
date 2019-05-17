import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

// 数据请求接口方法
Future request(url, {formData}) async {
  try {
    print('开始获取数据.........');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端数据接口出现问题');
    }

  } catch(e) {
    return print('ERROR: =====================> ${e}');
  }
}

// 获取首页主体内容
Future getHomePageContent() async {
  try {
    print('开始获取首页数据.........');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    // dio.options.connectTimeout = 5000;
    // dio.options.receiveTimeout = 3000;
    var formData = {'lon': '115.02932' , 'lat': '35.76189'};
    response = await dio.post(servicePath['homePageContent'], data: formData);
    if (response.statusCode == 200) {
      // print(response.data);
      return response.data;
    } else {
      throw Exception('获取后端数据出错.....');
    }
  } catch(e) {
    return print('ERROR: ============> ${e}'); 
  }
}

// 获得火爆专区内容
Future getCategory() async{
  try {
    print('开始获取首页火爆专区数据.........');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    response = await dio.post(servicePath['getCategory']);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('获取后端数据出错.....');
    }
  } catch(e) {
    return print('ERROR: ===========>${e}');
  }
}