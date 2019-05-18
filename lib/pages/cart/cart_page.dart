import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; 

/**
 * shared_preferences 实现数据持久化
 * 一般性步骤：
 *  初始化
 *  赋值
 *  读取值
 *  删除值
 */
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<String> testList = [];

  @override
  Widget build(BuildContext context) {
    _show();
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 300.0,
            child: ListView.builder(
              itemCount: testList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(testList[index]),
                );
              },
            ),
          ),
          RaisedButton(
            onPressed: () {
              _add();
            },
            child: Text('增加'),
          ),
          RaisedButton(
            onPressed: () {
              _clear();
            },
            child: Text('删除'),
          )
        ],
      ),
    );
  }

  void _add() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String temp = 'hello test';
    testList.add(temp);
    prefs.setStringList('testInfo', testList);
    _show();
  }

  void _show() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('testInfo') != null) {
      setState(() {
        testList = prefs.getStringList('testInfo');
      });
    }
  }

  void _clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear(); // 删除全部 慎用
    prefs.remove('testInfo');
    setState(() {
      testList = [];
    });

  }
}