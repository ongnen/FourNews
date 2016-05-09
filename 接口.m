
github地址 https://github.com/ongnen/FourNews

1"首页新闻模块
// 获取子模块的参数tid
http://c.m.163.com/nc/topicset/ios/subscribe/manage/listspecial.html
// 获取子模块新闻列表
http://c.3g.163.com/nc/article/headline/%@/0-20.html
参数tid 示例 头条T1348647853363
// 拿到新闻详情的接口
http://c.m.163.com/nc/article/%@/full.html
参数docid
// 评论的接口
http://comment.api.163.com/api/json/post/list/new/normal/%@/%@/desc/0/10/10/2/2 参数1boardid 参数2docid
热评接口
http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2 参数1boardid 参数2docid
// 图集评论的接口
http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2 参数1boardid 参数2postid

// 图集详情接口 "photosetID":"00AP0001|115032", 参数1 0001 参数2 115032
http://c.m.163.com/photo/api/set/%@/%@.json

// 搜索
http://c.3g.163.com/search/comp/MA==/20/%@.html
/**************************************华丽分割线*******************************************/

2"阅读模块接口
主界面接口返回一个新闻列表,其余接口和首页一致
http://c.3g.163.com/recommend/getSubDocPic?from=yuedu&passport=&devId=MXMBjPFGwQtsVvvyqiU4T%2FwBdkQM4meyMjoBvP7QRADOvWNXF4MglqFoOcM%2Fy4na&size=30&version=5.6.0&spever=false&net=wifi&lat=&lon=&ts=1460206079&sign=OSD0%2FJHZ9TcMrgys4VRhqKQkwU5u9%2Fv0n4Dzzr8TzIl48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore


/**************************************华丽分割线*******************************************/

3"视频模块接口
// 获取子模块的参数
http://c.m.163.com/nc/video/topiclist.html
返回示例
[{"tname":"推荐","tid":"T1457068979049"},{"tname":"搞笑","tid":"T1457069041911"},{"tname":"美女","tid":"T1457069080899"},{"tname":"新闻现场","tid":"T1457069205071"},{"tname":"萌物","tid":"T1457069232830"},{"tname":"八卦","tid":"T1457069261743"},{"tname":"猎奇","tid":"T1457069319264"},{"tname":"体育","tid":"T1457069346235"},{"tname":"黑科技","tid":"T1457069387259"},{"tname":"涨姿势","tid":"T1457069475980"},{"tname":"二次元","tid":"T1457069446903"},{"tname":"军武","tid":"T1457069421892"}]
// 拼接参数实例
http://c.m.163.com/nc/video/Tlist/%@/0-10.html
参数tid

/**************************************华丽分割线*******************************************/

4"话题模块接口
http://c.m.163.com/newstopic/list/expert/0-10.html 返回第0-第10条的数据
话题详情接口
http://c.m.163.com/newstopic/qa/%@.html  参数expertId
评论接口
http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2 参数1board 参数2commentId