import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../provide/category_good_list.dart';
import '../../../provide/child_category.dart';
import '../../../service/service_method.dart';
import '../../../model/category_goods.dart';
import 'dart:convert';


class CategoryGoods extends StatefulWidget {
  @override
  _CategoryGoodsState createState() => _CategoryGoodsState();
}

class _CategoryGoodsState extends State<CategoryGoods> {

  GlobalKey<RefreshFooterState> _footerkey = new GlobalKey<RefreshFooterState>();

  var scrollContoller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        // 高度溢出bug
        // 解决没有数据时bug
        // 解决无法返回顶部问题
        try {
          if (Provide.value<ChildCategory>(context).page == 1) {
            // 列表位置，放到最上面
            scrollContoller.jumpTo(0.0);
          }
        } catch(e) {
          print('进入页面,初始化${e}');
        }
        if (data.goodsList.length > 0) {
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              // height: ScreenUtil().setHeight(980),
              child: EasyRefresh(
                refreshFooter: ClassicsFooter(
                  key: _footerkey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  noMoreText: Provide.value<ChildCategory>(context).noMoreText, // no more Text
                  moreInfo: '加载中',
                  loadReadyText: '上拉加载', 
                ),
                child: ListView.builder(
                  controller: scrollContoller,
                  itemCount: data.goodsList.length,
                  itemBuilder: (context, index) {
                  return _inkWellList(data.goodsList ,index);
                  },
                ),
                loadMore: () async {
                  print('开始加载更多数据');
                  _getMoreList();
                },
              ),
            ),
          );
        } else {
          // 没有数据bug友好提示
          return Text('暂时没有数据...');
        }
      },
    );
  }

  Widget _inkWellList(List newList, int index) {
    return InkWell(
      onTap: () { },
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12
            )
          )
        ),
        child: Row(
          children: <Widget>[
            _goodsImag(newList ,index),
            Column(
              children: <Widget>[
                _goodsName(newList, index),
                _goodsPrice(newList, index)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _goodsImag(List newList ,index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  Widget _goodsName(List newList ,index) {
    return Container(
      width: ScreenUtil().setWidth(370),
      padding: EdgeInsets.all(5.0),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28.0)),
      ),
    );
  }

  Widget _goodsPrice(List newList ,index) {
    return Container(
      width: ScreenUtil().setWidth(370),
      margin: EdgeInsets.only(top: 28.0),
      child: Row(
        children: <Widget>[
          Text(
            '价格: ￥${newList[index].presentPrice}',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil().setSp(30.0)
            ),
          ),
          Text(
            '￥${newList[index].oriPrice}',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough // 删除线
            ),
          )
        ],
      ),
    );
  }

  // 下拉加载更多
  void _getMoreList() async {
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId, // 拿到大类的ID
      'categorySubId': Provide.value<ChildCategory>(context).subId, // 拿到子类ID
      'page': Provide.value<ChildCategory>(context).page, // 页数
    };
    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel categoryGoodsList = CategoryGoodsListModel.fromJson(data);
      if (categoryGoodsList.data == null) {
        Fluttertoast.showToast(
          msg: '没有更多了^_^!!!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0
        );
        //    Provide.value<ChildCategory>(context).changeNoMore('没有更多数据了^_^!!!');
      } else {
        Provide.value<CategoryGoodsListProvide>(context).getMoreList(categoryGoodsList.data);
      }
    });
  }
}