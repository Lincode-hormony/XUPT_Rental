import {LoginPhone } from '../components/login'
import {loginApi,userID} from '../api/login'

export class token{
  token:string='111'
}


@Component
export struct loginCode {

  async getUser(){
    const result=await loginApi(this.phoneNumber.phone,this.phoneCode)
    this.Token=result.token
  }

  @State Token:string=''
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
                this.getUser()
                let userToken:token=new token()
                userToken.token=this.Token
                console.log('获取Token1'+userToken)
                this.pageStack.pop(userToken,true)
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
