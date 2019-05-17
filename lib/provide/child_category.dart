import 'package:flutter/material.dart';
import '../model/category.dart';

// count 类 混入
class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; // 子类高亮
  String categoryId = '4'; // 大类ID
  String subId = ''; // 小类
  int page = 1; // 列表页数
  String noMoreText = ''; // 显示没有数据的文字

  getChildCategory(List<BxMallSubDto> list, String id) {
    page = 1;
    noMoreText = '';
    childIndex = 0;
    categoryId = id;
    // subId = id;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '11';
    all.comments = null;
    all.mallSubName = '全部';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  // 改变子类索引
  changeChildIndex(index, {String id}) {
    page = 1;
    noMoreText = '';
    childIndex = index;
    subId = id;
    notifyListeners();
  }

  // 增加PAge的方法
  addPage() {
    page++;
    // notifyListeners();
  }

  // 改变nomore
  changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
