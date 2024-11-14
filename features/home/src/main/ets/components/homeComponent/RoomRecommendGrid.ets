import { IRoomRecommendItem, IRoomRecommendList } from "../../model/HomeData"

@Component
export struct RoomRecommendGrid {
  @Link roomRecommendList:IRoomRecommendList
  @Consume('homePathStack') homePathStack:NavPathStack
  // 房源推荐区域
  @Builder
  RoomRecommendItem(item:IRoomRecommendItem){
    Column() {
      Stack(){
        Image(item.housePicture)
          .width(160).height(120)
          .borderRadius({ topLeft:8,topRight:8 })
          // .onAppear(()=>{
          //   console.info(item.houseTitle+"重新加载")
          // })
        Row(){
          Image($r('app.media.location')).margin({left:6}).width(16)
          Text(item.address)
            .maxLines(1)
            .textOverflow({overflow:TextOverflow.Ellipsis})
            .fontSize(12)
            .fontWeight(500)
            .fontColor('#ffffff')
        }.margin({right:6,bottom:6})

      }.align(Alignment.BottomStart).width(160).height(120)
      Row(){
        Text(item.rentPriceListing+item.rentPriceUnit).fontSize(14)
          .fontColor('#E03810').fontWeight(500)
        Text(item.rentArea+'m2').fontSize(10)
      }.padding(10).width('100%').justifyContent(FlexAlign.SpaceBetween)

      Text(item.houseTitle).fontSize(14).fontColor('#000000').fontWeight(500)
        .maxLines(1).textOverflow({overflow:TextOverflow.Ellipsis})

      Row({space:6}){
        if(item.tags[0]) Text(item.tags[0].name).height(15).fontSize(14)
          .fontColor('#ffffff').backgroundColor('#36D1A1').fontWeight(500)
        if(item.tags[1]) Text(item.tags[1].name).height(15).fontSize(14)
          .fontColor('#B3B3B3').backgroundColor('#f7f7f7').fontWeight(500)
      }.width('100%').padding({top:10,bottom:12,left:10}).justifyContent(FlexAlign.Start)
    }
    .height(210)
    .width('100%')
    .onClick(()=>{
      this.homePathStack.pushPathByName('RoomPage',item.id)
    })

  }

  build() {
    Column(){
      Row(){
        Text(){
          Span('周边房源').fontSize(18).fontWeight(700).fontColor('#000000')
          Span('推荐').fontSize(18).fontWeight(700).fontColor('#009B71')
        }.margin({right:160})
        Text('更多推荐 >').fontSize(12).fontWeight(400).fontColor('#bbbbbb')
          .onClick(()=>{
            this.homePathStack.pushPathByName('RoomList',null)
          })
      }.width('88%').justifyContent(FlexAlign.SpaceBetween).margin({bottom:10})
      Grid(){
        ForEach(this.roomRecommendList,(item:IRoomRecommendItem,index)=>{
          GridItem(){
            this.RoomRecommendItem(item)
          }
        },(item:IRoomRecommendItem)=>item.id)
      }
      .height(210*4+8*3)
      .margin({left:16,right:16})
      .columnsTemplate("1fr 1fr")
      .columnsGap(8)
      .rowsTemplate("1fr 1fr 1fr 1fr")
      .rowsGap(8)
    }
  }
}