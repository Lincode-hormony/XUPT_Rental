/**
 * 首页
 * 实现点击推荐房源 跳到详情页面
 */

import {LogUtil} from '@pura/harmony-utils'
import { GetHomeDataApi,GetRoomRecommendApi } from '../apis/home';
import type { IBannerList, INavList, IPlanList, ITileList ,IRoomRecommendList,IRoomRecommendItem} from '../model/HomeData';
import {RoomPage} from  './RoomPage'
import {RoomList} from './RoomList'
import { MySwiper} from '../components/homeComponent/MySwiper'
import { RoomListDataSource } from '../model/RoomList';
import { RoomRecommendGrid } from '../components/homeComponent/RoomRecommendGrid';

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
  // routermap

  // @Builder
  // homeRouter(name:string,id:string){
  //   if(name==='RoomPage'){
  //     RoomPage({roomId:id})
  //   }
  //   else if(name==='RoomList'){
  //     RoomList()
  //   }
  // }

  // 组件生命周期
  aboutToAppear() {
    this.getHomeData()
    this.GetRoomRecommend()
  }
  // 调用API获取首页上半区域数据
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
  // 调用API获取首页房源推荐区域数据
  GetRoomRecommend(){
    GetRoomRecommendApi()
      .then((data)=>{
        this.roomRecommendList=data
      })
  }

  build() {
    // Navigation(this.homePathStack){
    NavDestination() {
      Scroll() {
        Column() {
          MySwiper({ bannerList: $bannerList }).margin({ bottom: 24 })
          RoomRecommendGrid({ roomRecommendList: $roomRecommendList })
        }
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    // }.navDestination(this.homeRouter)
  }
}