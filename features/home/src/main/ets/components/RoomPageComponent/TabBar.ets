import { ToastUtil,PreferencesUtil} from "@pura/harmony-utils";
import { rvp } from "uicomponent";
import { PostBookHome } from "../../apis/home";
import { IBookHomeObject, IBookHomeParams } from "../../model/BookData";
import { BusinessError } from "@kit.BasicServicesKit";
import { bookDialog } from "./bookDialog";

/**
 * 房间详情页面下面的导航栏 收藏 咨询 预约看房
 */
@Component
export struct TabBar {
  @Prop @Watch('onroomidChange') roomid:string
  @State isLike:boolean=PreferencesUtil.hasSync(this.roomid)
  @State bookHomeParams:IBookHomeParams={} as IBookHomeParams
  @State bookHomeObject:IBookHomeObject={} as IBookHomeObject
  aboutToAppear(): void {
    this.bookHomeParams={
      "name": '黄令群',
      "date": '2024-11-28',
      "houseId": this.roomid,
      "phone": '15322442034',
      "comment": '测试死数据'
    }
  }
  onroomidChange(){
      this.bookHomeParams={
        "name": '黄令群',
        "date": '2024-11-28',
        "houseId": this.roomid,
        "phone": '15322442034',
        "comment": '测试死数据'
      }
  }

  bookController: CustomDialogController = new CustomDialogController({
    builder: bookDialog({
      confirm:(params:IBookHomeParams)=>{
        params.houseId=this.roomid;
        PostBookHome(this.bookHomeParams)
          .then(()=>{
            // this.bookHomeObject=data
            //  console.info(`测试输出 bookHomeObject = ${JSON.stringify(this.bookHomeParams)}`)
            ToastUtil.showToast('预约成功')
          })
          .catch((err:BusinessError)=>{
            // console.info(`测试输出 bookHomeObject = ${JSON.stringify(this.bookHomeParams)} ${JSON.stringify(this.roomid)}`)
            ToastUtil.showToast('预约失败'+err.code)
          })
      }
    }),
    alignment: DialogAlignment.Bottom,
    autoCancel: true,
    customStyle: true,
    isModal: true,
    maskColor: 'rgba(0,0,0,0.7)',
  })


  build() {
    Row(){
      /**
       * 收藏
       */
      Column(){
        Image(this.isLike?$r("app.media.lis_like"):$r("app.media.no_like")).width(rvp(18))
          .onClick(()=>{
            if(this.isLike){
              PreferencesUtil.deleteSync(this.roomid,"Like")
              this.isLike=false;
              ToastUtil.showToast('取消收藏')
            }
            else{
              PreferencesUtil.putSync(this.roomid,true,"Like");
              this.isLike=true;
              ToastUtil.showToast('收藏成功');
            }
          })
        Text('收藏').fontSize(rvp(10)).fontWeight(500).fontColor('#999999')
      }.margin({right:rvp(27)})

      Column(){
        Image($r('app.media.question')).width(rvp(18))
        Text('咨询').fontSize(rvp(10)).fontWeight(500).fontColor('#999999')
      }.margin({right:rvp(21)})

      Button(){
        Text('立即预定').fontSize(rvp(14)).fontWeight(500).fontColor('#FFFFFF')
      }.width(rvp(113)).height(rvp(34)).type(ButtonType.Normal).backgroundColor('#24A17B')
      .margin({right:rvp(21)})
      .onClick(()=>{
        if(!AppStorage.get("token")){
          ToastUtil.showToast('还未登录')
        }
        else{
          this.bookController?.open()
        }
      })

      Button(){
        Text('去看房').fontSize(rvp(14)).fontWeight(500).fontColor('#FFFFFF')
      }.width(rvp(113)).height(rvp(34)).type(ButtonType.Normal).backgroundColor('#36D1A1')

    }.width(rvp(360)).height(rvp(50))
    .padding({left:rvp(20),right:rvp(16)}).margin({top:rvp(32)})
  }
}