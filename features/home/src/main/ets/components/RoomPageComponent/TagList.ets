import { rvp } from "uicomponent"
import { ITagItem, ITagList } from "../../model/HomeData"

@Component
export struct TagList {
  @Link tagList:ITagList
  aboutToAppear(): void {
    console.debug('测试TagList  '+JSON.stringify(this.tagList))
  }
  build() {
    Row({space:rvp(14)}){
      ForEach(this.tagList,(item:ITagItem)=>{
        Row(){
          Text(item.name).width(rvp(40)).height(rvp(12)).fontSize(rvp(10))
            .fontWeight(500)
        }.width(rvp(62)).height(rvp(20)).backgroundColor('#F7F7F7')
        .padding({left:8,right:8,bottom:4,top:4})
      })
    }.width('100%').padding({left:16,right:16,top:8})
  }
}
