// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CommonDropDownButtonFormField<T> extends StatelessWidget {
  const CommonDropDownButtonFormField({
    required this.items,
    required this.value,
    required this.dropdownMenuItem,
    super.key,
    this.labelText,
    this.validator,
    this.onChanged,
    this.isShowBorder = false,
    this.textStyle,
  });
  final List<T> items;
  final T? value;
  final String? labelText;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;
  final bool isShowBorder;
  final TextStyle? textStyle;
  final DropdownMenuItem<T> Function(T) dropdownMenuItem;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T?>(
      value: value,
      decoration: labelText != null
          ? InputDecoration(
              label: Text(
                labelText ?? '',
              ),
            )
          : const InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
      items: items
          .map(
            dropdownMenuItem,
          )
          .toList(),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
