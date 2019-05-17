import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../../provide/goods_detail_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailExplan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 15.0),
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(15.0),
      child: Text(
        '说明>百姓+>正品保证',
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: ScreenUtil().setSp(30)
        )
      ),
    );
  }
}