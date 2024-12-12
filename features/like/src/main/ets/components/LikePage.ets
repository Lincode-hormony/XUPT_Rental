import {PreferencesUtil} from '@pura/harmony-utils'
import {IRoomData,GetRoomDetailApi} from 'home'
import { ITagItem } from 'home/src/main/ets/model/HomeData';
import { BuilderNameConstants, RouterNameConstants } from 'router/src/main/ets/constants/RouterConstants';
import { RouterUtil } from 'router/src/main/ets/utils/RouterUtil';
import { rvp } from 'uicomponent';

/**
 * 获取Object的Keys
 * @param obj
 * @returns
 */
function getObjKeys(obj: Object): string[] {
  let keys = Object.keys(obj);
  return keys;
}
@Component
export struct LikePage {
  // @Consume('homePathStack') homePathStack:NavPathStack
  @State message: string = '收藏';
  @State likeIdList:string[]=[];
  @State roomList:IRoomData[]=[]
  @Consume("TabsCurIndex") @Watch("aboutToAppear") curIndex:number;
  @StorageProp("Phone") userPhone:string=''
  /**
   * 获取收藏房源数据
   */
  aboutToAppear(): void {
    if(this.curIndex===2&&this.userPhone){
      PreferencesUtil.getAll("Like"+this.userPhone)
        .then((value:object)=>{
          this.likeIdList=getObjKeys(value);
          // console.debug('LikePage: '+JSON.stringify((value as HashMap<string,boolean>).keys()))
          // console.debug('LikePage: '+JSON.stringify(Keys))
          this.roomList=[];
          //遍历把所有的房间数据都放进列表中
          for(let i=0;i<this.likeIdList.length;i++){
            GetRoomDetailApi(this.likeIdList[i]).then((data:IRoomData)=>{
              this.roomList.push(data)
            })
          }
        })
        .catch(()=>{
          console.debug('LikePage: 获取首选项Keys失败')
        })
    }
  }

  build() {
    Column() {
      Row(){
        Text(){
          Span("收藏列表").fontSize(26).fontWeight(700).fontColor('#eeeeee').letterSpacing(16)
        }.margin({bottom:rvp(16)})
      }.width('100%').height(rvp(30)).justifyContent(FlexAlign.Center).backgroundColor('#ff56ba6e')
      List({space:rvp(15)}){
        ForEach(this.roomList,(item:IRoomData)=>{
          /**
           * 收藏房间照片和标题
           */
          ListItem(){
            Column({space:rvp(2)}){
              Divider().margin({bottom:rvp(4)})
              //标题
              Text(item.houseTitle).fontSize(20).fontWeight(700)
              //地点 标签 价格 面积
              Row({space:rvp(10)}){
                Image(item.housePicture[0].picList[0]).width(rvp(160)).height(rvp(124)).borderRadius(rvp(8))
                  .onClick(()=>{
                    // this.homePathStack.pushPathByName('RoomPage',item.id)
                    RouterUtil.push(RouterNameConstants.ENTRY_HAP,BuilderNameConstants.ROOM_PAGE,item.id)
                  })
                Column(){
                  Text(item.address).fontSize(18).fontWeight(500).alignSelf(ItemAlign.Start)
                    .margin({top:rvp(16),bottom:rvp(50)})
                  Row({space:rvp(4)}){
                    ForEach(item.tags,(tag:ITagItem,index:number)=>{
                      if(index<3) Text(tag.name).fontSize(16).fontWeight(500).fontColor('#eeeeee').backgroundColor('#36D1a1')
                    })
                  }.width('100%').justifyContent(FlexAlign.Start).margin({bottom:rvp(4)})
                  Row(){
                    Text(item.rentPriceUnitListing+item.rentPriceUnit).fontSize(18).fontWeight(500).fontColor('#E03810')
                    Blank()
                    Text(item.rentArea).fontSize(16).fontWeight(500)
                  }.width('100%').justifyContent(FlexAlign.Start)
                }.height('100%').justifyContent(FlexAlign.Start)
              }.height(rvp(140)).width('100%').justifyContent(FlexAlign.Start)

            }.width('100%').alignItems(HorizontalAlign.Start)
          }.width('100%').height(rvp(180))
        },(item:IRoomData)=>item.id)
      }.padding({left:rvp(16),right:rvp(16),bottom:rvp(40)}).backgroundColor('#ffececec')
    }.width('100%').height('100%')
  }
}
