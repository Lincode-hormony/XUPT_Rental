import { abilityAccessCtrl, bundleManager, common, UIAbility } from '@kit.AbilityKit';
import { ToastUtil } from '@pura/harmony-utils';
import { BusinessError } from '@kit.BasicServicesKit';
import { myPermissionManger } from '../../manger/MyPermissionMange';

@Entry
@Component
struct PermissionPage {
  @State message: string = 'Hello World';

  build() {
    Navigation() {
      Column({space:20}){
        Button('测试权限是否授权')
          .onClick(()=>{
            // 程序访问控制管理器
            const atManager = abilityAccessCtrl.createAtManager()
            // 获取 bundle 应用信息
            const bundleInfo = bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION)
            // 提取 tokenID 标识（应用唯一标识）
            const tokenID :number= bundleInfo.appInfo.accessTokenId
            // 核心 API：checkAccessTokenSync，检查是否授予权限
            const grantStatus = atManager.checkAccessTokenSync(tokenID, 'ohos.permission.READ_CALENDAR')
            // every 检查每项结果是否都已授权
            // ToastUtil.showToast(''+grantStatus)
            AlertDialog.show({message:''+grantStatus})
          })

        Button('动态申请授权')
          .onClick(async ()=>{
            const atManger=abilityAccessCtrl.createAtManager();
            const permissionRequestResult=await atManger.requestPermissionsFromUser(getContext(),['ohos.permission.READ_CALENDAR']);
            AlertDialog.show({message:JSON.stringify(permissionRequestResult,null,2)})
          })

        Button('打开设置页面')
          .onClick(()=>{
            //使用断言缩小context的范围，否者后续的context只能使用通用的方法，使用不了startAbility方法
            const context=getContext() as common.UIAbilityContext
            //获取包信息
            const bundleInfo=bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION)
            //核心API
            // console.debug('appid:'+JSON.stringify(bundleInfo.signatureInfo.appId,null,2))
            context.startAbility({
              //固定写法
              bundleName:"com.huawei.hmos.settings",
              abilityName:"com.huawei.hmos.settings.MainAbility",
              uri:"application_info_entry",
              parameters:{
                //按照包名打开设置页面
                pushParams:bundleInfo.name
              }
            })

          })

        Button('打开设置页面2 二次授权')
          .onClick(async ()=> {
            let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
            let context: Context = getContext() as common.UIAbilityContext;
            // const GrantStatus=await atManager.requestPermissionOnSetting(context, ['ohos.permission.READ_CALENDAR'])
            atManager.requestPermissionOnSetting(context, ['ohos.permission.READ_CALENDAR'])
              .then((GrantStatus)=>{
                AlertDialog.show({message:JSON.stringify(GrantStatus,null,2)})
              })
              .catch((err:BusinessError)=>{
                AlertDialog.show({message:JSON.stringify(err,null,2)})
              })
          }).margin({bottom:30})

        Button('调用 打开设置页面')
          .onClick(()=>{
            myPermissionManger.openSettingPage()
          })

        Button('调用 动态授权')
          .onClick(async ()=>{
            const isAuth=await myPermissionManger.requestPermissions(['ohos.permission.WRITE_IMAGEVIDEO',"ohos.permission.READ_IMAGEVIDEO"])
            ToastUtil.showToast('已授权成功')
          })

        Button('调用 检验是否授权')
          .onClick(()=>{
            const isSucess=myPermissionManger.checkGrant(['ohos.permission.WRITE_CALENDAR'])
            ToastUtil.showToast("检验结果: "+isSucess)
          })
        Button('AppId')
          .onClick(()=>{
            let flag = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_SIGNATURE_INFO;
            let bundleInfo = bundleManager.getBundleInfoForSelfSync(flag)
            let appId = bundleInfo.signatureInfo.appId;
            // console.info(JSON.stringify(appId))
          })
      }
    }
    .title('权限管理')
    .height('100%')
    .width('100%')
  }
}