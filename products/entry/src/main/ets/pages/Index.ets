import {Home} from 'home'
import {Discover} from 'discover'
import {Map} from 'map'
import {Mine} from 'mine'
import {LikePage} from 'like'
import {BookList} from 'booklist'
import {PreferencesUtil} from '@pura/harmony-utils'
import { RoomPage } from 'home/src/main/ets/views/RoomPage'
import { RoomList } from 'home/src/main/ets/views/RoomList'
import { RouterUtil } from 'router/src/main/ets/utils/RouterUtil'
import { RouterNameConstants } from 'router/src/main/ets/constants/RouterConstants'

//用于存放Token的全局变量
AppStorage.setOrCreate('Token','暂无用户数据')
AppStorage.setOrCreate('Phone','')// HLQ 用户区别用户的收藏列表
@Entry
@Component
struct Index {
  /**
   * 定义相应的NavPathStack，供其他模块使用
   */
  @Provide('homePathStack') homePathStack:NavPathStack=new NavPathStack()
// <<<<<<< HEAD  冲突的部分只作注释，没有删除
  @Provide("TabsCurIndex") curIndex:number=0
  // @Watch("createLikePreference") @StorageProp("Token")


  aboutToAppear(): void {
    //将创建的页面栈注册到路由模块，这个栈就归这个路由模块管理，无需@Provide
    RouterUtil.registerRouter(RouterNameConstants.ENTRY_HAP,this.homePathStack)
    this.createLikePreference()
  }


  createLikePreference(){
    let userPhone:string=''+AppStorage.get("Phone")
    if(userPhone) PreferencesUtil.init('Like'+userPhone);//收藏的首选项
  }

  @Builder
  routerMap(builderName:string,param:object){
    RouterUtil.getBuilder(builderName).builder(param)
  }
  /**
   * 路由表
   */
  @Builder
  homeRouter(name:string,id:string){
    if(name==='RoomPage'){
      RoomPage({roomId:id})
    }
    else if(name==='RoomList'){
      RoomList()
    }
  }

// =======

  // @State curIndex:number=0;
// >>>>>>> 3a27f7e0704916c266650df3cc7187821bf8b5dc
  /**
   * Tabs的Bar
   */
  @Builder tabBar(image:Resource,activeimage:Resource,name:string,index:number){
    Column(){
      Image(this.curIndex===index?activeimage:image)
        .width(20)
        .height(20)
      Text(name)
        .fontSize(10)
    }
  }



  build() {
    Navigation(this.homePathStack){
      Tabs({ barPosition: BarPosition.End,index:this.curIndex}) {
        TabContent() {
          Home()
        }.tabBar(this.tabBar($r('app.media.tabbar_home'), $r('app.media.tabbar_home_active'), '首页', 0))

        TabContent() {
          Discover()
        }.tabBar(this.tabBar($r('app.media.tabbar_discover'), $r('app.media.tabbar_discover_active'), '发现', 1))

        TabContent() {
          //LikePage()//收藏   地图搞不出来
        }.tabBar(this.tabBar($r('app.media.tabbar_service'), $r('app.media.tabbar_service_active'), '收藏', 2))
        // TabContent() {
        //   Map()
        // }.tabBar(this.tabBar($r('app.media.tabbar_see'), $r('app.media.tabbar_see_active'), '地图', 2))

        TabContent() {
          BookList()
        }.tabBar(this.tabBar($r('app.media.tabbar_service'), $r('app.media.tabbar_service_active'), '约房', 3))

        TabContent() {
          Mine()
        }.tabBar(this.tabBar($r('app.media.tabbar_my'), $r('app.media.tabbar_my_active'), '我的', 4))

      }
      .height('100%')
      .width('100%')
      .scrollable(false)
      .onChange((index:number)=> {
        this.curIndex = index;
      })
    }
    .height('100%')
    .width('100%')
    //.navDestination(this.homeRouter)
    .navDestination(this.routerMap)
    .hideToolBar(true)
    .hideTitleBar(true)
  }
}