import 'package:flutter/material.dart';
import './components/left_category_nav.dart';
import './components/right_category_nav.dart';
import './components/category_goods.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoods(),
              ],
            )
          ],
        ),
      ),
    );
  }
}