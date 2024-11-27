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
/*
{
    "id": "2",
    "date": "2024-11-09",
    "houseId": "AQ1702976528452681728",
    "img": "http://localhost:6060/public/room95.jpg",
    "title": "整租·黄花亭新村 3室1厅 南/北",
    "subTitle": "58.00m² | 南 北 | 大观区·龙山路",
    "distanceInfo": null,
    "rentPrice": "600元/月",
    "tags": [
        {
            "name": "随时看房"
        },
        {
            "name": "精装"
        },
        {
            "name": "双卫生间"
        }
    ],
    "comment": "速约"
},
 */