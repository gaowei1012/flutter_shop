import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 底部stack栏
class DetailBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          _leftIcon(),
          _addCart(),
          _immediatelyBuy()
        ],
      )
    );
  }

  Widget _leftIcon() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(80),
        width: ScreenUtil().setWidth(110),
        color: Colors.white,
        child: Icon(
          Icons.shopping_cart,
          size: 35,
          color: Colors.redAccent
        ),
      ),
    );
  }

  Widget _addCart() {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(320),
        height: ScreenUtil().setHeight(80),
        color: Colors.greenAccent,
        child: Text(
          '加入购物车',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(28)
          ),
        ),
      ),
    );
  }

  Widget _immediatelyBuy() {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(320),
        height: ScreenUtil().setHeight(80),
        color: Colors.redAccent,
        child: Text(
          '立即购买',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(28)
          ),
        ),
      ),
    );
  }
}