

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:ownervet/screens/dashboard/binding/dashbaord_detail_binding.dart';
import 'package:ownervet/screens/dashboard/controller/dashboard_detail_controller.dart';

class CalendarShow extends GetView<DashBoardDetailBinding>{
  @override
  Widget build(BuildContext context) {
    return   GetBuilder<DashBoardDetailController>(
        init:
        Get.put<DashBoardDetailController>(DashBoardDetailController()),
    builder: (controller) {
    //controller.onInit();
    return Container(

        margin: EdgeInsets.only(left: 16,right: 16,bottom: 10),
        child: CalendarCarousel<Event>(
          todayBorderColor: Colors.green,
          onDayPressed: (date, events) {
            controller.changeDate(date);
            controller.getSlotCallApi();
          },

          daysHaveCircularBorder: true,
          showOnlyCurrentMonthDate: false,
          weekendTextStyle: TextStyle(
            color: Colors.red,
          ),
          thisMonthDayBorderColor: Colors.grey,
          weekFormat: false,
//      firstDayOfWeek: 4,

          selectedDateTime: controller.currentDate2,
          targetDateTime: controller.targetDateTime,
          customGridViewPhysics: NeverScrollableScrollPhysics(),
          markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.green)),
          markedDateCustomTextStyle: TextStyle(
            fontSize: 18,
            color: Colors.blue,
          ),
          showHeader: true,
          todayTextStyle: TextStyle(
            color: Colors.blue,
          ),
          // markedDateShowIcon: true,
          // markedDateIconMaxShown: 2,
          // markedDateIconBuilder: (event) {
          //   return event.icon;
          // },
          // markedDateMoreShowTotal:
          //     true,
          todayButtonColor: Colors.yellow,
          selectedDayTextStyle: TextStyle(
            color: Colors.yellow,
          ),
          minSelectedDate: controller.currentDate.subtract(Duration(days: 360)),
          maxSelectedDate: controller.currentDate.add(Duration(days: 360)),
          prevDaysTextStyle: TextStyle(
            fontSize: 16,
            color: Colors.pinkAccent,
          ),
          inactiveDaysTextStyle: TextStyle(
            color: Colors.tealAccent,
            fontSize: 16,
          ),
          onCalendarChanged: (DateTime date) {

          },
          onDayLongPressed: (DateTime date) {
            print('long pressed date $date');
          },
        ),
      );

  });

}
}