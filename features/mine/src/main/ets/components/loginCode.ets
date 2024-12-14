import {LoginPhone } from '../components/login'
import {loginApi,getUserApi} from '../api/login'
import { BuilderNameConstants, RouterNameConstants } from 'router/src/main/ets/constants/RouterConstants'
import { RouterUtil } from 'router/src/main/ets/utils/RouterUtil'
import {userModel} from '../model/UserModel'

export class token{
  token:string='111'
}

export class backUserInfo{
  img:string=''
  name:string=''
}

@Builder
function loginCodeBuilder(phoneNum:object){
  loginCode({phoneNum:phoneNum as LoginPhone})
}



@Component
export struct loginCode {

  async getToken(){
    const result=await loginApi(this.phoneNum.phone,this.phoneCode)
    console.log('登录：获取token信息'+result.token)
    this.Token=result.token
    this.userToken=this.Token
    this.userPhone=this.phoneNum.phone // HLQ  用户区别用户的收藏列表
    const userinfo=await getUserApi(result.token)
    this.userInfo=userinfo
    console.log('登录：userInfo的值：'+JSON.stringify(this.userInfo))
    RouterUtil.getRouter(RouterNameConstants.ENTRY_HAP)?.pop()
  }

  @Prop phoneNum:LoginPhone
  @StorageLink('UserInfo') userInfo:userModel=new userModel()
  @StorageLink('Token') userToken:string='暂无用户数据'
  @StorageLink('Phone') userPhone:string='' // HLQ  用户区别用户的收藏列表
  @State Token:string='暂无用户数据'
  @State phoneCode:string=''


  build() {
    NavDestination(){
      Column(){
        Row(){
          Image($r('app.media.close'))
            .width(20)
            .onClick(()=>{
              RouterUtil.pop(RouterNameConstants.ENTRY_HAP)
            })

          Text('验证码登录')
            .fontSize(19)
            .fontWeight(700)
            .margin({left:92})
        }
        .width('100%')
        .padding(15)
        .align(Alignment.Start)

        TextInput({placeholder:'请输入验证码'})
          .type(InputType.Number)
          .maxLength(6)
          .placeholderFont({size:16})
          .placeholderColor('#c1c1c1')
          .backgroundColor('#00ffffff')
          .fontSize(16)
          .border({
            width:{
              bottom:1
            },
            color:'#c4edce'
          })
          .borderRadius(0)
          .width('85%')
          .padding({top:20,left:15})
          .caretColor('#c1c1c1')
          .onChange((value)=>{
            this.phoneCode=value
          })


        if(this.phoneCode.length == 6){
          Row(){
            Button('确定')
              .backgroundColor('#ff69d76c')
              .onClick(()=>{
                this.getToken()
              })
          }
          .width('100%')
          .margin({top:20})
          .padding({left:270})
          .alignSelf(ItemAlign.Center)
        }else {
          Row(){
            Button('确定')
              .backgroundColor('#b3e2dfdf')
          }
          .width('100%')
          .margin({top:20})
          .padding({left:270})
          .alignSelf(ItemAlign.Center)
        }
      }
      .height('100%')
      .width('100%')
      .linearGradient({
        direction:GradientDirection.Bottom,
        colors:[['#defbe5',0],['#ffffff',0.2]]
      })
    }
    .hideTitleBar(true)
  }
}

const builderName:string=BuilderNameConstants.MINE_LOGINCODE
if(!RouterUtil.getBuilder(builderName)){
  const builder:WrappedBuilder<[object]>=wrapBuilder(loginCodeBuilder)
  RouterUtil.registerBuilder(builderName,builder)
}
