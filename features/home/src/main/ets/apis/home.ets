import {http} from 'network'
import {IHomeData,IRoomRecommendList} from '../model/HomeData'
import {IRoomData} from '../model/Room'
import {ISearchData,ISearchParams} from '../model/RoomList'
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
