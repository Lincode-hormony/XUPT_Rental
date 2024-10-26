/**
 * 更多推荐 房屋列表数据类型
 */

import { IRoomRecommendItem} from './HomeData'

/**
 * API搜索响应数据类型
 */
export interface IActivity{
  "title": string,
  "textColor": string
  "textBackGroundColor": string
  "#text": string
  "icon": string
}
export interface  IRoomItem extends IRoomRecommendItem{
  "activity"?: IActivity
}
export type IRoomList=IRoomItem[]
export interface ISearchData{
  "records":IRoomList
  "total":string
}
/**
 * 搜索参数
 */
export interface ISearchParams{
  page: number;
  limit: number;
  maxRent?: string;
  minRent?: string;
  cityCode?: string;
  districtCode?: string;
  orderBy?: string; //只能传递两种值 ： area | price
  orderType?: string; //排序方式 如果orderby没指定或者给错了就默认升序，如果传值为desc就降序。
  paymentType?: string;
  provinceCode?: string;
}
/**
 * 懒加载数据类型
 */
export class RoomListDataSource implements IDataSource {
  private listeners: DataChangeListener[] = [];
  private RoomList: IRoomList = [];

  public totalCount(): number {
    return this.RoomList.length;
  }

  public getData(index: number): IRoomItem {
    return this.RoomList[index];
  }
  //添加追加列表数据
  public pushList(list:IRoomList){
    list.forEach(item=>{
      this.RoomList.push(item)
      this.notifyDataAdd(this.RoomList.length-1)
    })
  }
  //整个列表替换
  public setList(list:IRoomList){
    this.RoomList=list
    this.notifyDataReload()
  }

  // 该方法为框架侧调用，为LazyForEach组件向其数据源处添加listener监听
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      console.info('add listener');
      this.listeners.push(listener);
    }
  }

  // 该方法为框架侧调用，为对应的LazyForEach组件在数据源处去除listener监听
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      console.info('remove listener');
      this.listeners.splice(pos, 1);
    }
  }

  // 通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  // 通知LazyForEach组件需要在index对应索引处添加子组件
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    })
  }

  // 通知LazyForEach组件在index对应索引处数据有变化，需要重建该子组件
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    })
  }

  // 通知LazyForEach组件需要在index对应索引处删除该子组件
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);
    })
  }

  // 通知LazyForEach组件将from索引和to索引处的子组件进行交换
  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to);
    })
  }
}
/**
 * 省市区数据类型
 */
export interface IProvinceItem {
  "code": string
  "name": string
}
export type IProvinceList=IProvinceItem[]
export interface ICityItem {
  "code": string
  "name": string
  "provinceCode": string
}
export type ICityList = ICityItem[]
//地区
export interface IDistrictItem {
  "code": string
  "name": string
  "cityCode": string
  "provinceCode": string
}
export type IDistrictList = IDistrictItem[]
//请求参数类型
export interface GetCityListParams {
  provinceCode: string
}
export interface GetDistrictListParams {
  cityCode: string
}