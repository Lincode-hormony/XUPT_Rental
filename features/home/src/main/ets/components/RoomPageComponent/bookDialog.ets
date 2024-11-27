import { rvp } from "uicomponent";
import { IBookHomeObject, IBookHomeParams } from "../../model/BookData";
@Component
@CustomDialog
export struct bookDialog {
  controller?: CustomDialogController
  confirm:(params:IBookHomeParams)=>void=()=>{}
  @State name: string = ''
  @State phone: string = ''
  @State date: string = ''
  @State remark: string = ''
  build() {
    Column({ space: rvp(16) }) {
      Text('预约信息')
        .fontSize(18)
        .fontWeight(700)
      Column({ space: rvp(20) }) {

        Row({ space: rvp(18) }) {
          Text('姓名').width(rvp(56)).fontSize(14)
          Row(){
            TextInput({ placeholder: '请输入姓名' })
              .onChange((value: string) => {
                this.name = value;
              })
          }.layoutWeight(1)
        }.width('100%')

        Row({ space: rvp(18) }) {
          Text('手机号').width(rvp(56)).fontSize(14)
          Row(){
            TextInput({ placeholder: '请输入手机号' }).type(InputType.PhoneNumber).maxLength(11)
              .onChange((value: string) => {
                this.phone = value;
              })
          }.layoutWeight(1)
        }.width('100%')

        Row({ space: rvp(18) }) {
          Text('预约日期').width(rvp(56)).fontSize(14)
          Row() {
            TextInput({ placeholder: '请选择预约日期', text: $$this.date })
              .enabled(false)
          }.layoutWeight(1)
          .justifyContent(FlexAlign.SpaceBetween)
          .onClick(() => {
            DatePickerDialog.show({
              start: new Date(),
              alignment: DialogAlignment.Bottom,
              end: new Date(new Date().getTime() + 1000 * 60 * 60 * 24 * 32),
              onAccept: (value: DatePickerResult) => {
                this.date = `${value.year}-${addZero(value.month!+1)}-${addZero(value.day)}`
              },
            })
          })
        }.width('100%')

        Row({ space: rvp(18) }) {
          Text('备注信息').width(rvp(56)).fontSize(14)
          Row() {
            TextArea({ placeholder: '请输入备注信息' })
              .onChange((value: string) => {
                this.remark = value;
              })
          }.layoutWeight(1)
        }.width('100%')
        .alignItems(VerticalAlign.Top)
      }
      .width('100%')
      .backgroundColor(Color.White)
      .padding(16)
      .borderRadius(4)

      Button('预约看房', { type: ButtonType.Normal })
        .onClick(() => {
          if (this.name && this.phone && this.date) {
            let param: IBookHomeParams = {} as IBookHomeParams
            param.name = this.name
            param.phone = this.phone
            param.date = this.date
            param.comment = this.remark
            console.log(JSON.stringify(param))
            this.confirm(param)
            this.controller?.close()
          } else {
            AlertDialog.show({
              message: '请输入信息！'
            });
          }
        })
        .backgroundColor('#24A17B')
        .fontColor(Color.White)
        .borderRadius(2)
        .height(43)
        .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .borderRadius({ topLeft: 20, topRight: 20 })
    .backgroundColor('#ffececec')
    .padding({
      top: 16,
      left: 16,
      right: 16,
      bottom: 16
    })
  }
}


function addZero(x: number): string {
  console.info('x = '+x.toString())
  if (x < 10) {
    return `0${x}`
  } else {
    return x + ''
  }
}
