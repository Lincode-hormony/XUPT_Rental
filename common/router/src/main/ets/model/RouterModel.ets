export class RouterModel{
  //需要操作的页面栈
  routerName:string=''
  //需要跳转的页面 页面规范为：模块名_页面名称 如：跳转mine模块的login页面 命名为mine_login
  builderName:string=''
  //传递数据
  param?:object=new Object
  //弹出回调
  onPop?:Callback<PopInfo>=()=>{}
}

