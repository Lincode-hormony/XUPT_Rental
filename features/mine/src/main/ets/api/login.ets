import {http} from 'network'

export interface userID{
  token:string
}

export const sendSMSCodeApi=(phone:string):Promise<null>=>{
  return http.post('/sendSMSCode',{phone})
}

export const loginApi=(phone:string,code:string):Promise<userID>=>{
  return http.post<userID>('/login',{phone,code})
}
