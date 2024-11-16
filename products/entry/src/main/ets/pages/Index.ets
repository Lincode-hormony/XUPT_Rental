import {Home} from 'home'

import {Discover} from 'discover'
import {Map} from 'map'
import {Mine} from 'mine'
import {BookList} from 'booklist'
import { RoomPage } from 'home/src/main/ets/views/RoomPage'
import { RoomList } from 'home/src/main/ets/views/RoomList'

//用于存放Token的全局变量
AppStorage.setOrCreate('Token','暂无用户数据')

@Entry
@Component
struct Index {
  /**
   * 定义相应的NavPathStack，供其他模块使用
   */
  @Provide('homePathStack') homePathStack:NavPathStack=new NavPathStack()
  @Provide('loginPathStack') loginPathStack:NavPathStack =new NavPathStack()
  @State curIndex:number=0;
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
  @Builder
  homeRouter(name:string,id:string){
    if(name==='RoomPage'){
      RoomPage({roomId:id})
    }
    else if(name==='RoomList'){
      RoomList()
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
          Map()
        }.tabBar(this.tabBar($r('app.media.tabbar_see'), $r('app.media.tabbar_see_active'), '地图', 2))

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
      // .backgroundColor(Color.Green)
    }
    .height('100%')
    // .backgroundColor(Color.Pink)
    .width('100%')
    .navDestination(this.homeRouter)
    .hideToolBar(true)

  }
}