import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../service/service_method.dart';
import '../routers/application.dart';
import 'dart:convert';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  int page = 1;
  List<Map> hotGoodsList = [];

  GlobalKey<RefreshFooterState> _footerkey = new GlobalKey<RefreshFooterState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() { 
    super.initState();
    // _getHotGoods();
    print('页面重新加载');
  }

  String homePageContent = '正在获取数据';

  @override
  Widget build(BuildContext context) {
    var formData = {'lon': '115.02932' , 'lat': '35.76189'};
    return Scaffold(
      body: FutureBuilder(
        future: request('homePageContent', formData: formData),
        builder: (context, snapshot) {
          // hasData == true
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navigationList = (data['data']['category'] as List).cast();
            String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            List<Map> recommendList = (data['data']['recommend'] as List).cast();
            String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
            String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
            List<Map> floor1 = (data['data']['floor1'] as List).cast();
            List<Map> floor2 = (data['data']['floor2'] as List).cast();
            List<Map> floor3 = (data['data']['floor3'] as List).cast();
            return EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerkey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                noMoreText: '', // no more Text
                moreInfo: '加载中',
                loadReadyText: '上拉加载',
              ),
              child: ListView(
                children: <Widget>[
                  SwiperDiy(swiperDateList: swiper),
                  TopNavigator(navigatorList: navigationList),
                  AdBanner(adPicture: adPicture),
                  LeaderPhone(leaderImage: leaderImage, leaderPhone: leaderPhone),
                  Recommend(recommendList: recommendList),
                  FloorTitle(picture_address: floor1Title),
                  FloorContent(floorContentList: floor1),
                  FloorTitle(picture_address: floor2Title),
                  FloorContent(floorContentList: floor2),
                  FloorTitle(picture_address: floor3Title),
                  FloorContent(floorContentList: floor3),
                  _hotGoods(),
                ],
              ),
              loadMore: () async {
                print('开始加载更多.....');
                var formPage = {'page': page};
                await request('homePageBelowConten', formData: formPage).then((val) {
                  var data = json.decode(val.toString());// 格式化数据
                  List<Map> newGoodsList = (data['data'] as List).cast();
                  setState(() {
                    hotGoodsList.addAll(newGoodsList);
                    page ++;
                  });
                }); 
              }
            );
          } else {
            return Center(
              child: Text('加载中...'),
            );
          }
        },
      )
    );
  }

  // 火爆专区数接口数据
  // void _getHotGoods() {
  //   var formPage = {'page': page};
  //   request('homePageBelowConten', formData: formPage).then((val) {
  //     var data = json.decode(val.toString());// 格式化数据
  //     List<Map> newGoodsList = (data['data'] as List).cast();
  //     setState(() {
  //       hotGoodsList.addAll(newGoodsList);
  //       page ++;
  //     });
  //   }); 
  // }

  // 火爆专区标题
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center, // 居中对齐
    color: Colors.transparent, // 背景色为透明
    child: Text('火爆专区'),
  );

  // 火爆专区内容
  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {
            // 跳转到详情页面
            print(val);
            Application.router.navigateTo(context, '/details?id=${val['goodsId']}');
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(top: 3.0, bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(val['image'], width: ScreenUtil().setWidth(370)),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(26))
                ),
                Row(
                  children: <Widget>[
                    Text('￥${val['mallPrice']}'),
                    Text(
                      '￥${val['price']}',
                        style: TextStyle(
                          color: Colors.black26, // 线颜色
                          decoration: TextDecoration.lineThrough // 下划线
                        ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();

      // 流式布局
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  Widget _hotGoods() {
    return Column(
      children: <Widget>[
        hotTitle,
        _wrapList()
      ],
    );
  }

}

// 首页轮播
class SwiperDiy extends StatelessWidget {

  final List swiperDateList;
  SwiperDiy({ Key key, this.swiperDateList }):super(key: key);

  @override
  Widget build(BuildContext context) {
    // 这块使用iphone6的屏幕尺寸作为设计稿的
    // ScreenUtil.instance = ScreenUtil(height: 1334,width: 750)..init(context);

    // 获取设备值
    // print('设备像素密度${ScreenUtil.pixelRatio}');
    // print('设备宽度${ScreenUtil.screenWidth}');
    // print('设备高度${ScreenUtil.screenHeight}');

    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network("${swiperDateList[index]['image']}", fit: BoxFit.fill);
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

// 首页导航
class TopNavigator extends StatelessWidget {

  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}):super(key: key);

  Widget _gridWiewItemUI(BuildContext context, item) {

    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 当超出长度时，删掉多余的
    if (this.navigatorList.length>10) {
      this.navigatorList.removeRange(10, navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(), // 禁止滚动
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridWiewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

// 首页广告栏
class AdBanner extends StatelessWidget {

  final String adPicture;

  AdBanner({Key key, this.adPicture}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      child: Image.network(adPicture),
    );
  }
}

// 拨打电话
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL, // 拨打电话
        child: Image.network(leaderImage),
      ),
    );
  }

  // 拨打电话
  void _launchURL() async {
    // String url = 'tel:' + leaderPhone;
    String url = 'https://gaomingwei.xyz';
    print(url);
    if (await canLaunch(url)){
      await launch(url);
    } else {
      throw 'url不能进行访问，异常';
    }
  }
}

// 商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({Key key, this.recommendList}):super(key: key);

  // 标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black12)
        )
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink)
      ),
    );
  }

  // 商品单独项
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5, color: Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey
                ),
            )
          ],
        ),
      ),
    );
  }

  // 横向列表
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(340),
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // 横向
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(400),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList()
        ],
      ),
    );
  }
}

// 商品楼层标题
class FloorTitle extends StatelessWidget {

  final String picture_address;

  FloorTitle({Key key, this.picture_address}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(picture_address),
    );
  }
}

// 商品列表
class FloorContent extends StatelessWidget {

  final List floorContentList;

  FloorContent({Key key, this.floorContentList}):super(key: key);

  Widget _otherGoods() {
    return Row(
      children: <Widget>[
        _goodsItem(floorContentList[3]),
        _goodsItem(floorContentList[4]),
      ],
    );
  }

  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          print('点击了楼层商品');
        },
        child: Image.network(goods['image']),
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorContentList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorContentList[1]),
            _goodsItem(floorContentList[2]),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods()
        ],
      ),
    );
  }
}

// 火爆专区
class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}
// 火爆专区
class _HotGoodsState extends State<HotGoods> {

  void initState() { 
    super.initState();
    request('homePageBelowConten', formData: 1).then((val) {
      print(val);
    });    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('hotGoods'),
    );
  }
}
