import {IProvinceList,ICityList,IDistrictList,IProvinceItem,ICityItem,IDistrictItem,
  ISearchParams} from '../../model/RoomList'
import {GetProvinceApi,GetCityApi,GetDistrictApi} from '../../apis/home'

@Component
export struct locationTender{
  @Consume searchParams: ISearchParams
  @State provinceList:IProvinceList=[]
  @State cityList:ICityList=[]
  @State districtList:IDistrictList=[]
  @State provinceCode: string = '' // 省code
  @State cityCode: string = '' // 市code
  @State districtCode: string = '' // 区code

  aboutToAppear():void{
    this.GetProvinceList()
  }
  async GetProvinceList(){
    const data=await GetProvinceApi()
    this.provinceList=data
    this.provinceCode=data[0].code
    // this.GetCityList()
  }
  async GetCityList(){
    const data=await GetCityApi(this.provinceCode)
    this.cityList=data
    this.cityCode=data[0].code
    // this.GetDistrictList()
  }
  async GetDistrictList(){
    const data=await GetDistrictApi(this.cityCode)
    this.districtList=data
    this.districtCode=data[0].code
  }

  build() {
    Column(){
      Row(){
        List(){
          ForEach(this.provinceList,(item:IProvinceItem)=>{
            ListItem(){
              Text(item.name).fontSize(12).fontWeight(500)
                .fontColor(item.code===this.provinceCode?'#009B71':'#000000')
                .onClick(()=>{
                  this.provinceCode=item.code
                  this.GetCityList()
                    .then(()=>{
                      this.GetDistrictList()
                    })
                })
            }.width(120).height(30).padding({top:6,bottom:6,left:16,right:16})
            .align(Alignment.Start)
          })
        }.width(120).height(240).backgroundColor(Color.White).scrollBar(BarState.Off)

        List(){
          ForEach(this.cityList,(item:ICityItem)=>{
            ListItem(){
              Text(item.name).fontSize(12).fontWeight(500)
                .fontColor(item.code===this.cityCode?'#009B71':'#000000')
                .onClick(()=>{
                  this.cityCode=item.code
                })
            }.width(120).height(30).padding({top:6,bottom:6,left:16,right:16})
            .align(Alignment.Start)
          })
        }.width(120).height(240).backgroundColor('#eeeeee').scrollBar(BarState.Off)

        List(){
          ForEach(this.districtList,(item:IDistrictItem)=>{
            ListItem(){
              Text(item.name).fontSize(12).fontWeight(500)
                .fontColor(item.code===this.districtCode?'#009B71':'#000000')
                .onClick(()=>{
                  this.districtCode=item.code
                })
            }.width(120).height(30).padding({top:6,bottom:6,left:16,right:16})
            .align(Alignment.Start)
          })
        }.width(120).height(240).backgroundColor('#dddddd').scrollBar(BarState.Off)
      }
      Row(){
        Button('重置')
          .type(ButtonType.Normal).backgroundColor('#dddddd')
          .width(95)
          .onClick(()=>{
            this.provinceCode='' // 省code
            this.cityCode= '' // 市code
            this.districtCode= '' // 区code
            this.cityList=[]
            this.districtList=[]
          })
        Button('查看房源')
          .type(ButtonType.Normal).backgroundColor('#009B71')
          .width(211)
          .onClick(()=>{
            this.searchParams = {
              page: 1,
              limit: 10,
              cityCode: this.cityCode,
              districtCode: this.districtCode,
              provinceCode: this.provinceCode
            }
          })
      }
      .backgroundColor(Color.White)
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }
  }
}