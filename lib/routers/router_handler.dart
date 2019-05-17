import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details/detalis_page.dart';

// 路由规则
// detailsHandler
Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String goodsId = params['id'].first;
    print('index>details>goods is ${goodsId}');
    return DetailsPage(goodsId);
  }
);
