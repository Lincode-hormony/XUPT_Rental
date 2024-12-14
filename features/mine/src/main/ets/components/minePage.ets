import { RouterUtil } from "router/src/main/ets/utils/RouterUtil"
import { BuilderNameConstants, RouterNameConstants } from "router/src/main/ets/constants/RouterConstants"
import {userModel} from '../model/UserModel'

PersistentStorage.persistProp('UserInfo',{nickname:'',id:0,avatar:''} as userModel)

export class Response {
  code: number=0
  data: Data=new Data()
  message: string='66'
}

class Data {
  avatar: string=''
  id: number=0
  nickname: string=''
}


@Builder
function minePageBuilder(){
  Mine()
}




@Component

export struct Mine {

  @State message: string = '我的';
  @StorageProp('Token') userToken:string=''
  @StorageProp('UserInfo') userInfo:userModel={} as userModel


  build() {
    NavDestination(){

      Stack({alignContent:Alignment.TopStart}){
        Row(){
          Text('导航栏')
        }
        .width('100%')
        .backgroundColor(Color.Pink)
        .height(35)

        List(){
          ListItem(){
            Row({space:5}){
              if(this.userInfo.avatar==''){
                Image($r('app.media.touxiang'))
                  .width(50)
                  .height(50)
                  .borderRadius(20)
                  .backgroundColor(Color.Pink)
              }else{
                Image(this.userInfo.avatar)
                  .width(50)
                  .height(50)
                  .borderRadius(20)
              }

              if(this.userInfo.nickname==''){
                Column({space:7}){
                  Text('登录/注册')
                    .fontSize(20)
                  Text('请先登录注册')
                    .fontSize(15)
                }
                .onClick(()=>{
                  RouterUtil.push(RouterNameConstants.ENTRY_HAP,BuilderNameConstants.MINE_LOGIN)
                })
              }else{
                Column(){
                  Text('你好！'+this.userInfo.nickname)
                  Text('欢迎来到东邮租房')
                    .fontSize(15)
                }
              }
            }
            .width(300)
            .height(65)
            .margin({top:20,left:15})
          }
        }
        .margin({top:35})
      }
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(true)
  }
}

const builderName:string=BuilderNameConstants.MINE_MINEPAGE
if(!RouterUtil.getBuilder(builderName)){
  const builder:WrappedBuilder<[object]>=wrapBuilder(minePageBuilder)
  RouterUtil.registerBuilder(builderName,builder)
}
