import { getBookHistoryApi } from "../apis/book";
import { IBookHistoryItem, IBookHistoryList } from "../model/BookData";
import { BookItem } from "./bookItem";
import {rvp} from 'uicomponent'
/**
 * 预约历史记录
 */

// 获取当前日期（年-月-日）
function  getCurrentYearMonthDay(): string {
  const date = new Date();
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
}
@Component
export struct BookList {
  @State bookHistoryList:IBookHistoryList=[]
  @State isList:boolean=true;
  @State isdesc:number=0;
  @Consume('homePathStack') homePathStack:NavPathStack
  aboutToAppear(): void {
      this.getBookHistoryList()
  }
  //获取网络数据
  async getBookHistoryList(){
    this.bookHistoryList=await getBookHistoryApi()
  }
  //日期转整数
  date2Number(date: string):number{
    // console.info(JSON.stringify(date,null,2))
    return Number(date.slice(0,4)+date.slice(5,7)+date.slice(8,10))
  }
  //列表升序排序 比较函数
  compare_BookHistoryItem(a: IBookHistoryItem, b: IBookHistoryItem){
    if(a.date != b.date){
       // console.info('测试 '+Number(a.date.slice(0,4)+a.date.slice(5,7)+a.date.slice(8,10)))
      if(a.date>b.date) return 1;
      else return -1;
    }else{
      return Number(a.id) - Number(b.id) ;
    }
  }
  //列表降序排序 比较函数
  compare_BookHistoryItem_desc(b: IBookHistoryItem, a: IBookHistoryItem){
    if(a.date != b.date){
      // console.info('测试 '+Number(a.date.slice(0,4)+a.date.slice(5,7)+a.date.slice(8,10)))
      return Number(a.date.slice(0,4)+a.date.slice(5,7)+a.date.slice(8,10)) - Number(b.date.slice(0,4)+b.date.slice(5,7)+b.date.slice(8,10));
    }else{
      return Number(a.id) - Number(b.id) ;
    }
  }

  build() {
      Column() {
        Column(){
          Row(){
            Text("预约列表").fontSize(26).fontWeight(700).fontColor(this.isList?'#36d1a1':'#000000').margin({bottom:rvp(16)})
              .onClick(()=>{
                this.isList=true;
              })
            Text("历史记录").fontSize(26).fontWeight(700).fontColor(!this.isList?'#36d1a1':'#000000').margin({bottom:rvp(16)})
              .onClick(()=>{
                this.isList=false;
              })
          }.width('100%').height(rvp(30)).alignItems(VerticalAlign.Center).justifyContent(FlexAlign.SpaceBetween).padding({left:rvp(24),right:rvp(24)}).backgroundColor('#eeeeee')
          Row(){
            Text("预约时间升序")
              .width('40%').height(rvp(30)).textAlign(TextAlign.Center).backgroundColor(this.isdesc===-1?'#36d1a1':Color.White).borderRadius(rvp(10))
              .onClick(()=>{
                this.bookHistoryList.sort(this.compare_BookHistoryItem)
                this.isdesc=-1;
              })
            Blank()
            Text("预约时间降序")
              .width('40%').height(rvp(30)).textAlign(TextAlign.Center).backgroundColor(this.isdesc===1?'#36d1a1':Color.White).borderRadius(rvp(10))
              .onClick(()=>{
                this.bookHistoryList.sort(this.compare_BookHistoryItem_desc)
                this.isdesc=1;
              })
          }.width('100%').height(rvp(30)).justifyContent(FlexAlign.Center).backgroundColor('#ffececec').padding({left:rvp(16),right:rvp(16)})
        }.width('100%').alignItems(HorizontalAlign.Center)

        Row().width('100%').height(rvp(14)).backgroundColor('#ffececec')

        List({space:rvp(16)}){
          ForEach(this.bookHistoryList,(bookHistoryItem:IBookHistoryItem)=>{
            if(!this.isList||bookHistoryItem.date>=getCurrentYearMonthDay())
            BookItem({bookHistoryItem:bookHistoryItem})
              .onClick(()=>{
                this.homePathStack.pushPathByName('RoomPage',bookHistoryItem.houseId)
              })
          },(item:IBookHistoryItem)=>item.id)
        }.width('100%').scrollBar(BarState.Off).backgroundColor('#ffececec').padding({left:rvp(16),right:rvp(16),bottom:rvp(40)})
      }.width('100%').height('100%')
  }
}




