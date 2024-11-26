import { MapComponent, mapCommon, map } from '@kit.MapKit';
import { AsyncCallback } from '@kit.BasicServicesKit';
@Entry
@Component
struct Index{
  private mapOption?: mapCommon.MapOptions; //地图配置
  private callback?: AsyncCallback<map.MapComponentController>; //初始化完成回调
  private mapController?: map.MapComponentController; //地图控制器

  aboutToAppear(): void {
    // 地图初始化参数，设置地图中心点坐标及层级
    this.mapOption = {
      position: {
        target: {
          latitude: 39.9, //纬度
          longitude: 116.4  //经度
        },
        zoom: 10, //缩放层级
        //compassControlsEnabled:true,//是否显示指南针
        //zoomControlsEnabled:true,//是否展示缩放按钮
        //myLocationControlsEnabled:fasle,//是否展示我的位置按钮
        //scaleControlsEnabled:false,//是否展示比例尺
      }
    };

    // 地图初始化的回调
    this.callback = async (err, mapController) => {
      if (!err) {
        // 获取地图的控制器类，用来操作地图
        this.mapController = mapController;
      }
    };
  }

  build() {
    Stack() {
      // 调用MapComponent组件初始化地图
      MapComponent({ mapOptions: this.mapOption, mapCallback: this.callback }).width('100%').height('100%');
    }.height('100%')
  }
}
