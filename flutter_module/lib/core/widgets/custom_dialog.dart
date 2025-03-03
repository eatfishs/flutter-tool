/**
 * @author: jiangjunhui
 * @date: 2025/3/3
 */
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.info,
              size: 48,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            const Text(
              '自定义对话框',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '这是一个自定义的对话框，你可以根据需求进行定制。',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('取消'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('确定'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
