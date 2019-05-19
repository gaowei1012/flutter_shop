import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '会员中心'
        ),
      ),
      body: ListView(
        children: <Widget>[
          _topHeader(),
          _orderTitle(),
          _orderType(),
          _actionList()
        ],
      ),
    );
  }

  Widget _topHeader() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(180),
            width: ScreenUtil().setWidth(180),
            margin: EdgeInsets.only(top: 30),
            child: ClipOval(
              child: Image.network('https://gaomingwei.xyz/wp-content/uploads/2019/04/8.jpg'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 10.0),
            child: Text('执念', style: TextStyle(color: Colors.black38, fontSize: ScreenUtil().setSp(36))),
          )
        ],
      ),
    );
  }

  Widget _orderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12
          )
        )
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      )
    );
  }

  Widget _orderType() {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(180),
            child: Column(
              children: <Widget>[
                Icon(Icons.party_mode, size: 30,),
                Text('待补款')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(180),
            child: Column(
              children: <Widget>[
                Icon(Icons.query_builder, size: 30,),
                Text('代发货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(180),
            child: Column(
              children: <Widget>[
                Icon(Icons.card_travel, size: 30,),
                Text('待收货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(180),
            child: Column(
              children: <Widget>[
                Icon(Icons.pages, size: 30,),
                Text('待评价')
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _myListTitle(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 1
          )
        )
      ),
      child: ListTile(
        leading: Icon(Icons.blur_circular),
        title: Text('${title}'),
        trailing: Icon(
          Icons.arrow_right
        ),
      ),
    );
  }

  Widget _actionList() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _myListTitle('领取优惠券'),
          _myListTitle('已领取优惠券'),
          _myListTitle('地址管理'),
          _myListTitle('客服电话'),
          _myListTitle('关于我们'),
        ],
      ),
    );
  }
}