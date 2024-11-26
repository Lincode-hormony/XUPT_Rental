import { permissionManager } from '../../manger/PermissionManger';
import { geoLocationManager } from '@kit.LocationKit';
import { JSON } from '@kit.ArkTS';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct LocationKitTestPage {
  @State isGrant: boolean = false;
  @State location:geoLocationManager.Location|null=null
  aboutToAppear(): void {
    console.info("定位中")
    this.requestPermission();
  }
  async requestPermission(){

    this.isGrant=await permissionManager.requestPermissions([
      "ohos.permission.LOCATION",
      "ohos.permission.APPROXIMATELY_LOCATION"
    ])
  }
  build() {
    Column({space:20}) {
      Text("定位功能："+this.isGrant)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
      /**
       * 获取当前信息
       */
      Button('获取当前信息')
        .onClick(async ()=>{
          const location=await geoLocationManager.getCurrentLocation();
          this.location=location
        })
      /**
       * 开启位置变化订阅
       */
      Button('开启位置变化订阅')
        .onClick(()=>{
          geoLocationManager.on("locationChange",{},(location)=>{
            this.location=location
          })
        })
      /**
       * 关闭位置变化订阅
       */
      Button('关闭位置变化订阅')
        .onClick(()=>{
          geoLocationManager.off("locationChange")
        })
      Button('检测是否能用')
        .onClick(()=>{
          const isfg=geoLocationManager.isGeocoderAvailable();
          AlertDialog.show({message:''+isfg})
        })
      Button('逆地理')
        .onClick(async ()=>{
          const location=await geoLocationManager.getCurrentLocation()

          const address=await geoLocationManager.getAddressesFromLocation({
            locale:'zh',
            latitude:location.latitude,
            longitude:location.longitude,
            maxItems:3
          })

          AlertDialog.show({message:JSON.stringify(address,null,2)})
        })
      Text(JSON.stringify(this.location,null,2))
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
    }
    .height('100%')
    .width('100%')
  }
}