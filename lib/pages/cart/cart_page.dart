import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';
import './components/cart_item.dart';
import './components/cart_stack.dart';

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
            return Stack(
              children: <Widget>[
                // 通过provide拿数据过来
                Provide<CartProvide>(
                  builder: (context, child, childCatgory) {
                    cartList = Provide.value<CartProvide>(context).cartList;
                    return ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        return CartItemPage(cartList[index]);
                      },
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CartBottomPage(),
                )
              ],
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
