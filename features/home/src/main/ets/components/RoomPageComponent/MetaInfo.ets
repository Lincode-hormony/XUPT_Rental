import {rvp} from "uicomponent"
import { IMetaInfoItem, IMetaInfoList } from "../../model/Room"

@Component
export struct MetaInfo {
  @Link metaInfo:IMetaInfoList
  @Builder
  metaInfoItem(item:IMetaInfoItem){
    Column({space:rvp(6)}){
      Text(item.name).fontSize(12).fontWeight(500).fontColor('#999999')
      Text(item.desc+(item.name==='使用面积'?'m2':'')).fontSize(14).fontWeight(500).fontColor('#000000')
    }
  }
  build() {
    Row({space:rvp(10)}){
      Grid(){
        ForEach(this.metaInfo,(item:IMetaInfoItem)=>{
          GridItem(){this.metaInfoItem(item)}
        },(item:IMetaInfoItem)=>item.name)
      }.width(rvp(175)).height(rvp(104)).backgroundColor('#fff5f5f5')
      .columnsTemplate('1fr 1fr').rowsTemplate('1fr 1fr')
      .columnsGap(rvp(10)).rowsGap(rvp(12))

      Column({space:rvp(4)}){
        Row(){
          Text('该房源附近没有地铁').fontSize(12).fontWeight(500).fontColor('#000000')
        }.width(rvp(170)).height(rvp(50)).backgroundColor('#F8F8F8')
        Row(){
          Text('公司').fontSize(12).fontWeight(500).fontColor('#000000')
        }.width(rvp(170)).height(rvp(50)).backgroundColor('#F8F8F8')
      }
    }.width('100%').height(rvp(104)).padding({left:rvp(16),right:rvp(16),bottom:rvp(12)})
  }
}
