import { IBookHistoryList } from "../model/BookData"
import {http} from "network"
/**
 * 查看预约记录
 */
export const getBookHistoryApi=():Promise<IBookHistoryList> =>{
  return http.get<IBookHistoryList>("/auth/house/history")
}
