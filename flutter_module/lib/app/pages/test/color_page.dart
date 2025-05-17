import 'package:flutter/material.dart';
import 'package:flutter_module/core/utils/extension_color.dart';
import 'package:flutter_module/core/widgets/custom_appBar_widget.dart';
class ColorPage extends StatelessWidget {
  const ColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '颜色',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings button press
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings pressed')),
              );
            },
          ),
        ],
        onBackPressed: () {
          // Handle back button press, if needed
          Navigator.pop(context);
        },
      ),
      body: Center(
        child: Text('Welcome to the Home Screen!',
          style: TextStyle(color: ColorExtension.hexAColor(0x3caafa))),
      ),
    );
  }
}
























