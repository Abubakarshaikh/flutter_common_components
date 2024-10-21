// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_common_components/src/utils/icons_utils.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    Key? key,
    this.controller,
    this.keyboardType,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.inputFormatters,
    this.validator,
    this.maxLength,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.errorText,
  }) : super(key: key);
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? labelText;
  final String? hintText;

  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final int? maxLength;
  final void Function(String?)? onChanged;
  final bool readOnly;
  final void Function()? onTap;
  final String? errorText;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _obscured = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      obscureText: _obscured,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        errorText: widget.errorText,
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixIcon: widget.obscureText
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: GestureDetector(
                  onTap: _toggleObscured,
                  child: Icon(
                    _obscured
                        ? IconUtils.visibilityRounded
                        : IconUtils.visibilityOffRounded,
                    size: 24,
                  ),
                ),
              )
            : null,
      ),
    );
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }
}
