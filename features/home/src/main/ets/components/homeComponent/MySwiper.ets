import { IBannerItem, IBannerList } from '../../model/HomeData'
@Component
export struct MySwiper{
  @Link bannerList:IBannerList
  build() {
      Stack(){
        Swiper(){
          ForEach(this.bannerList,(Item:IBannerItem,index:number)=>{
            Image(Item.imageURL).width('100%')
              // .onAppear(()=>{
              //   console.info(index.toString()+" 重新加载")
              // })
          },(Item:IBannerItem)=>Item.id.toString())
        }.autoPlay(true).loop(true).width('100%')
      }.width('100%')
  }
}