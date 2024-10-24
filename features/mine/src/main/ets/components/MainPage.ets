import { router } from "@kit.ArkUI"

@Preview
@Component
export struct MainPage {

  build() {
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
              .onClick(()=>{
                router.pushUrl({
                  url:'components/login'
                })
              })


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


        }
      }
      .margin({top:35})

    }
    .width('100%')
    .height('100%')
    //.backgroundColor(Color.Grey)

  }
}
