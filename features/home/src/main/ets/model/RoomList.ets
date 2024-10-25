/**
 * 更多推荐 房屋列表数据类型
 */
import {IRoomRecommendList} from './HomeData'
export interface  IRoomList{
  "records": IRoomRecommendList,
  "total": string
}
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