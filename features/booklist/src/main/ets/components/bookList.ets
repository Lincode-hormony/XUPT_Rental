import { getBookHistoryApi } from "../apis/book";
import { IBookHistoryItem, IBookHistoryList } from "../model/BookData";
import { BookItem } from "./bookItem";
import {rvp} from 'uicomponent'
@Component
export struct BookList {
  @State message: string = '约房';
  @State bookHistoryList:IBookHistoryList=[]
  aboutToAppear(): void {
      this.getBookHistoryList().then(()=>{
        console.info(`BookHistoryList = ${JSON.stringify(this.bookHistoryList)}`)
      })
  }
  async getBookHistoryList(){
    this.bookHistoryList=await getBookHistoryApi()
  }

  build() {
    // Scroll() {
      Column({space:20}) {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        List({space:rvp(16)}){
          ForEach(this.bookHistoryList,(bookHistoryItem:IBookHistoryItem)=>{
            BookItem({bookHistoryItem:bookHistoryItem})
          },(item:IBookHistoryItem)=>item.id)
        }.width('100%')
      }
      .width('100%')
      .height('100%')
      .padding({left:rvp(16),right:rvp(16)})
      .backgroundColor('#F7F7F7')
    // }
    // .height('100%')
  }
}




