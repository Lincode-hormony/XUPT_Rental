/**
 * 首页
 * 实现点击推荐房源 跳到详情页面
 */

import {LogUtil} from '@pura/harmony-utils'
import { GetHomeDataApi,GetRoomRecommendApi } from '../apis/home';
import type { IBannerList, INavList, IPlanList, ITileList ,IRoomRecommendList,IRoomRecommendItem} from '../model/HomeData';
import {RoomPage} from  './RoomPage'
import {RoomList} from './RoomList'
import {SearchBar} from '../components/SearchBar'
import { RoomListDataSource } from '../model/RoomList';

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
  @Builder
  homeRouter(name:string,id:string){
    if(name==='RoomPage'){
      RoomPage({roomId:id})
    }
    else if(name==='RoomList'){
      RoomList()
    }
  }
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
  // 房源推荐区域
  @Builder
  RoomRecommendItem(item:IRoomRecommendItem){
    Column({space:10}) {
      Image(item.housePicture)
        .width(160)
        // .height(210)
        .objectFit(ImageFit.Fill)
        .borderRadius({ topLeft:8,topRight:8 })
        .onClick(()=>{
          this.homePathStack.pushPathByName('RoomPage',item.id)
        })
      Text(item.houseTitle)
        .maxLines(1)
        .textOverflow({overflow:TextOverflow.Ellipsis})
        .fontSize(16)
    }
    .height(310)
    .width('100%')
    .onClick(()=>{
      this.homePathStack.pushPathByName('RoomPage',item.id)
    })

  }

  build() {
    Navigation(this.homePathStack){
      Scroll() {
        Column(){
          SearchBar()
            .onClick(()=>{
              this.homePathStack.pushPathByName('RoomList',null)
            })

          Image(this.bannerList[0]?.imageURL).width('100%').height(200).margin({bottom:50})

          Button('更多推荐').width('90%').height(50)
            .onClick(()=>{
              this.homePathStack.pushPathByName('RoomList',null)
            })

          Grid(){
            ForEach(this.roomRecommendList,(item:IRoomRecommendItem,index)=>{
              this.RoomRecommendItem(item)
            })
          }
          // .renderGroup(true)
          .columnsTemplate("1fr 1fr")
          .columnsGap(8)
          .rowsTemplate("1fr 1fr 1fr 1fr")
          .rowsGap(8)
        }
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }.navDestination(this.homeRouter)


  }
}