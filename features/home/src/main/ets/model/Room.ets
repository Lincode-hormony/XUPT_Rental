/**
 * 房间详情数据类型
 */
import {ITagList} from './HomeData'
import { ExtraRegionPosition } from '@kit.ArkUI'

export interface  IRoomData{
  "houseTitle": string,
  "address": string,
  "rentPriceUnit": string,
  "housePicture": IHousePictureList,
  "tags": ITagList,
  "rentPriceUnitListing": string,
  "distanceInfo": null,
  "rentTerm": IRentTerm,
  "metaInfo": IMetaInfoList,
  "id": string,
  "rentArea": string,
  "discounts": IDiscountsList,
  "householdItem": IHouseholdItemList,
  "support": ISupportLIst,
  "rentInfo": IRentInfoList
}
export type IRentInfoList=IRentInfo[]
export interface IRentInfo{
  "image": string,
  "title": string,
  "userTag": string
}
export type ISupportLIst=ISupportItem[]//服务与保障
export interface  ISupportItem{
  "image": string,
  "title": string,
  "subTitle": string
}
export type IHouseholdItemList=IHouseholdItemItem[]
export interface IHouseholdItemItem {
  "name": string,
  "itemList": IItemList
}
export interface IHousePictureItem{
  "spaceName": string,
  "picList": string[];
}
export type IHousePictureList=IHousePictureItem[]

export interface IRentTerm{
  "checkInTime": string,
  "term": string,
  "kitchen": string,
  "lift": string,
  "seeTime": string,
  "year": string,
  "renovation": string,
  "grounding": string,
  "heating": string,
  "green": string,
  "protection": string,
  "house": string
}
export interface IMetaInfoItem {
  "name": string,
  "desc": string
}
export type IMetaInfoList=IMetaInfoItem[]
export interface IDiscountsItem{
  "tagTxtBgAroundColor": string,
  "image": string,
  "txt": string,
  "tagTxt": string,
  "tagTxtColor": string
}
export type IDiscountsList=IDiscountsItem[]

export interface IItemItem{
  "icon": string,
  "value": string
}
export type IItemList=IItemItem[]