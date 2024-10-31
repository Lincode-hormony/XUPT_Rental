import { IBannerItem, IBannerList } from '../../model/HomeData'
@Component
export struct MySwiper{
  @Link bannerList:IBannerList
  build() {
      Stack(){
        Swiper(){
          ForEach(this.bannerList,(Item:IBannerItem)=>{
            Image(Item.imageURL).width('100%')
          },(Item:IBannerItem)=>Item.id.toString())
        }.autoPlay(true).loop(true)
      }
  }
}