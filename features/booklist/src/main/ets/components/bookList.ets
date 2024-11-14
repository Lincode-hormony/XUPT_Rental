import { getBookHistoryApi } from "../apis/book";
import { IBookHistoryItem, IBookHistoryList } from "../model/BookData";
import { BookItem } from "./bookItem";
import {rvp} from 'uicomponent'
@Component
export struct BookList {
  @State message: string = '约房';
  @State bookHistoryList:IBookHistoryList=[]
  @Consume('homePathStack') homePathStack:NavPathStack
  aboutToAppear(): void {
      this.getBookHistoryList()
  }
  async getBookHistoryList(){
    this.bookHistoryList=await getBookHistoryApi()
  }

  build() {
    Column({space:rvp(20)}) {
      // Text(this.message)
      //   .fontSize(50)
      //   .fontWeight(FontWeight.Bold)
      List({space:rvp(16)}){
        ForEach(this.bookHistoryList,(bookHistoryItem:IBookHistoryItem)=>{
          BookItem({bookHistoryItem:bookHistoryItem})
            .onClick(()=>{
              console.info("11/14： "+bookHistoryItem.id);
              this.homePathStack.pushPathByName('RoomPage',bookHistoryItem.houseId)
            })
        },(item:IBookHistoryItem)=>item.id)
      }.width('100%').scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .padding({left:rvp(16),right:rvp(16)})
    .backgroundColor('#F7F7F7')
  }
}




