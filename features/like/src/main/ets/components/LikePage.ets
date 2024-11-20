import {PreferencesUtil} from '@pura/harmony-utils'
import {IRoomData,GetRoomDetailApi} from 'home'
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
  @State message: string = '收藏';
  @State likeIdList:string[]=[];
  @State roomList:IRoomData[]=[]
  @Consume("TabsCurIndex") @Watch("aboutToAppear") curIndex:number;
  /**
   * 获取收藏房源数据
   */
  aboutToAppear(): void {
    if(this.curIndex===5){
      PreferencesUtil.getAll("Like")
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
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        List({space:20}){
          ForEach(this.roomList,(item:IRoomData)=>{
            /**
             * 收藏房间照片和标题
             */
            ListItem(){
              Row(){
                Image(item.housePicture[0].picList[0])
                  .width(50)
                Text(item.houseTitle)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
              }
            }
          })
        }
      }
      .width('100%')
    }
    .height('100%')
  }
}
