import { IHousePictureItem, IHousePictureList } from "../../model/Room"
import {rvp} from "uicomponent"
interface ISpaceName{
  spaceName:string
  count:number
}
@Component
export struct NavSwiper {
  @Link @Watch('onHousePictureListChange')housePictureList:IHousePictureList
  @State spaceNameList:ISpaceName[]=[]
  @State curClass:number=0;
  imageScroll:Scroller=new Scroller()
  classScroll:Scroller=new Scroller()
  onHousePictureListChange(){
    this.spaceNameList=[]
    this.housePictureList.forEach((item,index:number)=>{
      this.spaceNameList.push({spaceName:item.spaceName,count:item.picList.length})
    })
  }
  build() {
    Column(){
      /**
       * 一级列表
       */
      List({scroller:this.classScroll,space:rvp(16)}){
        ForEach(this.spaceNameList,(item:ISpaceName,index:number)=>{
          ListItem(){
            Text(item.spaceName+"("+item.count+")")
              .fontSize(rvp(14)).fontWeight(500).fontColor(index===this.curClass?'#262626':'#666666')
              .onClick(()=>{
                this.curClass=index;
                this.imageScroll.scrollToIndex(index,true);
              })
          }
        },(item:ISpaceName)=>item.spaceName)
      }.listDirection(Axis.Horizontal).scrollBar(BarState.Off)

      /**
       * 二级列表
       */
      List({scroller:this.imageScroll,space:rvp(10)}){
        ForEach(this.housePictureList,(housePictureItem:IHousePictureItem,classIndex:number)=>{
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
      .onScrollIndex((start,end)=>{
        this.curClass=start
        this.classScroll.scrollToIndex(start,true)
      })
    }
  }
}