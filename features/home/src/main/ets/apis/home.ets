import {http} from 'network'
import {IHomeData,IRoomRecommendList} from '../model/HomeData'
import {IRoomData} from '../model/Room'

export const GetHomeDataApi=():Promise<IHomeData> =>{
    return http.get<IHomeData>('/home/info')
}
export const GetRoomRecommendApi=():Promise<IRoomRecommendList> =>{
    return http.get<IRoomRecommendList>('/house/nearbyHouses')
}
export const GetRoomDetailApi=(id:string):Promise<IRoomData> =>{
    return http.get<IRoomData>('/house/detail', {id : id})
}
