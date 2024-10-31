import { IHousePictureItem, IHousePictureList } from "../../model/Room"
import {rvp} from "uicomponent"
@Component
export struct NavSwiper {
  @Link housePictureList:IHousePictureList
  imageScroll:Scroller=new Scroller()
  build() {
    List({scroller:this.imageScroll}){
      ForEach(this.housePictureList,(housePictureItem:IHousePictureItem)=>{
        ListItemGroup({space:rvp(10)}){
          ForEach(housePictureItem.picList,(item:string)=>{
            ListItem(){
              Image(item)
                .width(rvp(318))
                .height(rvp(192))
            }
          })
        }
      })
    }
    .listDirection(Axis.Horizontal)
    .scrollBar(BarState.Off)
    .margin(rvp(16))
  }
}