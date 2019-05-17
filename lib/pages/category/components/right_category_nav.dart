import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:provide/provide.dart';
import '../../../service/service_method.dart';
import '../../../model/category.dart';
import '../../../model/category_goods.dart';
import '../../../provide/child_category.dart';
import '../../../provide/category_good_list.dart';

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory) {
        return Container(
          child: Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(570),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.black12
                )
              )
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context, index) {
                return _rightInkWell(index ,childCategory.childCategoryList[index]);
              },
            ),
          ),
        );
      },
    );
    
    
  }

  Widget _rightInkWell(int index, BxMallSubDto item) {
    // 判断按钮是否被点击了
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategory>(context).childIndex) ? true : false;

    return InkWell(
      onTap: () {
        // 子类字体颜色切换
        Provide.value<ChildCategory>(context).changeChildIndex(index);
        _getCategoryGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 8.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28.0),
            color: isClick ? Colors.pink : Colors.black
          ),
        ),
      ),
    );
  }

  // 修改子类是否被选中
  void _getCategoryGoodsList(String categorySubId) async {
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId, // 拿到大类的ID
      'categorySubId': categorySubId,
      'page': 1
    };
    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel categoryGoodsList = CategoryGoodsListModel.fromJson(data);
      if (categoryGoodsList.data == null) {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList(categoryGoodsList.data);
      }
    });
  }
}