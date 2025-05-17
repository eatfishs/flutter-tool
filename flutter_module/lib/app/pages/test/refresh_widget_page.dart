/// @author: jiangjunhui
/// @date: 2025/2/6
library;
import 'package:flutter/material.dart';
import 'package:flutter_module/core/refresh/custom_refresh_widget.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../../core/widgets/custom_appBar_widget.dart';

class RefreshWidgetPage extends StatefulWidget {
  const RefreshWidgetPage({super.key});

  @override
  State<RefreshWidgetPage> createState() => _RefreshWidgetPageState();
}

class _RefreshWidgetPageState extends State<RefreshWidgetPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<int> _dataList = [];

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  Future<void> _onRefresh() async {
    try {
      // 模拟网络请求
      await Future.delayed(const Duration(milliseconds: 1000));
      setState(() {
        _dataList = List.generate(20, (index) => index);
      });
      _refreshController.refreshCompleted();
    } catch (e) {
      _refreshController.refreshFailed();
    }
  }

  Future<void> _onLoading() async {
    try {
      // 模拟网络请求
      await Future.delayed(const Duration(milliseconds: 1000));
      setState(() {
        final newData = List.generate(10, (index) => index + _dataList.length);
        _dataList.addAll(newData);
      });
      _refreshController.loadComplete();
    } catch (e) {
      _refreshController.loadFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '刷新',
        actions: const [],
        onBackPressed: () {
          // Handle back button press, if needed
          Navigator.pop(context);
        },
      ),
      body: Container(
        color: Colors.white,
        child: CustomRefreshWidget(
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          dataList: _dataList,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Item ${_dataList[index]}'),
            );
          },
        ),
      ),
    );
  }
}
