/**
 * 房源列表组件
 */
import { IRoomList, ISearchParams } from '../model/RoomList'
import { IRoomRecommendList, IRoomRecommendItem } from '../model/HomeData'
import { GetRoomListApi } from '../apis/home'
import { LogUtil } from '@pura/harmony-utils'
import {SearchBar} from '../components/SearchBar'
@Component
export struct RoomList {
  @Consume('homePathStack') homePathStack:NavPathStack
  //设置API的搜索参数，以及数据源的排序，限制等
  @State searchParams: ISearchParams = {
    page: 1,
    limit: 5
  }
  //返回的数据roomList 和 total
  @State roomList: IRoomRecommendList = []
  @State total: number = 0

  aboutToAppear(): void {
    this.GetRoomList()
  }

  //获取房间数据列表
  GetRoomList() {
    GetRoomListApi(this.searchParams)
      .then((res) => {
        LogUtil.info('测试房源列表'+JSON.stringify(res));
        this.roomList = res.records
        this.total = Number(res.total)
      })
      .catch(()=>{
        LogUtil.info('测试房源列表 获取数据错误');
      })

  }
  @Builder
  roomItem(item:IRoomRecommendItem){
    Column({space:30}) {
      Image(item.housePicture)
        .width('100%')
        .height(200)
        .onClick(()=>{
          this.homePathStack.pushPathByName('RoomPage',item.id)
        })
      Text(item.houseTitle)
        .fontSize(20)
      Divider()
    }
  }
  build() {
    NavDestination(){
      List() {
        SearchBar()
        ForEach(this.roomList, (item: IRoomRecommendItem, index) => {
          ListItem() {
            this.roomItem(item)
          }
        })
      }
    }
    .title('房源列表')
    .width('100%')
    .height('100%')
  }
}