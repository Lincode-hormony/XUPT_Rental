import {http} from 'network'
import { userModel } from '../model/UserModel'

export interface userID{
  token:string
}

export interface Response {
  code: number;
  data: Data;
  message: string;
}

export interface Data {
  avatar: string;
  id: number;
  nickname: string;
}

export const sendSMSCodeApi=(phone:string):Promise<null>=>{
  return http.post('/sendSMSCode',{phone})
}

export const loginApi=(phone:string,code:string):Promise<userID>=>{
  return http.post<userID>('/login',{phone,code})
}

export const getUserApi=(token:string):Promise<userModel>=>{
  return http.get<userModel>('/auth/user/userInfo')
}
