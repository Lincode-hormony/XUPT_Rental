/**
 * 首页数据类型
 */
export interface IHomeData{
  bannerList: IBannerList,
  navList: INavList,
  tileList: ITileList,
  planList: IPlanList,
  adPicture: string
}

export interface IBannerItem{
  id: number
  name: string,
  imageURL: string
}
export type IBannerList=IBannerItem[]
export interface INavItem{
  id: number,
  title: string,
  imageURL: string
}
export type INavList=INavItem[]
export interface ITileItem{
  id: number,
  imageURL: string,
  title: string,
  sub_title: string
}
export type ITileList=ITileItem[]

export interface IPlanItem{
  id: number,
  imageURL: string
}
export type IPlanList=IPlanItem[]
/**
 * 房源推荐
 */
export type  IRoomRecommendList=IRoomRecommendItem[]
export interface  IRoomRecommendItem{
  "id": string,
  "housePicture": string,
  "tags": ITagList
  "houseTitle": string,
  "address": string,
  "rentPriceUnit": string,
  "rentPriceListing": string,
  "rentArea": string
}
export interface  ITagItem{
  "name": string
}
export type  ITagList=ITagItem[]

