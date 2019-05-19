import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../../provide/cart.dart';

class CartCount extends StatelessWidget {
  var item;
  CartCount(this.item);

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
          _reduceBtn(context),
          _content(context),
          _addBtn(context)
        ],
      ),
    );
  }

  // 减少按钮
  Widget _reduceBtn(context) {
    return Container(
      child: InkWell(
        onTap: () {
          Provide.value<CartProvide>(context).addOrReducerAction(item, 'redcue');
        },
        child: Container(
          width: ScreenUtil().setHeight(45),
          height: ScreenUtil().setHeight(45),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              right: BorderSide(
                width: 1,
                color: item.count>1?Colors.black12:Colors.black12
              )
            )
          ),
          child: item.count>1 ? Text('-') : Text('')
        ),
      ),
    );
  }

  // 加号按钮
  Widget _addBtn(context) {
    return Container(
      child: InkWell(
        onTap: () {
          Provide.value<CartProvide>(context).addOrReducerAction(item, 'add');
        },
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
  Widget _content(context) {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(
        '${item.count}',
      ),
    );
  }
}