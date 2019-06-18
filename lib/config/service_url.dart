const serviceUrl = 'http://v.jspang.com:8088/baixing/';
// const serviceUrl = 'http://localhost:3001/';
const servicePath  = {
  'homePageContent': serviceUrl + 'wxmini/homePageContent', //商店页面详情
  'homePageBelowConten': serviceUrl + 'wxmini/homePageBelowConten', // 商城首页火爆专区
  'getCategory': serviceUrl + 'wxmini/getCategory', // 商品类别信息
  'getMallGoods': serviceUrl + 'wxmini/getMallGoods', // 商品分类商品列表
  'getGoodDetailById': serviceUrl + 'wxmini/getGoodDetailById', // 商品描述详细页
};

// const servicePath = {
//   'homePageContent': serviceUrl + 'home/getHomePages',
//   'homePageBelowConten': serviceUrl + 'home/getHotsAll',
//   'getCategory': serviceUrl + 'category/getCategory',
//   'getMallGoods': serviceUrl + 'category/getMallGoods',
//   'getGoodDetailById': serviceUrl + 'category/getGoodsDetailById'
// };
