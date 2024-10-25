import {RoomList} from '../views/RoomList'
@Component
export struct SearchBar{
  build() {
      Row(){
        Text('搜索')
          .width('100%')
          .height(40)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
  }
}