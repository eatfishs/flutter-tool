/// @author: jiangjunhui
/// @date: 2025/1/24
library;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension TextFieldExtension on TextField {
  /**
   * TextField(
      decoration: InputDecoration(labelText: '自动获取焦点的输入框'),
      ).withAutoFocus()
   * */

  /// 自动获取焦点
  TextField withAutoFocus() {
    return TextField(
      controller: controller,
      focusNode: FocusNode()..requestFocus(),
      decoration: decoration,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: style,
      textAlign: textAlign,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      autocorrect: autocorrect,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onEditingComplete: onEditingComplete,
      inputFormatters: inputFormatters,
    );
  }

  /**
   * TextField(
      decoration: InputDecoration(labelText: '限制长度的输入框'),
      ).withLengthLimit(10)
   * */
  /// 限制长度
  TextField withLengthLimit(int maxLength) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: decoration,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: style,
      textAlign: textAlign,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      autocorrect: autocorrect,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onEditingComplete: onEditingComplete,
      inputFormatters: [
        ...(inputFormatters ?? []),
        LengthLimitingTextInputFormatter(maxLength),
      ],
    );
  }


  /**
   * TextField(
      decoration: InputDecoration(labelText: '手机号输入框'),
      ).withPhoneFormatting()
   * */
  /// 手机号格式化
  TextField withPhoneFormatting() {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: decoration,
      keyboardType: TextInputType.phone,
      textInputAction: textInputAction,
      style: style,
      textAlign: textAlign,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      autocorrect: autocorrect,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onEditingComplete: onEditingComplete,
      inputFormatters: [
        ...(inputFormatters ?? []),
        PhoneNumberInputFormatter(),
      ],
    );
  }

}



class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i == 3 || i == 7) {
        formattedText += ' ';
      }
      formattedText += newText[i];
    }
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}


