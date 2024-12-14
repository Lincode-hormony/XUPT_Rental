# 规范

## 网络获取数据

1. 定义首页的整体数据类Model（API结果复制，然后依次定义每一个类，数组：IPlanList，元素：IPlanItem）

1. 定义获取数据API（api文件夹内）getHomeDataApi
   此处只返回首页的**整体数据**

1. Home.ets文件内定义各元素（用@State装饰）getHomeData匿名函数，在匿名函数内，通过API获取的整体数据来给每一一个数据赋值
   此处把整体数据进行拆分成各个元素
   因为各个元素要在Home.ets文件内（组件内）用@State装饰，所以需要在这里进行拆分

1. 在aboutAppear中调用getHomeData函数

为什么不把getHomeDataApi函数定义在Home.ets文件内呢？

- 因为这个API接口在其他文件中可能也需要使用；包括其他API，所以我们把这些API都定义到一个文件夹中的不同文件中去，就方便后续重复利用

- 虽然定义在自定义组件的文件中也可以导出，但是个人感觉这种写法把自定义组件弄的太复杂了，而且后续要用的时候，这个API和自定义组件的文件名没有联系，也不好找

Item用interface类型定义，List用type定义



## 公共模块

- 首选项 

- 关系型数据库 Rdb

- 日志 

- 网络访问 axios  

- 共用组件 uiComponent

- 路由管理 RouterModel

## Other

- 命名规范 

- Model 
- mine  discover	 map  roomList home



# Home

作者：HLQ

1. 实现了首页的轮播图，八个房源推荐
2. 房源更多推荐里面的数据列表使用懒加载瀑布流实现
3. 房源列表可以按照多种方式筛选
4. 房间详情页面绘制完成

# Discover	

作者：LQJ

内容：

# Map	

共同

# bookList	

作者：HLQ

1. 页面基本绘制完成

# Mine

作者：LQJ

1. 实现登录功能，使用路由push到mine_login页面即可开始登录功能。
