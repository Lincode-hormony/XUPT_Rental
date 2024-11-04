import { ISortList,ISortItem, ISearchParams } from "../../model/RoomList"

@Component
export struct SortRender{
  readonly sortList:ISortList=[
    {
      id:1,
      text:'综合排序',
      img:$r('app.media.sort')
    },
    {
      id:2,
      orderBy:'price',
      text:'价格从低到高',
      img:$r('app.media.rent')
    },
    {
      id:3,
      orderBy:'price',
      orderType:'desc',
      text:'价格从高到低',
      img:$r('app.media.rent')
    },
    {
      id:4,
      orderBy:'area',
      text:'面积从小到大',
      img:$r('app.media.area')
    },
    {
      id:5,
      orderBy:'area',
      orderType:'desc',
      text:'面积从大到小',
      img:$r('app.media.area')
    }
  ]
  @State curSortLimit:number=0
  @Consume searchParams: ISearchParams
  // isRenderImage(label: string) : number {
  //   console.info(`Image label ${label} is rendered`);
  //   return 1;
  // }
  // isRenderText(label: string) : number {
  //   console.info(`Text label ${label} is rendered`);
  //   return 1;
  // }
  build() {
    Column(){
      List({space:6}){
        ForEach(this.sortList,(item:ISortItem)=>{
          ListItem(){
            Row({space:8}){
              Image(item.img).width(20)
                // .opacity(this.isRenderImage(item.text))
              Text(item.text).fontSize(12).fontColor(this.curSortLimit===item.id?'#009B71':'#666666')
                // .opacity(this.isRenderText(item.text))
            }.height(34).backgroundColor(this.curSortLimit===item.id?'#eeeeee':Color.White)
            .margin({left:32}).padding(6)
            .onClick(()=>{
              this.curSortLimit=item.id
            })
          }
        },(item:ISortItem)=>JSON.stringify(item.id))
      }.margin(16).height(194).width('100%').scrollBar(BarState.Off)
      Row(){
        Button('重置')
          .type(ButtonType.Normal).backgroundColor('#dddddd')
          .width(95)
          .onClick(()=>{
            this.curSortLimit=0
          })

        Button('查看房源')
          .type(ButtonType.Normal).backgroundColor('#009B71')
          .width(211)
          .onClick(()=>{
            // if(this.curSortLimit){
            //   // if(this.sortList[this.curSortLimit-1].orderBy)
            //     this.searchParams.page=1
            //     this.searchParams.orderBy=this.sortList[this.curSortLimit-1].orderBy
            //   // if(this.priceLimitList[this.curPriceLimit-1].maxRent)
            //     this.searchParams.orderType=this.sortList[this.curSortLimit-1].orderType
            // }else{
            //   this.searchParams.orderBy=''
            //   this.searchParams.orderType=''
            // }
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
            if(this.curSortLimit){
              newSearchParams.page=1
              newSearchParams.orderBy=this.sortList[this.curSortLimit-1].orderBy
              newSearchParams.orderType=this.sortList[this.curSortLimit-1].orderType
            }else{
              newSearchParams.orderBy=''
              newSearchParams.orderType=''
            }
            this.searchParams=newSearchParams
          })
      }
      .height(56)
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }.height(280).width('100%')
    .backgroundColor(Color.White)
  }
}