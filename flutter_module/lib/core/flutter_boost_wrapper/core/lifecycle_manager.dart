import 'package:flutter/widgets.dart';
import 'package:flutter_boost/flutter_boost.dart';

/// 多维度生命周期管理
/// 职责：
/// 1. Flutter页面生命周期
/// 2. 原生容器生命周期
/// 3. 全局App生命周期

// class LifecycleManager {
//   static final LifecycleManager _instance = LifecycleManager._();
//
//   LifecycleManager._();
//
//   static LifecycleManager get instance => _instance;
//
//   void init() {
//     // 监听Flutter页面生命周期
//     WidgetsBinding.instance?.addObserver(
//       AppLifecycleListener(
//         onShow: () {
//           // 处理Flutter页面显示
//         },
//         onHide: () {
//           // 处理Flutter页面隐藏
//         },
//       ),
//     );
//
//     // 监听原生容器生命周期
//     BoostLifecycleBinding.instance.addObserver(
//       BoostLifecycleObserver(
//         onContainerDidPush: (container, previousContainer) {
//           // 处理原生容器push
//         },
//         onContainerDidPop: (container, previousContainer) {
//           // 处理原生容器pop
//         },
//       ),
//     );
//
//     // 监听全局App生命周期
//     SystemChannels.lifecycle.setMessageHandler((message) {
//       switch (message) {
//         case AppLifecycleState.resumed.toString():
//         // 处理App进入前台
//           break;
//         case AppLifecycleState.paused.toString():
//         // 处理App进入后台
//           break;
//       }
//       return Future.value();
//     });
//   }
// }


///全局生命周期监听示例
class AppLifecycleObserver with GlobalPageVisibilityObserver {
  @override
  void onBackground(Route route) {
    super.onBackground(route);
    print("AppLifecycleObserver - onBackground");
  }

  @override
  void onForeground(Route route) {
    super.onForeground(route);
    print("AppLifecycleObserver - onForground");
  }

  @override
  void onPagePush(Route route) {
    super.onPagePush(route);
    print("AppLifecycleObserver - onPagePush");
  }

  @override
  void onPagePop(Route route) {
    super.onPagePop(route);
    print("AppLifecycleObserver - onPagePop");
  }

  @override
  void onPageHide(Route route) {
    super.onPageHide(route);
    print("AppLifecycleObserver - onPageHide");
  }

  @override
  void onPageShow(Route route) {
    super.onPageShow(route);
    print("AppLifecycleObserver - onPageShow");
  }
}

///单个生命周期示例
class LifecycleTestPage extends StatefulWidget {
  const LifecycleTestPage({required Key key}) : super(key: key);

  @override
  _LifecycleTestPageState createState() => _LifecycleTestPageState();
}

class _LifecycleTestPageState extends State<LifecycleTestPage>
    with PageVisibilityObserver {
  @override
  void onBackground() {
    super.onBackground();
    print("LifecycleTestPage - onBackground");
  }

  @override
  void onForeground() {
    super.onForeground();
    print("LifecycleTestPage - onForeground");
  }

  @override
  void onPageHide() {
    super.onPageHide();
    print("LifecycleTestPage - onPageHide");
  }

  @override
  void onPageShow() {
    super.onPageShow();
    print("LifecycleTestPage - onPageShow");
  }

  @override
  void initState() {
    super.initState();

    ///请在didChangeDependencies中注册而不是initState中
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    ///注册监听器
    PageVisibilityBinding.instance.addObserver(this, ModalRoute.of(context) as Route);
  }

  @override
  void dispose() {
    ///移除监听器
    PageVisibilityBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}