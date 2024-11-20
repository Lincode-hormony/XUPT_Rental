import { abilityAccessCtrl, bundleManager, common, PermissionRequestResult, Permissions } from "@kit.AbilityKit"

class MyPermissionManger{
  /**
   * 检测是否授权
   * @param permissionList 权限列表
   * @returns
   */
  checkGrant(permissionList:Permissions[]){
    // 程序访问控制管理器
    const atManager = abilityAccessCtrl.createAtManager()
    // 获取 bundle 应用信息
    const bundleInfo = bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION)
    // 提取 tokenID 标识（应用唯一标识）
    const tokenID :number= bundleInfo.appInfo.accessTokenId
    // 核心 API：checkAccessTokenSync，检查是否授予权限
    const grantStatus = permissionList.map(item => atManager.checkAccessTokenSync(tokenID, item));

    return grantStatus.every(item=>item===abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED)
  }

  /**
   * 动态申请授权
   * @param permissionList 权限列表
   * @returns 返回授权结果，授权成功为 Promise.resolve(), 拒绝授权为 Promise.reject()
   */
  async requestPermissions(permissionList:Permissions[]):Promise<void>{//有await 返回的就是Promise
    //创建应用权限管理器
    const atManger=abilityAccessCtrl.createAtManager();

    const permissionRequestResult=await atManger.requestPermissionsFromUser(getContext(),permissionList);
    //every 判断权限是否都被授权成功
    const isAuth=permissionRequestResult.authResults.every(item=> item===abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED)
    // Promise.reject()   返回Promise失败,让await后续的代码不执行,Promise.reject() 的结果可被 catch 捕获
    // Promise.resolve()  返回 Promise 成功，await 后续代码，正常执行
    return isAuth ? Promise.resolve() : Promise.reject();
  }

  /**
   * 打开系统设置的权限管理页（处理授权结果）
   */
  openSettingPage(){
    //使用断言缩小context的范围，否者后续的context只能使用通用的方法，使用不了startAbility方法
    const context=getContext() as common.UIAbilityContext
    //获取包信息
    const bundleInfo=bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION)
    //核心API
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
  }

}

export const myPermissionManger=new MyPermissionManger()