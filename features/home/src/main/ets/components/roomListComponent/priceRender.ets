import { IPriceLimitItem, IPriceLimitList, ISearchParams } from "../../model/RoomList"

@Component
export struct PriceRender{
  readonly priceLimitList:IPriceLimitList=[
    {
      id: 1,
      text: '不限'
    },
    {
      id: 2,
      minRent: '0',
      maxRent: '1500',
      text: '1500元以下'
    },
    {
      id: 3,
      minRent: '1500',
      maxRent: '2500',
      text: '1500-2500元'
    },
    {
      id: 4,
      minRent: '2500',
      maxRent: '3500',
      text: '2500-3500元'
    },
    {
      id: 5,
      minRent: '3500',
      maxRent: '4500',
      text: '3500-4500元'
    },
    {
      id: 6,
      minRent: '4500',
      maxRent: '6000',
      text: '4500-6000元'
    },
    {
      id: 7,
      minRent: '6000',
      maxRent: '8000',
      text: '6000-8000元'
    },
    {
      id: 8,
      minRent: '8000',
      maxRent: '10000',
      text: '8000-10000元'
    },
    {
      id: 9,
      minRent: '10000',
      text: '10000元以上'
    }
  ]
  @State curPriceLimit:number=0//
  @Consume searchParams: ISearchParams
  isRenderButton(label: string) : number {
    console.info(`Button label ${label} is rendered`);
    return 1;
  }
  build() {
    Column(){
      Column(){
        Grid(){
          ForEach(this.priceLimitList,(item:IPriceLimitItem)=>{
            GridItem(){
              Button(item.text)
                .opacity(this.isRenderButton(item.text))
                .type(ButtonType.Normal)
                .fontSize(11)
                .fontColor(this.curPriceLimit===item.id?Color.White:'#999999')
                .backgroundColor(this.curPriceLimit===item.id?'#009B71':'#eeeeee')
                .width(110)
                .height(26)
                .onClick(()=>{
                  this.curPriceLimit=item.id
                })
            }
          },(item:IPriceLimitItem)=>JSON.stringify(item.id))
        }.rowsTemplate('1fr 1fr 1fr').columnsTemplate('1fr 1fr 1fr')
        .rowsGap(8).columnsGap(22)
      }.height(138).padding(16).width('100%')
      Row(){
        Button('重置')
          .type(ButtonType.Normal).backgroundColor('#dddddd')
          .width(95)
          .onClick(()=>{
            this.curPriceLimit=0
          })

        Button('查看房源')
          .type(ButtonType.Normal).backgroundColor('#009B71')
          .width(211)
          .onClick(()=>{
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
            if(this.curPriceLimit){
              newSearchParams.page=1
              newSearchParams.minRent=this.priceLimitList[this.curPriceLimit-1].minRent
              newSearchParams.maxRent=this.priceLimitList[this.curPriceLimit-1].maxRent
            }else{
              newSearchParams.minRent=''
              newSearchParams.maxRent=''
            }
            this.searchParams=newSearchParams
          })
      }
      .height(56)
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }.height(194).width('100%')
    .backgroundColor(Color.White)
  }
}