/**
 * author HLQ
 */

import { ITagItem } from "home/src/main/ets/model/HomeData"
import { rvp } from "uicomponent"
import { IBookHistoryItem } from "../model/BookData"
/**
 * 预约房间项
 */
@Component
export struct BookItem {
  @Prop bookHistoryItem:IBookHistoryItem
  build() {
    Column({space:rvp(4)}){
      Row({space:rvp(4)}){
        Image($r('app.media.clock')).width(rvp(12))
        Text(this.bookHistoryItem.date).fontSize(rvp(12)).fontWeight(500).fontColor('#999999')
          .maxLines(1).textOverflow({overflow:TextOverflow.Ellipsis})
        ForEach(this.bookHistoryItem.tags,(item:ITagItem)=>{
          Text(item.name).fontSize(rvp(12)).fontWeight(500).fontColor('#999999')
        })
      }.width('100%')
      Row({space:rvp(8)}){
        Column(){
          Image(this.bookHistoryItem.img).width(rvp(128)).height(rvp(120)).borderRadius(rvp(8))
        }
        Column({space:rvp(8)}){
          Text(this.bookHistoryItem.title).fontSize(rvp(16)).fontWeight(500).fontColor('#000000')
          Text(this.bookHistoryItem.subTitle).fontSize(rvp(12)).fontWeight(500).fontColor('#999999')
          Text(this.bookHistoryItem.comment).fontSize(rvp(12)).fontWeight(500).fontColor('#999999')
          Row(){
            Text(this.bookHistoryItem.rentPrice).fontSize(rvp(18)).fontWeight(500).fontColor('#E03810')
            Blank()
            Text('去咨询').fontSize(rvp(14)).fontWeight(500).fontColor('#36D1A1')
          }.width('100%')
          .margin({top:rvp(14)})
        }.alignItems(HorizontalAlign.Start).width(rvp(200))
      }.width('100%')
    }.width('100%')
  }
}
