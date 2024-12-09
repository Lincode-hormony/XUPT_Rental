import { router } from "@kit.ArkUI"
import {loginPage} from '../components/login'
import { backUserInfo, loginCode} from '../components/loginCode'
import {LoginPhone} from '../components/login'
import {getUserApi} from '../api/login'
import {token} from '../components/loginCode'
import { RouterUtil } from "router/src/main/ets/utils/RouterUtil"
import { BuilderNameConstants, RouterNameConstants } from "router/src/main/ets/constants/RouterConstants"
import { PreferencesUtil } from "@pura/harmony-utils"

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

class userInfo{
  img:string=''
  name:string=''
}

@Builder
function minePageBuilder(){
  Mine()
}




@Component

export struct Mine {

  @State userInfo:Response=new Response()
  @State message: string = '我的';
  @State Token:string=''
  @StorageProp('Token') userToken:string=''
  @State isLogin:boolean=false
  @State name:string=''
  @State img:string=''
  @State user:userInfo=new userInfo()


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
              if(!this.isLogin){
                Image($r('app.media.touxiang'))
                  .width(50)
                  .height(50)
                  .borderRadius(20)
                  .backgroundColor(Color.Pink)
              }else{
                Image(this.user.img)
                  .width(50)
                  .height(50)
                  .borderRadius(20)
              }

              if(!this.isLogin){
                Column({space:7}){
                  Text('登录/注册')
                    .fontSize(20)
                  Text('请先登录注册')
                    .fontSize(15)
                }
                .onClick(()=>{
                  RouterUtil.push(RouterNameConstants.ENTRY_HAP,BuilderNameConstants.MINE_MINEPAGE)
                  RouterUtil.push(RouterNameConstants.ENTRY_HAP,BuilderNameConstants.MINE_LOGIN,undefined,(onPop)=>{
                    this.userInfo=onPop.result as Response
                    console.log('登录：返回首页的用户信息：'+JSON.stringify(this.userInfo))
                    this.user.name=JSON.stringify(this.userInfo).substring(20,22)
                    this.user.img=JSON.stringify(this.userInfo).substring(34,86)
                    PreferencesUtil.putSync('userInfo',this.user)
                    RouterUtil.getRouter(RouterNameConstants.ENTRY_HAP)?.clear()
                  })
                })
              }else{
                Column(){
                  Text('你好！'+this.user.name)
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
    .onReady(()=>{
      const result=PreferencesUtil.getSync('userInfo','')
      if(result!=''){
        this.user=result as userInfo
        this.isLogin=true
      }
    })
  }
}

const builderName:string=BuilderNameConstants.MINE_MINEPAGE
if(!RouterUtil.getBuilder(builderName)){
  const builder:WrappedBuilder<[object]>=wrapBuilder(minePageBuilder)
  RouterUtil.registerBuilder(builderName,builder)
}
