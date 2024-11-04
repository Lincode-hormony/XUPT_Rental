
// import { ITagList } from "home"
export interface  ITagItem{
  "name": string
}
export type  ITagList=ITagItem[]
/**
 * 预约记录
 */
export interface IBookHistoryItem{
  "id": string,
  "date": string,
  "houseId": string,
  "img": string,
  "title": string,
  "subTitle": string,
  "distanceInfo": null,
  "rentPrice": string,
  "tags": ITagList
  "comment": string
}
export type IBookHistoryList=IBookHistoryItem[]
