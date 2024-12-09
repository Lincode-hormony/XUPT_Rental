import {http} from 'network'

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

export const getUserApi=(token:string):Promise<Response>=>{
  return http.get<Response>('/auth/user/userInfo')
}
