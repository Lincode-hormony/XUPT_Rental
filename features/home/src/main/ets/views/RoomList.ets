/**
 * 房源列表组件
 */
import { RoomListDataSource,IRoomItem, ISearchParams } from '../model/RoomList'
import { GetRoomListApi } from '../apis/home'
import {locationTender} from '../components/locationRender'
import {payTypeRender} from '../components/payTypeRender'
import {PriceRender} from '../components/priceRender'
import {SortRender} from '../components/sortRender'
import { ITagItem } from '../model/HomeData'

@Component
export struct RoomList {
  @Consume('homePathStack') homePathStack:NavPathStack
  //设置API的搜索参数，以及数据源的排序，限制等
  @Provide @Watch('isSearch') searchParams: ISearchParams = {
    page: 1,
    limit: 10,
    maxRent:'',
    minRent:'',
    cityCode:'',
    districtCode: '',
    orderBy: '',
    orderType:'',
    paymentType: '',
    provinceCode:'',
  }
  //返回的数据roomList 和 total
  @State roomList: RoomListDataSource=new RoomListDataSource()
  @State total: number = 0
  @State isEnd:boolean=false  //数据列表到底 不在refresh
  @State isShow:boolean=false //是否展示搜索下拉框
  @State searchFilterText:string[]=['位置','支付方式','租金','排序']
  @State currentFilter:string=''
  @State isLoading:boolean=false;
  /**
   * 开启了筛选，重新获取数据
   */
  async isSearch(){
    this.isShow=false
    this.currentFilter=''
    await this.GetRoomList()
  }
  //搜索筛选
  @Builder searchFilter(){
    Column(){
      Row(){
        ForEach(this.searchFilterText,(text:string)=>{
          Row(){
            Text(text)
            Image(this.currentFilter===text?$r('app.media.arrow_down_3_active'):$r('app.media.arrow_down_3')).width(10)
          }.onClick(()=>this.changeIsShow(text))
        },(text:string)=>text)
      }.width('100%').height(44).padding({left:16,right:16})
      .justifyContent(FlexAlign.SpaceBetween)

      //搜索区域
      Column(){
        if(this.currentFilter==='位置'){locationTender()}
        else if(this.currentFilter==='支付方式'){payTypeRender()}
        else if(this.currentFilter==='租金'){PriceRender()}
        else if(this.currentFilter==='排序'){SortRender()}
      }.width('100%')
      .visibility(this.isShow?Visibility.Visible:Visibility.Hidden)

      //遮帐层
      Row(){
      }.width('100%').layoutWeight(1).backgroundColor('rgba(0,0,0,0.7)')
      .visibility(this.isShow?Visibility.Visible:Visibility.Hidden)
      .onClick(()=>{this.isShow=false})
    }
    .width('100%')
    .height(this.isShow?'100%':44)
  }

  build() {
    NavDestination(){
      Stack(){
        this.roomListWaterFlow()
        this.searchFilter()
      }
      .align(Alignment.Top)
    }
    .title('房源列表').width('100%').height('100%')
  }

  //
  aboutToAppear(): void {
    this.GetRoomList()
  }
  //获取房间数据列表
  async GetRoomList() {
    if(this.isLoading){
      return
    }
    this.isLoading=true
    GetRoomListApi(this.searchParams)
    .then((data)=>{
      console.debug('当前搜索参数'+JSON.stringify(this.searchParams))//
      const res=data
      // 分页加载
      if(this.searchParams.page===1){
        this.roomList.setList(res.records)
      }
      else{
        this.roomList.pushList(res.records)
      }
      this.total = Number(res.total)
      if(this.total<=this.roomList.totalCount()){
        this.isEnd=true;
      }
    })
    .catch(()=>{
    // console.error('获取列表数据失败')
    }).finally(()=>{this.isLoading=false})

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
  @Builder roomItem(item:IRoomItem){
    Column({space:10}) {
      if(item.activity){
        Row(){
          Image(item.activity.icon)
            .height(40)
          Text(item.activity.title)
            .fontSize(16)
            .fontColor(item.activity.textColor)
            .backgroundColor(item.activity.textBackGroundColor)
        }
        .height(50)
        .width('100%')
      }
      Image(item.housePicture)
        .width(160)
        .objectFit(ImageFit.Fill)
        .borderRadius({ topLeft:8,topRight:8 })
        .onClick(()=>{
          this.homePathStack.pushPathByName('RoomPage',item.id)
        })
      Text(item.houseTitle)
        .maxLines(1)
        .textOverflow({overflow:TextOverflow.Ellipsis})
        .fontSize(12)
      Text(item.rentPriceListing+item.rentPriceUnit).fontSize(12)
      Row({space:8}){
        Text('地点:'+item.address).fontSize(10)
        Text(item.rentArea+'m2').fontSize(10)
      }
      List(){
        ForEach(item.tags,(tagItem:ITagItem)=>{
          ListItem(){Text(tagItem.name).fontSize(10)}.backgroundColor('#009B71')
        })
      }.listDirection(Axis.Horizontal)
    }
    .width('100%')
    .height('100%')
  }
  //底部refresh组件
  @Builder footer(){
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
  //WaterFlow
  @Builder roomListWaterFlow(){
    WaterFlow({footer:this.footer()}) {
      LazyForEach(this.roomList, (item: IRoomItem, index) => {
        FlowItem() {
          this.roomItem(item)
        }
        .width(160).height(item.activity? 320:210).backgroundColor(Color.Orange)
      },(item:IRoomItem)=>item.id)
    }
    .padding({
      left: (16),
      right: (16),
    }).columnsTemplate('1fr 1fr').columnsGap(8).rowsGap(8).backgroundColor('#f7f7f7')
    .margin({top:88})
    .onReachEnd(()=>{
      this.loadMore();
    })
  }
  changeIsShow=(text:string)=>{
    if(text===this.currentFilter){
      this.hideIsShow()
      return
    }
    else this.isShow=true
    this.currentFilter=text;
  }
  hideIsShow=()=>{
    this.isShow=false;
    this.currentFilter=''
  }
}