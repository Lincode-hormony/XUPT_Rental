import { permissionManager } from '../../manger';
import { calendarManager } from '@kit.CalendarKit';
import { BusinessError } from '@kit.BasicServicesKit';
import json from '@ohos.util.json';

@Entry
@Component
struct CalendarKitTestPage {
  @State title: string = '日历';

  private calendarMgr:calendarManager.CalendarManager|null=null

  aboutToAppear(): void {
    this.getCalendarPermission();
  }

  /**
   * 申请权限同时获取日历账户管理器
   */
  async getCalendarPermission(){
    if(!permissionManager.checkPermissions(['ohos.permission.READ_CALENDAR','ohos.permission.WRITE_CALENDAR'])){
      await permissionManager.requestPermissions(['ohos.permission.READ_CALENDAR','ohos.permission.WRITE_CALENDAR'])
    }
    // 获取日历管理器实例
    this.calendarMgr=calendarManager.getCalendarManager(getContext())
    // AlertDialog.show({message:"res: "+canIUse('SystemCapability.Applications.CalendarData')})
  }

  build() {
    Scroll() {
      Column({space:10}) {
        Button('获取默认日历账户').onClick(async () => {
          // 获取默认日历账户对象
          const calenda = await this.calendarMgr?.getCalendar()
          AlertDialog.show({ message: JSON.stringify(calenda, null, 2) })
        })

        Button('获取全部日历账户').onClick(async () => {
          // 获取全部日历账户对象
          const calendaList = await this.calendarMgr?.getAllCalendars()

          let allAcount: string = '';
          calendaList?.forEach((account, index: Number) => {
            allAcount += JSON.stringify(account.getAccount(), null, 2)
          })
          AlertDialog.show({ message: allAcount })
        })

        Button('创建日历账户').onClick(async () => {
          const calendarAccount: calendarManager.CalendarAccount = {
            name: 'HLQ',
            type: calendarManager.CalendarType.LOCAL,
            displayName: 'MyCalendar HLQ'
          }
          /**
           * 创建日历账户之前，开发者需要先根据账户信息进行查询，如果账户不存在则抛出异常信息，
           * 捕获到异常再进行日历账户的创建，否则可能会出现账户重复创建的问题。
           */
          this.calendarMgr?.getCalendar(calendarAccount)
            .then(() => {
              AlertDialog.show({ message: '该账户已存在' })
            })
            .catch(async () => {
              //创建账户对象
              const calenda = await this.calendarMgr?.createCalendar(calendarAccount)
              AlertDialog.show({ message: JSON.stringify(calenda, null, 2) })
            })
        })

        Button('删除').onClick(async () => {
          // 获取默认日历账户对象
          const calendaList = await this.calendarMgr?.getAllCalendars()
          calendaList?.forEach((account, index: number) => {
            console.info('用户数据' + index.toString() + '  ' + JSON.stringify(account.getAccount(), null, 2))
          })
        })

        Button('获取默认日历账户配置信息').onClick(async ()=>{
          const calenda = await this.calendarMgr?.getCalendar()
          const calendarConfig=calenda?.getConfig()
          AlertDialog.show({message:JSON.stringify(calendarConfig,null,2)})
        })

        Button('设置默认日历账户配置信息').onClick(async ()=>{
          const calenda = await this.calendarMgr?.getCalendar()
          calenda?.setConfig({
            enableReminder:true,
            color:"#aabbcc"
          })
        })

        Button('添加日程').onClick(async ()=>{
          const calendar = await this.calendarMgr?.getCalendar()
          const date = new Date();
          const event: calendarManager.Event = {
            // 日程标题
            title: 'title',
            // 日程类型
            type: calendarManager.EventType.NORMAL,
            // 日程开始时间
            startTime: date.getTime()+1000*30,
            // 日程结束时间
            endTime: date.getTime() + 60 * 60 * 1000
          }
          let eventId : number | undefined = undefined;
          // 方式一
          calendar?.addEvent(event).then((data: number) => {
            console.info(`Succeeded in adding event, id -> ${data}`);
            eventId = data;
            AlertDialog.show({message:json.stringify(eventId,null,2)})
          }).catch((err: BusinessError) => {
            console.error(`Failed to addEvent. Code: ${err.code}, message: ${err.message}`);
          });
          // 方式二

        })

        Button('日程的更新')

        Button('查询当前日历账户下的所有日程').onClick(async ()=>{
          const calenda = await this.calendarMgr?.getCalendar()
          const events=await calenda?.getEvents()
          AlertDialog.show({message:JSON.stringify(events,null,2)})
        })
        //还支持根据日程id、日程开始和结束时间、日程标题等查询条件来查询日程。

        Button('删除指定日程id的日程')

        // TextPicker({range:["上海","南京","西安","北京"]})

        CalendarPicker();

      }.height('100%')
    }
    .height('100%')
    .width('100%')
  }
}