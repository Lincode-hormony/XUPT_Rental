import { ISearchParams } from "../model/RoomList"

@Component
export struct payTypeRender{
  readonly payTypeList:string[]=['月付','季付','半年付','年付']
  @Consume searchParams: ISearchParams
  @State curPayType:string=''
  build() {
    Column(){
      Row(){
        ForEach(this.payTypeList,(item:string)=>{
          Button(item)
            .type(ButtonType.Normal)
            .fontSize(12)
            .fontColor(this.curPayType===item?Color.White:'#999999')
            .backgroundColor(this.curPayType===item?'#009B71':'#eeeeee')
            .width(70)
            .height(26)
            .onClick(()=>{
              this.curPayType=item
            })
        })
      }.width('100%').justifyContent(FlexAlign.SpaceAround).margin({bottom:26})
      Row(){
        Button('重置')
          .type(ButtonType.Normal).backgroundColor('#dddddd')
          .width(95)
          .onClick(()=>{
            this.curPayType=''
          })

        Button('查看房源')
          .type(ButtonType.Normal).backgroundColor('#009B71')
          .width(211)
          .onClick(()=>{
            // this.searchParams.page=1
            // this.searchParams.paymentType=this.curPayType
            let newSearchParams:ISearchParams= {
              page: this.searchParams.page,
              limit: this.searchParams.limit,
              maxRent: this.searchParams.maxRent,
              minRent:this.searchParams.minRent,
              cityCode:this.searchParams.cityCode,
              districtCode: this.searchParams.districtCode,
              orderBy: this.searchParams.orderBy,
              orderType:this.searchParams.orderType,
              paymentType: this.searchParams.paymentType,
              provinceCode:this.searchParams.provinceCode,
            }
            newSearchParams.page=1
            newSearchParams.paymentType=this.curPayType
            this.searchParams=newSearchParams
          })
      }
      .height(56)
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }
    .backgroundColor(Color.White)
  }
}