/**
 * @author: jiangjunhui
 * @date: 2025/2/7
 */
import 'package:flutter/material.dart';
import '../../../core/eventBus/event_bus_util.dart';
import '../../../core/widgets/custom_appBar_widget.dart';
import '../../data/eventBus/user_loggedIn_event.dart';

class EventBusPage extends StatefulWidget {
  const EventBusPage({super.key});

  @override
  State<EventBusPage> createState() => _EventBusPageState();
}

class _EventBusPageState extends State<EventBusPage> with EventBusMixin {
  @override
  void initState() {
    super.initState();
    print('initState');
    // 自动管理订阅
    subscribe<UserLoggedInEvent>(handleLogin);
    subscribe<DataUpdatedEvent>(dataUpdated);
  }

  void handleLogin(UserLoggedInEvent event) {
    print('User logged in: ${event.username}');

  }
  void dataUpdated(DataUpdatedEvent event) {
    print("更新数据：${event.data}");
  }

  @override
  void dispose() {
    print('dispose---EventBusPage');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: CustomAppBar(
            title: 'EventBus',
            actions: [
            ],
            onBackPressed: () {
              // Handle back button press, if needed
              Navigator.pop(context);
            },
          ),
          body: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                    height: 50,
                    width: 200,
                    color: Colors.red,
                    child:
                    TextButton(onPressed: () {
                      // 发送事件
                      AppEventBus.sendEvent(UserLoggedInEvent('Alice'));
                    }, child: Text("用户昵称按钮"))),
                SizedBox(height: 50),
                Container(
                    height: 50,
                    width: 200,
                    color: Colors.red,
                    child:
                    TextButton(onPressed: () {
                      // 发送事件
                      AppEventBus.sendEvent(DataUpdatedEvent("kkkkk"));
                    }, child: Text("普通更新按钮"))),
              ],
            ),
          ),
        );
  }

}

 
 
 
 
 
 
 
 
 
 
 
 