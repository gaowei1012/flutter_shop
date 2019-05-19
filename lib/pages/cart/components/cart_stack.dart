import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../../provide/cart.dart';

class CartBottomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Provide<CartProvide>(
        builder: (context, child, val) {
          return Row(
            children: <Widget>[
              _cartSelectBt(context),
              _allPrice(context),
              _guBottom(context)
            ],
          );
        },
      ),
    );
  }

// 左边的全选组件
  Widget _cartSelectBt(context) {
    bool isOrCheck = Provide.value<CartProvide>(context).isOrCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isOrCheck,
            activeColor: Colors.pink,
            onChanged: (bool val) {
              Provide.value<CartProvide>(context).changeOrCheckBtState(val);
            },
          ),
          Text(
            '全选'
          )
        ],
      ),
    );
  }

  Widget _allPrice(context) {
    double allPrice = Provide.value<CartProvide>(context).allPrice;
    return Container(
      width: ScreenUtil().setWidth(430),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  '合计:',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36)
                  )
                )
              ),
              Container(
                width: ScreenUtil().setWidth(150),
                alignment: Alignment.centerLeft,
                child: Text(
                  '￥${allPrice}',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36),
                    color: Colors.redAccent
                  )
                ),
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免费配送，预购免费配送',
              style: TextStyle(
                color: Colors.black38,
                fontSize: ScreenUtil().setSp(22)
              )
            ),
          )
        ],
      ),
    );
  }

// 结算按钮
  Widget _guBottom(context) {
    int allGoodsCount = Provide.value<CartProvide>(context).allGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(
            '结算(${allGoodsCount})',
            style: TextStyle(color: Colors.white)
          ),
        ),
      ),
    );
  }
}