import { ToastUtil,PreferencesUtil} from "@pura/harmony-utils";
import { rvp } from "uicomponent";
import { PostBookHome } from "../../apis/home";
import {  IBookHomeParams } from "../../model/BookData";
import { bookDialog } from "./bookDialog";
//验证电话号码是否合法
function isPhoneNumber(phoneNumber: string): boolean {
  const regExp = /^1[3-9]\d{9}$/;
  return regExp.test(phoneNumber);
}

/**
 * 房间详情页面下面的导航栏 收藏 咨询 预约看房
 */
@Component
export struct TabBar {
  @Prop roomid:string
  @State isLike:boolean=PreferencesUtil.hasSync(this.roomid)

  // 预约看房
  async book(param:IBookHomeParams) {
    if (!param.name) {
      ToastUtil.showToast('请输入姓名')
      return;
    }
    if (!param.phone) {
      ToastUtil.showToast('请输入手机号')
      return;
    }
    if (!isPhoneNumber(param.phone)) {
      ToastUtil.showToast('请输入合法的手机号')
      return;
    }
    try {
      await PostBookHome(param)
      ToastUtil.showToast('预约成功')
    } catch {
      ToastUtil.showToast('预约时间至少提前两天')
    }
  }
  //预约填写相关信息弹窗
  bookController: CustomDialogController = new CustomDialogController({
    builder: bookDialog({
      confirm:(params:IBookHomeParams)=>{
        params.houseId=this.roomid;
        // console.log('test: '+JSON.stringify(params))
        this.book(params)
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