import { BuilderNameConstants } from 'router/src/main/ets/constants/RouterConstants'

export { Home } from './src/main/ets/views/Home'
export {IRoomData,ISupportLIst,IHousePictureList,IHousePictureItem, IMetaInfoList, IRentTerm,
  IHouseholdItemList,
  IRentInfoList,
  IHouseholdItemItem} from './src/main/ets/model/Room'
export {GetRoomDetailApi} from './src/main/ets/apis/home'

export function harInit(builderName:string){
  switch (builderName){
    case BuilderNameConstants.HOME:
      import('./src/main/ets/views/Home')
      break
    case BuilderNameConstants.ROOM_LIST:
      import('./src/main/ets/views/RoomList')
      break
    case BuilderNameConstants.ROOM_PAGE:
      import('./src/main/ets/views/RoomPage')
      break
    default :
      break
  }
}