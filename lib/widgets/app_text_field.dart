import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plugilo/core/theme/app_styles.dart';
import 'package:plugilo/core/theme/colors.dart';
import 'package:plugilo/core/theme/typography.dart';

class AppTextField extends StatefulWidget {
  final IconData? leftIcon;
  final Color? leftIconColor;
  final IconData? rightIcon;
  final Color? rightIconColor;
  final GestureTapCallback onRightIconTap;
  final String? label;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final bool? showClearButton;
  final bool? isPassword;
  final bool? isCurrency;
  final String? hintText;
  final String? errorText;
  final void Function(bool hasFocus)? onFocusChanged;
  final int? maxLength;
  final ValueChanged<String>? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;

  const AppTextField(
      {super.key,
      this.leftIcon,
      this.leftIconColor,
      this.rightIcon,
      this.rightIconColor,
      this.label,
      this.controller,
      this.decoration,
      this.keyboardType,
      this.showClearButton,
      this.isPassword,
      this.isCurrency,
      this.hintText,
      this.errorText,
      this.onFocusChanged,
      this.maxLength,
      this.onChange,
      this.onRightIconTap = _onRightIconTap,
      this.inputFormatters,
      this.readOnly});

  static _onRightIconTap() {}

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final _focus = FocusNode();
  final _controller = TextEditingController();
  bool _isObscure = false;
  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    _isObscure = widget.isPassword ?? false;
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    _controller.dispose();
  }

  void _onFocusChange() {
    widget.onFocusChanged?.call(_focus.hasFocus);
  }

  void changeObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = widget.controller ?? _controller;

    return ValueListenableBuilder(
      valueListenable: ctrl,
      builder: (context, value, child) {
        return TextField(
          controller: ctrl,
          inputFormatters: widget.inputFormatters,
          maxLength: widget.maxLength,
          focusNode: _focus,
          keyboardType: widget.keyboardType,
          obscureText: _isObscure,
          decoration: (widget.decoration ?? decorTextField).copyWith(
            labelText: widget.label,
            hintText: widget.hintText,
            prefixIcon: widget.leftIcon != null
                ? Icon(
                    widget.leftIcon,
                    color: widget.leftIconColor ?? AppColors.neutral400,
                    size: 20.w,
                  )
                : null,
            suffixIcon: _buildSuffixIcon(ctrl, _isObscure, changeObscure),
            errorText: widget.errorText,
            errorMaxLines: 5,
            contentPadding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
          ),
          onChanged: widget.onChange,
          readOnly: widget.readOnly ?? false,
        );
      },
    );
  }

  Widget _buildSuffixIcon(TextEditingController ctrl, bool obscureText, Function changeObscure) {
    if (widget.showClearButton == true && ctrl.text.isNotEmpty == true) {
      return GestureDetector(
        onTap: () {
          ctrl.clear();
          widget.onRightIconTap();
        },
        child: const Icon(
          Icons.close,
          color: AppColors.neutral400,
          size: 20,
        ),
      );
    } else if (widget.isPassword == true) {
      return GestureDetector(
        onTap: () {
          changeObscure();
        },
        child: Icon(
          obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: AppColors.neutral400,
          size: 20,
        ),
      );
    } else if (widget.rightIcon != null) {
      return GestureDetector(
        onTap: widget.onRightIconTap,
        child: Icon(
          widget.rightIcon,
          color: widget.rightIconColor ?? AppColors.neutral400,
          size: 20.w,
        ),
      );
    } else if (widget.isCurrency != null) {
      return SizedBox(
        height: 20.w,
        width: 20.w,
        child: Center(
            child: Text('đ',
                style: typoSemiBold16.copyWith(
                  color: AppColors.neutral800,
                ))),
      );
    } else {
      return const SizedBox();
    }
  }
}
