import {Home} from 'home'

let  TooTmp: ToolbarItem={
  'value':"func",
  'icon':"../../resources//base//media/home.svg",
  'action':()=>{}
}
let TooBar:ToolbarItem[]=[TooTmp,TooTmp,TooTmp,TooTmp,TooTmp]

@Entry
@Component
struct Index {

  build() {
    Navigation() {
      Column(){
        Home()
      }
      .width('100%')
      .height('100%')
    }
    .title('西邮租房')
    .toolbarConfiguration(TooBar)
    .titleMode(NavigationTitleMode.Full)
    .height('100%')
    .width('100%')
  }
}