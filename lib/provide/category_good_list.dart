import 'package:flutter/material.dart';
import '../model/category_goods.dart';

// count 类 混入
class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryGoodsData> goodsList = [];

  // 点击大类更换商品列表
  getGoodsList(List<CategoryGoodsData> list) {
    goodsList = list;
    notifyListeners();
  }

  // 子类
  getMoreList(List<CategoryGoodsData> list) {
    goodsList.addAll(list);
    notifyListeners();
  }
}