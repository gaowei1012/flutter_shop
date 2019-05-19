import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cartInfo.dart';

class CartProvide with ChangeNotifier {
  String cartString = '[]';
  List<CartInfoModel> cartList = [];

// 保存商品数据
  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');// key

    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();// 转换list

    bool isHave = false;
    int ival = 0;

    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count']+1;
        // 数据模型
        cartList[ival].count+1;
        isHave = true;
      }

      ival+1; // 索引递增
    });

// 如果没有值， 则添加
    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods)); // 模型的fromdata
    }

    cartString = json.encode(tempList).toString();
    print(cartString);
    prefs.setString('cartInfo', cartString);// 持久化数
    print('数据模型>>>${cartList}');

    notifyListeners(); // 发射数据
  } 

  // 清空商品数据
  remove() async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartList = []; // 清空模型数据
    print('清空完成........');

    notifyListeners();
  }
}