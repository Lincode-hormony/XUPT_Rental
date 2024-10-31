import { rvp,WhiteText,BlackText } from "uicomponent"
import { IRentTerm } from "../../model/Room"

@Component
export struct RentTerm {
  @Prop @Watch('rentTermChange')rentTerm:IRentTerm//数据源发生改变
  rentTermChange(){
    this.content=[this.rentTerm.kitchen,this.rentTerm.lift,this.rentTerm.year,this.rentTerm.renovation,this.rentTerm.grounding,this.rentTerm.heating]
  }@State content:string[]=[]
  readonly title:string[]=['厨房','电梯','年代','装修','上架','供暖']

  build() {
    Column({space:rvp(16)}){
      Row(){
        WhiteText({value:'入住'})
        BlackText({value:this.rentTerm.term})
      }.width('100%').justifyContent(FlexAlign.Start).padding({left:rvp(16)})
      Row(){
        WhiteText({value:'租期'})
        BlackText({value:this.rentTerm.checkInTime})
      }.width('100%').justifyContent(FlexAlign.Start).padding({left:rvp(16)})

      Grid(){
        ForEach(this.title,(item:string,index:number)=>{
          GridItem(){
            Row(){
              WhiteText({value:item})
              BlackText({value:this.content[index]})
            }.width('50%').justifyContent(FlexAlign.Start).padding({left:rvp(16)})
          }.height(rvp(16))
        },(index:number)=>this.content[index])
      }.height(80).width('100%').columnsTemplate('1fr 1fr').rowsTemplate("1fr 1fr 1fr")
      .rowsGap(rvp(16)).padding({right:rvp(16)})

      Row(){
        WhiteText({value:'绿化'})
        BlackText({value:this.rentTerm.green})
      }.width('100%').justifyContent(FlexAlign.Start).padding({left:rvp(16)})
      Row(){
        WhiteText({value:'环保'})
        BlackText({value:this.rentTerm.protection})
      }.width('100%').justifyContent(FlexAlign.Start).padding({left:rvp(16)})
      Row(){
        WhiteText({value:'小区'})
        BlackText({value:this.rentTerm.house})
      }.width('100%').justifyContent(FlexAlign.Start).padding({left:rvp(16)})

    }.width('100%').margin({top:rvp(16)})
  }
}
/*
Row(){Text('row2')}.justifyContent(FlexAlign.Center).width(100)
          .backgroundColor("#FFCC00")
          .alignRules({
            top: {anchor: "__container__", align: VerticalAlign.Top},
            right: {anchor: "__container__", align: HorizontalAlign.End},
            bottom: {anchor: "row1", align: VerticalAlign.Center},
          })
          .offset({
            x:-40,
            y:-20
          })
          .id("row2")
 */
/*
{
    "checkInTime": "租期最长1年10个月",
    "term": "随时入住",
    "kitchen": "有",
    "lift": "有",
    "seeTime": "可随时看房",
    "year": "2022年建成",
    "renovation": "谷粒6.0",
    "grounding": "非首次出租",
    "heating": "集体供暖",
    "green": "30%",
    "protection": "房屋空气质量已检测",
    "house": "新翠景园"
},
 */