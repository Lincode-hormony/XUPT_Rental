/**
 * 房间 详情 数据页面
 * 网路访问要带数据
 */

import {IRoomData,ISupportLIst,IHousePictureList,IHousePictureItem} from '../model/Room'
import {GetRoomDetailApi} from '../apis/home'

@Component
export struct RoomPage {
  @State room:Partial<IRoomData>={}
  @State houseTitle:string='房屋详情'
  @State supportLIst:ISupportLIst=[]
  @State housePictureList:IHousePictureList=[]
  @Prop roomId: string;
  @Consume('homePathStack') homePathStack:NavPathStack
  imageScroll:Scroller=new Scroller()
  aboutToAppear(): void {
    this.getRoomDetail();
  }
  getRoomDetail(){
    GetRoomDetailApi(this.roomId)
      .then((data)=>{
        this.room=data
        this.houseTitle=data.houseTitle
        this.supportLIst=data.support
        this.housePictureList=data.housePicture
        console.debug('测试房屋详情数据'+JSON.stringify(this.supportLIst))
      })
  }

  @Builder
  HousePictureList(){
    List({scroller:this.imageScroll}){
      ForEach(this.housePictureList,(housePictureItem:IHousePictureItem)=>{
        ListItemGroup({}){
            ForEach(housePictureItem.picList,(item:string)=>{
              ListItem(){
                Image(item)
                  .width(318)
                  .height(192)
                  .margin(10)
              }
            })
        }
      })
    }
    .listDirection(Axis.Horizontal)
    .scrollBar(BarState.Off)
    .margin(16)
  }
  @Builder
  NavTirle(){
    Text(this.houseTitle)
      .height(55)
      .textAlign(TextAlign.Center)
      .fontSize(20)
  }

  build() {
    NavDestination(){
      Scroll() {
        Column() {
          this.HousePictureList()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .title(this.NavTirle)


  }
}
