import {LoginPhone } from '../components/login'
import {loginApi,getUserApi} from '../api/login'
import {Response} from '../components/MainPage'

export class token{
  token:string='111'
}


@Component
export struct loginCode {


  async getToken(){
    const result=await loginApi(this.phoneNumber.phone,this.phoneCode)
    console.log('获取用户信息'+result.token)
    this.Token=result.token
    this.userToken=this.Token

  }

  async getInfo(){
    const result=await getUserApi(this.Token)
    console.log('获取用户信息'+result.data.nickname)
    this.userInfo=result as Response
  }

  @LocalStorageLink('userInfo') userInfo:Response=new Response()
  @StorageLink('Token') userToken:string='暂无用户数据'
  @State Token:string='暂无用户数据'
  @State phoneNumber:LoginPhone=new LoginPhone()
  @State phoneCode:string=''
  @Consume('loginPathStack') pageStack :NavPathStack

  build() {
    NavDestination(){
      Column(){
        Row(){
          Image($r('app.media.close'))
            .width(20)
            .onClick(()=>{
              this.pageStack.pop()
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
                this.getInfo()
                console.log('获取用户信息'+this.userInfo.message)
                this.pageStack.pop()
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
    .onReady(cxt=>{
      this.phoneNumber=cxt.pathInfo.param as LoginPhone
    })

  }
}
