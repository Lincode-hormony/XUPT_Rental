import { rvp } from "uicomponent"
import { IRentInfo, IRentInfoList } from "../../model/Room"

@Component
export struct RentInfo {
  @Prop rentInfo:IRentInfoList
  build() {
    Column(){
      Text('房屋信息').fontSize(rvp(18)).fontWeight(700).margin({top:rvp(32),bottom:rvp(16)})
        .alignSelf(ItemAlign.Start)
      Column({space:rvp(8)}){
        ForEach(this.rentInfo,(item:IRentInfo)=>{
          Row(){
            Image(item.image).width(rvp(34)).height(rvp(34))
              .margin({top:rvp(4),bottom:rvp(4),right:rvp(8)})
            Text(item.title).fontSize(rvp(12)).fontWeight(500)
            Blank()
            Text(item.userTag).fontSize(rvp(12)).fontWeight(500)
              .fontColor('#999999').margin({right:rvp(10)})
          }.width(rvp(328)).height(rvp(42))

        })
      }
    }.width('100%').padding({left:rvp(16)})
  }
}