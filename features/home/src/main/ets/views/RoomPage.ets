/**
 * 房间 详情 数据页面
 * 网路访问要带数据
 */

import {IRoomData,ISupportLIst,IHousePictureList,IHousePictureItem, IMetaInfoList, IRentTerm,
  IHouseholdItemList,
  IRentInfoList,
  IHouseholdItemItem} from '../model/Room'
import {GetRoomDetailApi} from '../apis/home'
import { NavSwiper } from '../components/RoomPageComponent/NavSwiper'
import { RentPrice } from '../components/RoomPageComponent/RentPrice'
import { MetaInfo } from '../components/RoomPageComponent/MetaInfo'
import { ITagList } from '../model/HomeData'
import { TagList } from '../components/RoomPageComponent/TagList'
import { RentTerm } from '../components/RoomPageComponent/RentTerm'
import { rvp } from 'uicomponent'
import { RentInfo } from '../components/RoomPageComponent/RentInfo'
import {  HouseholdItem1 } from '../components/RoomPageComponent/HouseholdItem1'
import { HouseholdItem2 } from '../components/RoomPageComponent/HouseholdItem2'
import { SupportList } from '../components/RoomPageComponent/SupportList'
import { TabBar } from '../components/RoomPageComponent/TabBar'

@Component
export struct RoomPage {
  @Prop roomId: string;
  @State room:Partial<IRoomData>={}
  @State houseTitle:string='房屋详情'
  @State housePictureList:IHousePictureList=[]
  @State metaInfo:IMetaInfoList=[]
  @State tagList:ITagList=[]//标签
  @State rentTerm:IRentTerm={} as IRentTerm
  @State rentInfo:IRentInfoList=[]//房屋信息
  @State householdItemList:IHouseholdItemList=[]//物品配置
  @State supportLIst:ISupportLIst=[]//租住服务与保障

  @Consume('homePathStack') homePathStack:NavPathStack

  aboutToAppear(): void {
    this.getRoomDetail();
  }
  getRoomDetail(){
    GetRoomDetailApi(this.roomId)
      .then((data)=>{
        this.room=data
        this.houseTitle=data.houseTitle
        this.housePictureList=data.housePicture
        this.metaInfo=data.metaInfo
        this.tagList=data.tags//标签
        this.rentTerm=data.rentTerm
        this.rentInfo=data.rentInfo//房屋信息
        this.householdItemList=data.householdItem//物品配置
        this.supportLIst=data.support//租住服务与保障
        // console.debug('测试房屋详情数据Term  '+JSON.stringify(this.rentTerm))
        // console.debug('测试房屋详情数据tag   '+JSON.stringify(this.tagList))
      })
  }

  @Builder
  NavTirle(){
    Text(this.houseTitle).fontWeight(700).fontSize(rvp(16)).textAlign(TextAlign.Center)
      .height(55)
  }

  build() {
    NavDestination(){
      Scroll() {
        Column() {
          NavSwiper({housePictureList:$housePictureList})
          RentPrice({Price:this.room.rentPriceUnitListing,Unit:this.room.rentPriceUnit})
          MetaInfo({metaInfo:$metaInfo})
          TagList({tagList:$tagList})
          RentTerm({rentTerm:this.rentTerm!})
          RentInfo({rentInfo:this.rentInfo})
          Text('物品配置').fontSize(rvp(18)).fontWeight(700).alignSelf(ItemAlign.Start)
            .margin({left:rvp(16),top:rvp(32)})
          Column({space:rvp(24)}){
              if(this.householdItemList[0]) HouseholdItem1({householdItem:this.householdItemList[0]})
              if(this.householdItemList[1]) HouseholdItem2({householdItem:this.householdItemList[1]})
          }.margin({top:rvp(16)})
          if(this.supportLIst.length) SupportList({supportList:this.supportLIst})
          TabBar()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .title(this.NavTirle)
  }
}

