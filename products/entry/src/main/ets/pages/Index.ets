import {Home} from 'home'
import {MainPage} from 'mine'

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
        MainPage()
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