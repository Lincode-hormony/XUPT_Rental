

/**
 * 预约看房参数
 */
export interface IBookHomeParams{
  "name": string,
  "date": string,
  "houseId": string,
  "phone": string,
  "comment": string
}
/**
 * 预约看房返回类型
 */
export interface IBookHomeObject{
  "id": number,
  "userId": number,
  "houseId": string,
  "date": string,
  "name": string,
  "comment": string
}
