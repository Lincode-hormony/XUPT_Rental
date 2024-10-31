import { rvp } from "uicomponent"

@Component
export struct RentPrice {
  @Prop Price:string
  @Prop Unit:string
  build() {
    Row(){
      Text(){
        Span('￥').fontSize(14).fontWeight(FontWeight.Bold).fontColor('#000000 ')
        Span(this.Price).fontSize(26).fontWeight(FontWeight.Bold).fontColor('#000000 ')
        Span(this.Unit).fontSize(14).fontWeight(500).fontColor('#000000 ')
      }
    }.width(rvp(327.5)).height(rvp(30)).justifyContent(FlexAlign.Start).margin({ left:16,right:16,bottom:16 })
  }
}