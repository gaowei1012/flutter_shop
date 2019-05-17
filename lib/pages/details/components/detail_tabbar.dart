import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../provide/goods_detail_info.dart';

class DetailTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailInfoProvide>(
      builder: (context, child, val) {
        var isLeft = Provide.value<GoodsDetailInfoProvide>(context).isLeft;
        var isRight = Provide.value<GoodsDetailInfoProvide>(context).isRight;

        return Container(
          margin: EdgeInsets.only(top: 15.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _myTabbarLeft(context, isLeft),
                  _myTabbarRight(context, isRight)
                ],
              )
            ],
          )
        );
      },
    );
  }

// 左侧tabbar
  Widget _myTabbarLeft(context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provide.value<GoodsDetailInfoProvide>(context).changTabbarLeftAndRight('left');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(370.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isLeft?Colors.pink:Colors.black12
            )
          )
        ),
        child: Text(
          '详情',
          style: TextStyle(
            color: isLeft?Colors.pink:Colors.black,
          ),
        ),
      ),
    );
  }

// 右侧tabbar
  Widget _myTabbarRight(context, bool isRight) {
    return InkWell(
      onTap: () {
        Provide.value<GoodsDetailInfoProvide>(context).changTabbarLeftAndRight('right');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(370.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: isRight?Colors.pink:Colors.black12
            )
          )
        ),
        child: Text(
          '评论',
          style: TextStyle(
            color: isRight?Colors.pink:Colors.black
          ),
        ),
      ),
    );
  }
}