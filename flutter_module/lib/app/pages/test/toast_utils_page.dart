/**
 * @author: jiangjunhui
 * @date: 2025/2/8
 */
import 'package:flutter/material.dart';

import '../../../core/dialog/dialog_queue.dart';
import '../../../core/toast/toast_util.dart';
import '../../../core/widgets/custom_appBar_widget.dart';
import '../../../core/dialog/custom_bottom_sheet_content.dart';
import '../../../core/dialog/custom_dialog.dart';

class ToastUtilsPage extends StatefulWidget {
  const ToastUtilsPage({super.key});

  @override
  State<ToastUtilsPage> createState() => _ToastUtilsPageState();
}

class _ToastUtilsPageState extends State<ToastUtilsPage> {
  void _showCustomDialog() {
    showDialog(
      // 设置点击背景时对话框不消失
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const CustomDialog();
      },
    );
  }

  void _showCustomBottomSheet() {
    showModalBottomSheet(
      context: context,
      // 设置弹窗的形状，这里设置了圆角
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      // 点击背景时弹窗不消失
      isDismissible: false,
      // 弹窗是否可以拖动关闭
      enableDrag: false,
      builder: (BuildContext context) {
        return const CustomBottomSheetContent();
      },
    );
  }

  void _showQueueDiaLog() {
    // // 在任意位置添加弹窗
    DialogQueue().add(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('提示1'),
        content: const Text('这是第一个弹窗'),
        actions: [
          TextButton(
            child: const Text('关闭'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      onDismiss: () => print('第一个弹窗关闭'),
    );

    // 添加底部弹窗
    DialogQueue().add(
        context: context,
        type: DialogType.bottom,
        builder: (_) => CustomBottomSheetContent(),
        backgroundColor: Colors.grey[100],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))));

    DialogQueue().add(
      context: context,
      builder: (BuildContext context) {
        return const CustomDialog();
      },
      type: DialogType.center,
      onDismiss: () {
        print('自定义弹窗已关闭');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Toast',
        actions: [],
        onBackPressed: () {
          // Handle back button press, if needed
          Navigator.pop(context);
        },
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ToastUtil.showToast(msg: "提示信息");
              },
              child: const Text('提示信息 Toast'),
            ),
            ElevatedButton(
              onPressed: () {
                ToastUtil.showLoading(msg: "loading", dismissOnTap: true);
              },
              child: const Text('loading'),
            ),
            ElevatedButton(
              onPressed: _showCustomDialog,
              child: const Text('显示中间样式弹窗'),
            ),
            ElevatedButton(
              onPressed: _showCustomBottomSheet,
              child: const Text('显示自定义底部弹窗'),
            ),
            ElevatedButton(
              onPressed: _showQueueDiaLog,
              child: const Text('弹窗队列'),
            )
          ],
        ),
      ),
    );
  }
}
