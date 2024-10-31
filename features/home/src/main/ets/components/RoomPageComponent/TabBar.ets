import { rvp } from "uicomponent";

@Component
export struct TabBar {
  build() {
    Row(){
      Column(){
        Image($r("app.media.like")).width(rvp(18))
        Text('99+').fontSize(rvp(10)).fontWeight(500).fontColor('#999999')
      }.margin({right:rvp(27)})
      Column(){
        Image($r('app.media.question')).width(rvp(18))
        Text('咨询').fontSize(rvp(10)).fontWeight(500).fontColor('#999999')
      }.margin({right:rvp(21)})
      Button(){
        Text('立即预定').fontSize(rvp(14)).fontWeight(500).fontColor('#FFFFFF')
      }.width(rvp(113)).height(rvp(34)).type(ButtonType.Normal).backgroundColor('#24A17B')
      .margin({right:rvp(21)})

      Button(){
        Text('去看房').fontSize(rvp(14)).fontWeight(500).fontColor('#FFFFFF')
      }.width(rvp(113)).height(rvp(34)).type(ButtonType.Normal).backgroundColor('#36D1A1')

    }.width(rvp(360)).height(rvp(50))
    .padding({left:rvp(20),right:rvp(16)}).margin({top:rvp(32)})
  }
}