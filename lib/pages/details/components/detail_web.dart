import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../provide/goods_detail_info.dart';

class DetailWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetails = Provide.value<GoodsDetailInfoProvide>(context).goodsInfo.data.goodInfo.goodsDetail;

    return Provide<GoodsDetailInfoProvide>(
      builder: (context, child, val) {
        var isLeft = Provide.value<GoodsDetailInfoProvide>(context).isLeft;
        if (isLeft) {
          return Container(
            child: Html(
              data: goodsDetails,
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 15.0),
            width: ScreenUtil().setWidth(750),
            child: Text(
              '暂时没有数据...'
            ),
          );
        }
      },
    ); 
  }
}