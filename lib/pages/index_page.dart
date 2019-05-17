import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './home_page.dart';
import './cart_page.dart';
import './member_page.dart';
// import './category_page.dart';
// import './cart/cart_page.dart';
import './category/category_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  // 定义底部tabs栏
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车')
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.padlock_solid),
      title: Text('会员中心')
    )
  ];

  // tab对应页面
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];
  // 当前选择
  int currentIndx = 0;
  // 选择的页面
  var currentPage;

  @override
  void initState() {
    currentPage = tabBodies[currentIndx];    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 初始化 ScreenUtil
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndx,
          items: bottomTabs,
          onTap: (index) {
            // 改变刷新UI
            setState(() {
              currentIndx = index;
              currentPage = tabBodies[index];
            });
          },
        ),
        body: IndexedStack(
          index: currentIndx,
          children: tabBodies,
        )
      )
    );
  }
}