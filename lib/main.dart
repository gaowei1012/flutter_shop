import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
// import './provide/count.dart';
import './provide/child_category.dart';
import './provide/category_good_list.dart';
import './provide/goods_detail_info.dart';
import 'package:fluro/fluro.dart';
import './routers/router.dart';
import './routers/application.dart';

void main() {
  // 添加provider状态管理
  // var counter = Counter();
  var childCategory = ChildCategory();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var goodsDetailInfoProvide = GoodsDetailInfoProvide();
  var providers = Providers();
  providers
    // ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<GoodsDetailInfoProvide>.value(goodsDetailInfoProvide));
  runApp(ProviderNode(child: MyApp(), providers: providers,));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // 配置路由
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false, // 关闭debggr模式
        theme: ThemeData(
          primaryColor: Colors.pinkAccent
        ),
        home: IndexPage(),
      ),
    );
  }
}

