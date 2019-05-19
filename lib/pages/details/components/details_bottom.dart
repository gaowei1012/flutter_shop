import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../../provide/goods_detail_info.dart';
import '../../../provide/cart.dart';

// 底部stack栏
class DetailBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 取得数据
    var goodsInfo = Provide.value<GoodsDetailInfoProvide>(context).goodsInfo.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.presentPrice;
    var images = goodsInfo.image1;


    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
              height: ScreenUtil().setHeight(80),
              width: ScreenUtil().setWidth(110),
              color: Colors.white,
              child: Icon(
                Icons.shopping_cart,
                size: 25,
                color: Colors.redAccent,
              ),
            )
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context).save(goodsId, goodsName, count, price, images);
            },
            child: Container(
              alignment: Alignment.center,
              height: ScreenUtil().setHeight(80),
              width: ScreenUtil().setWidth(320),
              color: Colors.greenAccent,
              child: Text(
                '添加购物车',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Colors.white
                )
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context).remove();
            },
            child: Container(
              alignment: Alignment.center,
              height: ScreenUtil().setHeight(80),
              width: ScreenUtil().setWidth(320),
              color: Colors.redAccent,
              child: Text(
                '立即购买',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Colors.white
                )
              ),
            ),
          )
        ],
      )
    );
  }
}