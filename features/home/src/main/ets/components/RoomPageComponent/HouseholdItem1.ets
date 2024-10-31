import { rvp } from "uicomponent"
import { IHouseholdItemItem, IItemItem } from "../../model/Room"

@Component
export struct HouseholdItem1 {
  @Prop householdItem:IHouseholdItemItem
  build() {
      Column(){
        Text(){
          Span(this.householdItem.name+'  ').fontSize(rvp(14)).fontWeight(700)
          Span(this.householdItem.itemList.length+'件物品').fontSize(rvp(10)).fontWeight(500)
            .fontColor('#999999')
        }.alignSelf(ItemAlign.Start).padding({left:rvp(16)}).margin({bottom:rvp(16)})
        Grid(){
          ForEach(this.householdItem.itemList,(item:IItemItem)=>{
            GridItem(){
              Row(){
                Image(item.icon).width(rvp(16)).alignSelf(ItemAlign.Start)
                Text(item.value).fontSize(rvp(14)).fontWeight(500)
                  .fontColor('#666666')
              }.width('100%').justifyContent(FlexAlign.Start)
            }
          })
        }.width('100%').height(rvp(48))
        .rowsTemplate('1fr 1fr').columnsTemplate('1fr 1fr 1fr')
        .alignSelf(ItemAlign.Start).margin({left:rvp(17)})
      }
  }
}
/*
"householdItem": [
            {
                "name": "01房间",
                "itemList": [
                    {
                        "icon": "http://localhost:6060/public/item_1.png",
                        "value": "2.2米床"
                    },
                    {
                        "icon": "http://localhost:6060/public/item_1.png",
                        "value": "三开内衣柜"
                    },
                    {
                        "icon": "http://localhost:6060/public/item_1.png",
                        "value": "0.9米书桌"
                    },
                    {
                        "icon": "http://localhost:6060/public/item_1.png",
                        "value": "书桌"
                    },
                    {
                        "icon": "http://localhost:6060/public/item_1.png",
                        "value": "空调"
                    },
                    {
                        "icon": "http://localhost:6060/public/item_1.png",
                        "value": "智能锁"
                    }
                ]
            },
            {
                "name": "公共区域",
                "itemList": [
                    {
                        "icon": "http://localhost:6060/public/item_1.png",
                        "value": "冰箱"
                    },
                    {
                        "icon": "http://localhost:6060/public/item_1.png",
                        "value": "油烟机"
                    },
                    {
                        "icon": "http://localhost:6060/public/item_1.png",
                        "value": "微波炉"
                    },
                    {
                        "icon": "http://localhost:6060/public/item_1.png",
                        "value": "洗衣机"
                    },
                    {
                        "icon": "http://localhost:6060/public/item_1.png",
                        "value": "智能锁"
                    },
                    {
                        "icon": "http://localhost:6060/public/item_1.png",
                        "value": "花洒"
                    },
                    {
                        "icon": "http://localhost:6060/public/item_1.png",
                        "value": "浴霸"
                    },
                    {
                        "icon": "http://localhost:6060/public/item_1.png",
                        "value": "餐桌"
                    },
                    {
                        "icon": "http://localhost:6060/public/item_1.png",
                        "value": "燃气灶"
                    },
                    {
                        "icon": "http://localhost:6060/public/item_1.png",
                        "value": "电热水器"
                    }
                ]
            }
        ],
 */