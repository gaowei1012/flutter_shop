import 'package:flutter/material.dart';
import '../service/service_method.dart';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    // _getCategory();
    return Scaffold(
      body: Container(
        child: Row(
          children: <Widget>[
            LefeCategoryNav(),
          ],
        ),
      ),
    );
  }
}

// 左侧大类导航
class LefeCategoryNav extends StatefulWidget {
  @override
  _LefeCategoryNavState createState() => _LefeCategoryNavState();
}

class _LefeCategoryNavState extends State<LefeCategoryNav> {

  List list = [];

  @override
  void initState() {
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 1,
            color: Colors.black12
          )
        )
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftInKewll(index);
        },
      )
    );
  }

  Widget _leftInKewll(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10.0, top: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12)
          )
        ),
        child: Text(list[index].mallCategoryName, style: TextStyle(fontSize: 16.0),),
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      // list.data.forEach((item) => print(item.mallCategoryName));
    });
  }
}