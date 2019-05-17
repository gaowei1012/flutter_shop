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
