import {RouterModel} from '../model/RouterModel'
import { Callback } from '@kit.BasicServicesKit'


export class RouterUtil{
  //通过键值对的形式存储路由页面--路由表
  //可以通过页面名称找到对应模块页面builder
  static builderMap:Map<string,WrappedBuilder<[object]>>=new Map<string,WrappedBuilder<[object]>>()
  //通过键值对形式存储路由栈--路由栈表
  //可以通过栈的名称找到对应路由栈
  static routerMap:Map<string,NavPathStack>=new Map<string,NavPathStack>()


  //注册路由页面，把路由页面名称和Builder传入路由表
  public static registerBuilder(builderName:string,builder:WrappedBuilder<[object]>){
    RouterUtil.builderMap.set(builderName,builder)
  }

  //注册路由栈到路由栈表
  public static registerRouter(routerName:string,router:NavPathStack){
    RouterUtil.routerMap.set(routerName,router)
    console.log('登录：注册了登录路由栈')
  }

  //获取路由页面
  public static getBuilder(builderName:string){
    const builder=RouterUtil.builderMap.get(builderName)
    if(!builder){
      console.log('没有找到页面：'+builderName)
    }
    return builder as WrappedBuilder<[object]>
  }

  //获取对应路由栈
  public static getRouter(routerName:string){
    return RouterUtil.routerMap.get(routerName)
  }

  //剩下的根据自己的需求去操作
  //以下是push页面和Pop的示例

  //routerModel是自定义的
  //给出操作的页面栈，要跳转的页面名称，就可以完成在该页面栈加入目标页面的操作
  /**
   * 黄令群
   * @param routerName
   * @param builderName
   * @param param 加上了string类，因为在跳转到房间详情页面的时候需要传参string的roomid
   * @param onPop
   */
  public static push(routerName:string,builderName:string,param?:object|string,onPop?:Callback<PopInfo>){
    let router:RouterModel=new RouterModel()
    router.routerName=routerName
    router.builderName=builderName
    router.param=param as object
    router.onPop=onPop
    console.log('登录：路由栈信息查询：'+JSON.stringify(router))
    RouterUtil.push_util(router)
  }

  public static async push_util(router:RouterModel){
    //获取需要跳转的路由页面所在的包
    const harName=router.builderName.split('_')[0]
    console.log('登录：要跳转的模块：'+harName)
    //动态导入页面
    //这里就是先Import要跳转页面的模块，然后再在那个模块的Index页面去找是要跳转这个模块的哪个页面
    //这个harInit是在模块入口的Index页面定义的
    await import(harName).then((ns:ESObject)=>{ns.harInit(router.builderName)})
    RouterUtil.getRouter(router.routerName)?.pushPath({name:router.builderName,param:router.param,onPop:router.onPop})
  }

  public static pop(routerName:string){
    RouterUtil.getRouter(routerName)?.pop()
  }


}