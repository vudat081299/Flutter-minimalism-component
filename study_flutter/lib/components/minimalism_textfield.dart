import 'package:flutter/material.dart';

class MinimalismTextField extends StatelessWidget {
  const MinimalismTextField({
    super.key,
    required String label,
    required TextEditingController controller,
    String? suffixText,
    String? hintText,
    TextInputType? textInputType,
  })  : _textInputType = textInputType,
        _hintText = hintText,
        _suffixText = suffixText,
        _controller = controller,
        _label = label;

  final String _label;
  final TextEditingController _controller;
  final String? _suffixText;
  final String? _hintText;
  final TextInputType? _textInputType;
  
  @override
  Widget build(BuildContext context) {
    const outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius: BorderRadius.zero,
    );
    const secondaryTextStyle = TextStyle(color: Colors.grey);
    return TextField(
      autofocus: true,
      controller: _controller,
      decoration: InputDecoration(
        border: outlineInputBorder,
        labelText: _label,
        labelStyle: secondaryTextStyle,
        suffixText: _suffixText,
        suffixStyle: secondaryTextStyle,
        hintText: _hintText,
        hintStyle: secondaryTextStyle,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
      ),
      style: const TextStyle(color: Colors.black),
      textInputAction: TextInputAction.next,
      keyboardType: _textInputType ?? TextInputType.text,
      maxLines: 1,
    );
  }
}
