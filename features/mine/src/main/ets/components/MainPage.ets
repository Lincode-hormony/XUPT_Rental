import { router } from "@kit.ArkUI"
import {loginPage} from '../components/login'
import {loginCode} from '../components/loginCode'
import {LoginPhone} from '../components/login'
import {token} from '../components/loginCode'

@Preview
@Component

export struct Mine {
  @State message: string = '我的';
  @State Token:string=''

  @Consume('loginPathStack') pageStack :NavPathStack

  @Builder
  pageMap(pageName:string){
    if(pageName === 'loginPage'){
      loginPage()
    }else if(pageName==='loginCode'){
      loginCode()
    }
  }


  onPageShow(): void {

  }


  build() {
    Navigation(this.pageStack){
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
              Image($r('app.media.touxiang'))
                .width(50)
                .height(50)
                .borderRadius(20)
                .backgroundColor(Color.Pink)



              Column({space:7}){
                Text('登录/注册')
                  .fontSize(20)

                Text('请先登录注册')
                  .fontSize(15)
              }
            }
            .width(150)
            .height(65)
            //.backgroundColor(Color.Pink)
            .margin({top:20,left:15})
            .onClick(()=>{
              let pathInfo:NavPathInfo=new NavPathInfo('loginPage',(popInfo:PopInfo)=>{
                let phone:LoginPhone =popInfo.result as LoginPhone
                console.log('点击成功'+phone.phone)
                this.Token=phone.phone
              })
              this.pageStack.pushDestination(pathInfo,true)
              console.log('点击成功')
            })


          }

          ListItem(){
            Text(this.Token)
          }
        }
        .margin({top:35})

      }
      .width('100%')
      .height('100%')
    }
    .navDestination(this.pageMap)

    //.backgroundColor(Color.Grey)

  }
}
