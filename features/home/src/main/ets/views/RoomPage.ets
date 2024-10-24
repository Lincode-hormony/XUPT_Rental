/**
 * 房间详情数据页面
 * 网路访问要带数据
 */

import {ISupportLIst} from '../model/Room'
import {GetRoomDetailApi} from '../apis/home'
import { router } from '@kit.ArkUI';

@Component
export struct RoomPage {
  // @State roomId: string=router.getParams() as string;
  @State supportLIst:ISupportLIst=[]
  @Prop roomId: string;
  @Consume('homePathStack') homePathStack:NavPathStack

  aboutToAppear(): void {
    this.getRoomDetail();
  }
  getRoomDetail(){
    GetRoomDetailApi(this.roomId)
      .then((data)=>{
        this.supportLIst=data.support
        console.debug('测试房屋详情数据'+JSON.stringify(this.supportLIst))
      })
  }

  build() {
    NavDestination(){
      Scroll() {
        Column() {
          Text(JSON.stringify(this.supportLIst))
            .fontSize(30)
        }
        .width('100%')
      }
      .height('100%')
    }
    .title('房屋详情')

  }
}
