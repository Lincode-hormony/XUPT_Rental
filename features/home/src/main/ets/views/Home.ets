/**
 * 首页
 * 实现点击推荐房源 跳到详情页面
 */
import {LogUtil} from '@pura/harmony-utils'
import { GetHomeDataApi,GetRoomRecommendApi } from '../apis/home';
import type { IBannerList, INavList, IPlanList, ITileList ,IRoomRecommendList} from '../model/HomeData';
import { MySwiper} from '../components/homeComponent/MySwiper'
import { RoomRecommendGrid } from '../components/homeComponent/RoomRecommendGrid';
import { BusinessError } from '@kit.BasicServicesKit';
import json from '@ohos.util.json';
import { geoLocationManager } from '@kit.LocationKit';
import { rvp } from 'uicomponent';
import { JSON } from '@kit.ArkTS';
import { permissionManager } from 'permissionmanger';
import { RouterUtil } from 'router/src/main/ets/utils/RouterUtil'
import { BuilderNameConstants, RouterNameConstants } from 'router/src/main/ets/constants/RouterConstants';

@Builder
function homePageBuilder(){
  Home()
}

@Component
export  struct Home {
  //定位默认值
  @State address:string='西安'
  // 首页数据
  @State bannerList: IBannerList = [];
  @State navList: INavList = [];
  @State tileList: ITileList = [];
  @State planList: IPlanList = [];
  @State adPicture: string = '';
  //房源推荐数据
  @State roomRecommendList:IRoomRecommendList=[]

  // @Consume('homePathStack') homePathStack:NavPathStack

  // 组件生命周期
  aboutToAppear() {
    this.getLocation()
    this.getHomeData()
    this.GetRoomRecommend()
  }
  //获取当前地理位置
  async getLocation(){
    //先获取权限
    await permissionManager.requestPermissions([
      "ohos.permission.LOCATION",
      "ohos.permission.APPROXIMATELY_LOCATION"
    ])
    const location=await geoLocationManager.getCurrentLocation()
    // console.info('dingweices first sucess')
    const geoAddres=await geoLocationManager.getAddressesFromLocation({
      locale:'zh',
      latitude:location.latitude,
      longitude:location.longitude,
      maxItems:1
    })
    // console.info('dingweices'+JSON.stringify(geoAddres,null,2))
    this.address=''+geoAddres[0].subAdministrativeArea
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
        // console.info(JSON.stringify(this.tileList,null,2))
      })
      .catch((err:BusinessError)=>{
        console.error("首页日志,获取错误 code: "+json.stringify(err,null,2))
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
    NavDestination() {
      Scroll() {
        Column() {
          Stack(){
            MySwiper({ bannerList: $bannerList }).margin({ bottom: 24 })
            Row(){
              Text(this.address)
                .fontSize(18).fontWeight(700).onClick(()=>this.getLocation())
              Blank();
              Search().width('70%').backgroundColor('#eeeeee').opacity(0.8)
            }.width('100%').padding({left:rvp(16),right:rvp(16)});
          }.width('100%').alignContent(Alignment.TopStart)
          RoomRecommendGrid({ roomRecommendList: $roomRecommendList })
        }
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
  }
}



const builderName:string=BuilderNameConstants.HOME
if(!RouterUtil.getBuilder(builderName)){
  const builder:WrappedBuilder<[object]>=wrapBuilder(homePageBuilder)
  RouterUtil.registerBuilder(builderName,builder)
}