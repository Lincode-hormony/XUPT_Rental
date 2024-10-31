import { rvp } from "uicomponent"
import { ISupportLIst } from "../../model/Room"

@Component
export struct SupportList {
  @Prop supportList:ISupportLIst
  build() {
    Column(){
      Text('租住服务与保障').fontSize(rvp(18)).fontWeight(700)
        .alignSelf(ItemAlign.Start).margin({left:rvp(16),top:rvp(32)})

      Row(){
        Row(){
          Image(this.supportList[0].image).width(rvp(28))
          Column(){
            Text(this.supportList[0].title).fontSize(rvp(14)).fontWeight(500)
            Text(this.supportList[0].subTitle).fontSize(rvp(10)).fontWeight(500).fontColor('#666666')
          }.margin({left:rvp(10)})
        }.width(rvp(122)).height(rvp(30))

        Row(){
          Image(this.supportList[0].image).width(rvp(28))
          Column(){
            Text(this.supportList[0].title).fontSize(rvp(14)).fontWeight(500)
            Text(this.supportList[0].subTitle).fontSize(rvp(10)).fontWeight(500).fontColor('#666666')
          }.margin({left:rvp(10)})
        }.width(rvp(122)).height(rvp(30))
      }.width('100%').justifyContent(FlexAlign.SpaceBetween)
      .margin({top:rvp(14)}).padding({left:rvp(24),right:rvp(24)})

      Row(){
        Row(){
          Image(this.supportList[0].image).width(rvp(28))
          Column(){
            Text(this.supportList[0].title).fontSize(rvp(14)).fontWeight(500)
            Text(this.supportList[0].subTitle).fontSize(rvp(10)).fontWeight(500).fontColor('#666666')
          }.margin({left:rvp(10)})
        }.width(rvp(122)).height(rvp(30))

        Row(){
          Image(this.supportList[0].image).width(rvp(28))
          Column(){
            Text(this.supportList[0].title).fontSize(rvp(14)).fontWeight(500)
            Text(this.supportList[0].subTitle).fontSize(rvp(10)).fontWeight(500).fontColor('#666666')
          }.margin({left:rvp(10)})
        }.width(rvp(122)).height(rvp(30))
      }.width('100%').justifyContent(FlexAlign.SpaceBetween)
      .margin({top:rvp(14)}).padding({left:rvp(24),right:rvp(24)})

    }
  }
}
/*
 [
    {
        "image": "http://localhost:6060/public/support_1.png",
        "title": "租期保洁服务",
        "subTitle": "每月2次公区保洁"
    },
    {
        "image": "http://localhost:6060/public/support_2.png",
        "title": "租期专业维修",
        "subTitle": "全天保修10min响应"
    },
    {
        "image": "http://localhost:6060/public/support_3.png",
        "title": "24小时云管家",
        "subTitle": "7*24小时在线受理"
    },
    {
        "image": "http://localhost:6060/public/support_4.png",
        "title": "优质管家",
        "subTitle": "租前租期悉心守护"
    }
],
 */