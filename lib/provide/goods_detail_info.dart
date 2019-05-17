import 'package:flutter/material.dart';
import '../service/service_method.dart';
import '../model/goods_detail.dart';
import 'dart:convert';

class GoodsDetailInfoProvide with ChangeNotifier {

  GoodsDetailModel goodsInfo = null;

  bool isLeft = true;
  bool isRight = false;

  // tabbar 切换状态
  changTabbarLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }

    notifyListeners();
  }
  
  // 获取详细商品数据方法
  getGoodsDetailInfo(String id) async {
    var data = {
      'goodId': id,
    };
    await request('getGoodDetailById', formData: data).then((val) {
      var responseData = json.decode(val.toString());
      print(responseData);
      goodsInfo = GoodsDetailModel.fromJson(responseData);
      notifyListeners();
    });
  }
}