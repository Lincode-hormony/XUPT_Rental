/**
 * 首页
 * 实现点击推荐房源 跳到详情页面
 */

import { it } from '@ohos/hypium';
import {LogUtil} from '@pura/harmony-utils'
import { GetHomeDataApi,GetRoomRecommendApi } from '../apis/home';
import type { IBannerList, INavList, IPlanList, ITileList ,IRoomRecommendList,IRoomRecommendItem} from '../model/HomeData';
import {RoomPage} from  './RoomPage'
import { router } from '@kit.ArkUI';

@Component
export  struct Home {
  // 首页数据
  @State bannerList: IBannerList = [];
  @State navList: INavList = [];
  @State tileList: ITileList = [];
  @State planList: IPlanList = [];
  @State adPicture: string = '';
  //房源推荐数据
  @State roomRecommendList:IRoomRecommendList=[]
  @Consume('homePathStack') homePathStack:NavPathStack
  @Builder
  homeRouter(name:string,id:string){
    if(name==='RoomPage'){
      RoomPage({roomId:id})
    }
  }
  // 组件生命周期
  aboutToAppear() {
    this.getHomeData()
    this.GetRoomRecommend()
  }

  getHomeData() {
    GetHomeDataApi()
      .then((data) => {
        this.bannerList=data.bannerList
        this.adPicture = data.adPicture
        this.navList = data.navList
        this.planList = data.planList
        this.tileList = data.tileList
      })
      .catch(()=>{
        LogUtil.debug("首页日志,获取错误")
      })
  }
  GetRoomRecommend(){
    GetRoomRecommendApi()
      .then((data)=>{
        this.roomRecommendList=data
      })
  }
  @Builder
  RoomRecommendItem(item:IRoomRecommendItem){
    Column({space:10}){
      Image(item.housePicture)
        .width('90%')
      Text(item.houseTitle)
    }
    .margin({bottom:50})
    .height(200)
    .width('100%')
    .onClick(()=>{
      this.homePathStack.pushPathByName('RoomPage',item.id)
    })

  }

  build() {
    Navigation(this.homePathStack){
      Scroll() {
        Column(){,jih
          Image(this.bannerList[0]?.imageURL)
            .width('100%')
            .height(200)
            .margin({bottom:50})

          ForEach(this.roomRecommendList,(item:IRoomRecommendItem,index)=>{
            this.RoomRecommendItem(item)
          })
        }
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }.navDestination(this.homeRouter)


  }
}