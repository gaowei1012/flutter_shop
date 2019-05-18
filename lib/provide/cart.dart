import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier {
  String cartString = '[]';

// 保存数据
  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');// key
    var temp = cartString = null ? [] : json.decode(cartString);
    List<Map> tempList = (temp as List).cast();// 转换list
    bool isHave = false;
    int ival = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count']++;
        isHave = true;
      }
      ival++; // 索引递增
    });

// 如果没有值， 则添加
    if (!isHave) {
      tempList.add({
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images
      });

      notifyListeners();
    }

    cartString = json.encode(tempList).toString();
    print(cartString);
    prefs.setString('cartInfo', cartString);// 持久化数
  } 

  // 清空数据
  remove() async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    print('清空完成........');

    notifyListeners();
  }
}