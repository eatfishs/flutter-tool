/**
 * @author: jiangjunhui
 * @date: 2024/12/5
 */
import 'package:flutter/material.dart';
import 'package:flutter_module/core/utils/date_untils.dart';
import '../../../core/widgets/custom_appBar_widget.dart';



class DatePage extends StatelessWidget {

  void printDate() {
      int timeStamp = MyDateTimeUtil.getTimeStamp();
      print("打印当前时间戳:${timeStamp}");

      String currentTime = MyDateTimeUtil.getCurrentTime();
      print("打印当前时间戳字符串:${currentTime}");


      int timeStamp1 = MyDateTimeUtil.timeToTimeStamp("2024-12-05 11:43:00");
      print(" 将某个格式时间转化成时间戳:${timeStamp1}");

  }




  const DatePage({super.key});
  @override
  Widget build(BuildContext context) {

    printDate();


    return Scaffold(
          appBar: CustomAppBar(
            title: '日期',
            onBackPressed: () {
              // Handle back button press, if needed
              Navigator.pop(context);
            },
          ),
          body: Container(

          ),
        );
  }
}
