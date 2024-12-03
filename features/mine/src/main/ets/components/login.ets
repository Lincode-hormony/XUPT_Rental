import {sendSMSCodeApi} from '../api/login'
export class LoginPhone{
  phone:string=''
}
/*TODO
账号的Token每一次都需要登录一边才能拿到，
待修改：如果之前登陆过，没有退出登录，则本次不需要再次登录，直接延用之前的登陆状态
 */
@Component
export struct loginPage {


  @State isSelect:boolean=false
  @State phoneNumber:LoginPhone=new LoginPhone()
  @Consume('loginPathStack') pageStack :NavPathStack

  @Builder
  NavTitle(){
    Row(){
      Text('验证码登录')
    }
    .width('100%')
    .alignSelf(ItemAlign.Center)
    .backgroundColor('#defbe5')
  }

  //发送验证码
  send(){
    sendSMSCodeApi(this.phoneNumber.phone)
  }

  build() {
    NavDestination(){
      Column(){
        Row(){
          Image($r('app.media.close'))
            .width(20)
            .onClick(()=>{
              this.pageStack.pop(this.phoneNumber,true)
            })

          Text('验证码登录')
            .fontSize(19)
            .fontWeight(700)
            .margin({left:92})
        }
        .width('100%')
        .padding(15)
        .align(Alignment.Start)

        TextInput({placeholder:'请输入手机号'})
          .type(InputType.Number)
          .maxLength(11)
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
            this.phoneNumber.phone=value
          })

        Row(){
          Checkbox()
            .width(10)
            .onChange((val)=>{
              this.isSelect=val
            })
          Text('是否同意协议')
            .fontSize(10)
            .fontColor('#c1c1c1')
        }
        .width('100%')
        .margin({top:10,left:68})

        if(this.phoneNumber.phone.length == 11 && this.isSelect == true){
          Row(){
            Button('获取验证码')
              .backgroundColor('#ff69d76c')
              .onClick(()=>{
                this.send()

                let loginPhone:LoginPhone=new LoginPhone()

                let pageInfo:NavPathInfo=new NavPathInfo('loginCode',this.phoneNumber,(popInfo:PopInfo)=>{
                  let loginPhone:LoginPhone=popInfo.info.param as LoginPhone
                })
                this.pageStack.replacePath(pageInfo,true)
              })

          }
          .width('100%')
          .margin({top:20})
          .padding({left:228})
          .alignSelf(ItemAlign.Center)


        }else{
          Row(){
            Button('获取验证码')
              .backgroundColor('#b3e2dfdf')
          }
          .width('100%')
          .margin({top:20})
          .padding({left:228})
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
