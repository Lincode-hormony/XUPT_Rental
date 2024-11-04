import {http} from 'network'
import { IBookHomeObject, IBookHomeParams } from '../model/BookData'
import {IHomeData,IRoomRecommendList} from '../model/HomeData'
import {IRoomData} from '../model/Room'
import {ISearchData,ISearchParams,IProvinceList,ICityList,IDistrictList,
GetCityListParams,GetDistrictListParams} from '../model/RoomList'

export const GetHomeDataApi=():Promise<IHomeData> =>{
    return http.get<IHomeData>('/home/info')
}
export const GetRoomRecommendApi=():Promise<IRoomRecommendList> =>{
    return http.get<IRoomRecommendList>('/house/nearbyHouses')
}
export const GetRoomDetailApi=(id:string):Promise<IRoomData> =>{
    return http.get<IRoomData>('/house/detail', {id : id})
}
/**
 * 获取搜索房间列表数据（使用搜索API）
 */
export const GetRoomListApi=(params:ISearchParams):Promise<ISearchData> =>{
    return http.get<ISearchData>('/house/search', params)
}
/**
 * 获取省市区
 */
export const GetProvinceApi=():Promise<IProvinceList>=>{
    return http.get<IProvinceList>('/province')
}
export const GetCityApi=(provinceCode:string):Promise<ICityList>=>{
    const params: GetCityListParams = { provinceCode }
    return http.get<ICityList>('/city',params)
}
export const GetDistrictApi=(cityCode:string):Promise<IDistrictList>=>{
    const params: GetDistrictListParams = {cityCode }
    return http.get<IDistrictList>('/area',params)
}

/**
 * 预约租房
 */
export const PostBookHome=(BookHomeParams:IBookHomeParams):Promise<void> =>{
    return http.post<void>('/auth/house/reservation',BookHomeParams)
}

