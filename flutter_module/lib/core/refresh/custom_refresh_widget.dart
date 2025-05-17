/// @author: jiangjunhui
/// @date: 2025/2/6
library;
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

// 封装的刷新组件
class CustomRefreshWidget<T> extends StatelessWidget {
  final RefreshController controller;
  final Future<void> Function() onRefresh;
  final Future<void> Function()? onLoading;
  final List<T> dataList;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const CustomRefreshWidget({
    super.key,
    required this.controller,
    required this.onRefresh,
    this.onLoading,
    required this.dataList,
    required this.itemBuilder,
  });

  Widget headerBuilder(BuildContext context, RefreshStatus? mode) {
    Widget body;
    if (mode == RefreshStatus.idle) {
      body = const Text("下拉刷新", style: TextStyle(fontSize: 16));
    } else if (mode == RefreshStatus.refreshing) {
      body = const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      );
    } else if (mode == RefreshStatus.canRefresh) {
      body = const Text("释放立即刷新", style: TextStyle(fontSize: 16));
    } else if (mode == RefreshStatus.completed) {
      body = const Text("刷新完成", style: TextStyle(fontSize: 16));
    } else if (mode == RefreshStatus.failed) {
      body = const Text("刷新失败", style: TextStyle(fontSize: 16));
    } else {
      body = const Text("未知状态", style: TextStyle(fontSize: 16));
    }
    return Container(
      height: 80.0,
      alignment: Alignment.center,
      color: Colors.white, // 设置背景颜色
      child: body,
    );
  }

  Widget footerBuilder(BuildContext context, LoadStatus? mode) {
    Widget body;
    if (mode == LoadStatus.idle) {
      body = const Text(
        "上拉加载",
        style: TextStyle(fontSize: 16),
      );
    } else if (mode == LoadStatus.loading) {
      body = const CircularProgressIndicator();
    } else if (mode == LoadStatus.failed) {
      body = const Text("加载失败！点击重试！", style: TextStyle(fontSize: 16));
    } else if (mode == LoadStatus.canLoading) {
      body = const Text("释放加载更多", style: TextStyle(fontSize: 16));
    } else {
      body = const Text("没有更多数据了", style: TextStyle(fontSize: 16));
    }
    return SizedBox(
      height: 55.0,
      child: Center(child: body),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      springDescription:
          const SpringDescription(stiffness: 200, damping: 20, mass: 2.0),
      // 调整弹簧动画属性
      maxOverScrollExtent: 80,
      // 减少最大下拉距离
      maxUnderScrollExtent: 0,
      enableScrollWhenRefreshCompleted: true,
      enableLoadingWhenFailed: true,
      hideFooterWhenNotFull: false,
      enableBallisticLoad: true,
      child: SmartRefresher(
        controller: controller,
        enablePullDown: true,
        enablePullUp: onLoading != null,
        header: CustomHeader(builder: headerBuilder),
        footer: CustomFooter(builder: footerBuilder),
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }
}
