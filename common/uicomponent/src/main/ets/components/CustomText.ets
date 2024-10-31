import { rvp } from "../utils/DeviceScreen"

@Component
export struct WhiteText {
  @Prop value:string
  build() {
    Text(this.value).width(rvp(28)).height(rvp(16)).fontSize(rvp(14))
      .fontWeight(500).fontColor('#999999')
      .margin({right:rvp(16)})
  }
}

@Component
export struct BlackText {
  @Prop value:string
  build() {
    Text(this.value).height(rvp(16)).fontSize(rvp(14))
      .fontWeight(500).fontColor('#000000')
  }
}
