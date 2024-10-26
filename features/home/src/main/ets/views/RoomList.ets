/**
 * 房源列表组件
 */
import { RoomListDataSource,IRoomItem, ISearchParams } from '../model/RoomList'
import { GetRoomListApi } from '../apis/home'
import { LogUtil } from '@pura/harmony-utils'
@Component
export struct RoomList {
  @Consume('homePathStack') homePathStack:NavPathStack
  //设置API的搜索参数，以及数据源的排序，限制等
  @State searchParams: ISearchParams = {
    page: 1,
    limit: 10
  }
  //返回的数据roomList 和 total
  @State roomList: RoomListDataSource = new RoomListDataSource()
  @State total: number = 0
  @State isEnd:boolean=false//数据列表到底 不在refresh
  //
  aboutToAppear(): void {
    this.GetRoomList()
  }
  //获取房间数据列表
  async GetRoomList() {
    const res = await GetRoomListApi(this.searchParams)
    // 分页加载
    if(this.searchParams.page===1){
      this.roomList.setList(res.records)
    }
    else{
      this.roomList.pushList(res.records)
    }

    this.total = Number(res.total)
    // this.total =23
  }
  //分页加载
  loadMore=()=>{
    //判断是否到底
    if(this.total<=this.roomList.totalCount()){
      this.isEnd=true;
      return
    }
    this.isEnd=false
    this.searchParams.page++;
    this.GetRoomList()
  }
  //单个房间组件
  @Builder
  roomItem(item:IRoomItem){
    Column({space:10}) {
      if(item.activity){
        Row(){
          Image(item.activity.icon)
            .height(50)
          Text(item.activity.title)
            .fontSize(16)
            .fontColor(item.activity.textColor)
            .backgroundColor(item.activity.textBackGroundColor)
        }
        .height(60)
        .width('100%')
      }
      Image(item.housePicture)
        .width('100%')
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
    .width('100%')
    .height('100%')
  }
  //底部refresh组件
  @Builder
  footer(){
    Row(){
      if(this.isEnd){
        Text('到底了，没有数据了').fontColor('999999')
      }
      else{
        Refresh({refreshing:true})
        Text('正在加载...').fontColor('999999')
      }
    }.width('100%').justifyContent(FlexAlign.Center)
  }

  build() {
    NavDestination(){
      WaterFlow({footer:this.footer()}) {
        LazyForEach(this.roomList, (item: IRoomItem, index) => {
          FlowItem() {
            this.roomItem(item)
          }
          .width(160).height(item.activity? 320:210).backgroundColor(Color.Orange)
        })
      }
      .padding({
        left: (16),
        right: (16),
        top: (8),
      }).columnsTemplate('1fr 1fr').columnsGap(8).rowsGap(8).backgroundColor('#f7f7f7')
      .onReachEnd(()=>{
        this.loadMore();
      })
    }
    .title('房源列表').width('100%').height('100%')
  }
}