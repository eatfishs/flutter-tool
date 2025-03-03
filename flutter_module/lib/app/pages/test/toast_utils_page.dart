/**
 * @author: jiangjunhui
 * @date: 2025/2/8
 */
import 'package:flutter/material.dart';

import '../../../core/toast/toast_util.dart';
import '../../../core/widgets/custom_appBar_widget.dart';
import '../../../core/widgets/custom_bottom_sheet_content.dart';
import '../../../core/widgets/custom_dialog.dart';

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
              child: const Text('显示自定义对话框'),
            ),
            ElevatedButton(
              onPressed: _showCustomBottomSheet,
              child: const Text('显示自定义底部弹窗'),
            ),
          ],
        ),
      ),
    );
  }
}
