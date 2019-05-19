import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          // 拿到Provide中的cartList数据
          List cartList = Provide.value<CartProvide>(context).cartList;
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                return ListTile(// title
                  title: Text(
                    cartList[index].goodsName
                  ),
                );
              },
            );
          } else {
            return Text('正在加载中...');
          }
        },
      )
    );
  }

// 获取存在provide中购物车的数据
  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }

}
