/**
 * 使用ts文件 定义AnyObject类型，用于添加请求参数
 */
import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';

export interface AnyObject {
  [key: string]: any
}

const request = axios.create({
   baseURL: 'http://192.168.34.97:6060',
  //baseURL: 'http://192.168.1.185:6060',//勿删！！！
  timeout: 20000,
})

request.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    // 未来需要添加 token
    const token:string=AppStorage.get<string>("Token"); //合并修改
    // console.info(`获取的token = ${token}`)
    if(token) config.headers.token = AppStorage.get<string>("Token"); //合并修改
    return config;
  }
)

request.interceptors.response.use(
  (response: AxiosResponse) => {
    if (response.data.code === 200) {
      return response.data.data;
    } else {
      return Promise.reject(response.data.message);
    }
  },
  (error: AxiosError) => {
    return Promise.reject(error.message);
  }
)

export  class Http {
  get<T>(url: string, params?: AnyObject) {
    return request.get<null, T>(url, {
      params
    })
  }

  post<T>(url: string, data?: AnyObject) {
    return request.post<null, T>(url, data)
  }

  put<T>(url: string, data?: AnyObject) {
    return request.put<null, T>(url, data)
  }

  delete<T>(url: string, params?: AnyObject) {
    return request.delete<null, T>(url, {
      params
    })
  }
};
export const http=new Http()