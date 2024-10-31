import { ITagItem } from "../../model/HomeData"
import { IRoomItem } from "../../model/RoomList"

@Reusable
@Component
export struct roomItem{
  @Consume('homePathStack') homePathStack:NavPathStack
  @State item:IRoomItem|null=null
  aboutToReuse(params: Record<string, IRoomItem>): void {
    this.item = params.item as IRoomItem;
  }
  build() {
      Column() {
        if(this.item?.activity){
          Row(){
            Image(this.item.activity.icon)
              .height(40)
            Text(this.item.activity.title)
              .fontSize(16)
              .fontColor(this.item.activity.textColor)
              .backgroundColor(this.item.activity.textBackGroundColor)
          }
          .height(50)
          .width('100%')
        }
        Stack(){
          Image(this.item?.housePicture)
            .width(160).height(120)
            .borderRadius({ topLeft:8,topRight:8 })
          Row(){
            Image($r('app.media.location')).margin({left:6}).width(16)
            Text(this.item?.address)
              .maxLines(1)
              .textOverflow({overflow:TextOverflow.Ellipsis})
              .fontSize(12)
              .fontWeight(500)
              .fontColor('#ffffff')
          }.margin({right:6,bottom:6})

        }.align(Alignment.BottomStart).width(160).height(120)
        Row(){
          Text(''+this.item?.rentPriceListing+this.item?.rentPriceUnit).fontSize(14)
            .fontColor('#E03810').fontWeight(500)
          Text(this.item?.rentArea+'m2').fontSize(10)
        }.padding(10).width('100%').justifyContent(FlexAlign.SpaceBetween)

        Text(''+this.item?.houseTitle).fontSize(14).fontColor('#000000').fontWeight(500)
          .maxLines(1).textOverflow({overflow:TextOverflow.Ellipsis})

        Row({space:6}){
          if(this.item?.tags[0]) Text(this.item.tags[0].name).height(15).fontSize(14)
            .fontColor('#ffffff').backgroundColor('#36D1A1').fontWeight(500)
          if(this.item?.tags[1]) Text(this.item.tags[1].name).height(15).fontSize(14)
            .fontColor('#B3B3B3').backgroundColor('#f7f7f7').fontWeight(500)
        }.width('100%').padding({top:10,bottom:12,left:10}).justifyContent(FlexAlign.Start)
      }
      .width('100%')
      .height('100%')
  }
}