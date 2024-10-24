import {Home} from 'home'
import {Discover} from 'discover'
import {Map} from 'map'
import {Mine} from 'mine'
import {RoomList} from 'roomlist'
@Entry
@Component
struct Index {
  /**
   * 定义相应的NavPathStack，供其他模块使用
   */
  @Provide('homePathStack') homePathStack:NavPathStack=new NavPathStack()
  /**
   * Tabs的Bar
   */
  @Builder tabBar(image:Resource,activeimage:Resource,name:string,index:number){
    Column(){
      Image(image)
        .width(20)
        .height(20)
      Text(name)
        .fontSize(10)
    }

  }
  build() {
    Tabs({ barPosition: BarPosition.End}) {
      TabContent() {
        Home()
      }.tabBar(this.tabBar($r('app.media.icon'), $r('app.media.icon'), '首页', 0))

      TabContent() {
        Discover()
      }.tabBar(this.tabBar($r('app.media.icon'), $r('app.media.icon'), '发现', 1))

      TabContent() {
        Map()
      }.tabBar(this.tabBar($r('app.media.icon'), $r('app.media.icon'), '地图', 2))

      TabContent() {
        RoomList()
      }.tabBar(this.tabBar($r('app.media.icon'), $r('app.media.icon'), '约房', 3))

      TabContent() {
        Mine()
      }.tabBar(this.tabBar($r('app.media.icon'), $r('app.media.icon'), '我的', 4))
    }
    .height('100%')
    .width('100%')
  }
}