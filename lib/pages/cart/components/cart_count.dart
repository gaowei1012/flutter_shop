import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../../provide/cart.dart';
import '../../../model/cartInfo.dart';

class CartCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black12
        )
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(),
          _content(),
          _addBtn()
        ],
      ),
    );
  }

  // 减少按钮
  Widget _reduceBtn() {
    return Container(
      child: InkWell(
        onTap: () {},
        child: Container(
          width: ScreenUtil().setHeight(45),
          height: ScreenUtil().setHeight(45),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              right: BorderSide(
                width: 1,
                color: Colors.black12
              )
            )
          ),
          child: Text('-')
        ),
      ),
    );
  }

  // 加号按钮
  Widget _addBtn() {
    return Container(
      child: InkWell(
        onTap: () {},
        child: Container(
          width: ScreenUtil().setHeight(45),
          height: ScreenUtil().setHeight(45),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(
                width: 1,
                color: Colors.black12
              )
            )
          ),
          child: Text('+')
        ),
      ),
    );
  }

  // count 显示区域
  Widget _content() {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(
        '12',
      ),
    );
  }
}