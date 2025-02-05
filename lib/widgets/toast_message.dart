import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:plugilo/core/theme/colors.dart';
import 'package:plugilo/core/theme/typography.dart';

void toastSuccess(BuildContext context, String message) => showToastWidget(
      MessageToastWidget.success(message),
      context: context,
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      alignment: Alignment.centerLeft,
      axis: Axis.horizontal,
      position: StyledToastPosition.bottom,
      animDuration: const Duration(milliseconds: 400),
      duration: const Duration(seconds: 3),
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.fastOutSlowIn,
      isIgnoring: true,
    );

void toastFail(BuildContext context, String message) => showToastWidget(
      MessageToastWidget.fail(message),
      context: context,
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      alignment: Alignment.centerLeft,
      axis: Axis.horizontal,
      position: StyledToastPosition.bottom,
      animDuration: const Duration(milliseconds: 400),
      duration: const Duration(seconds: 3),
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.fastOutSlowIn,
      isIgnoring: true,
    );

void toastWarning(BuildContext context, String message) => showToastWidget(
      MessageToastWidget.warning(message),
      context: context,
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      alignment: Alignment.centerLeft,
      axis: Axis.horizontal,
      position: StyledToastPosition.bottom,
      animDuration: const Duration(milliseconds: 400),
      duration: const Duration(seconds: 3),
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.fastOutSlowIn,
      isIgnoring: true,
    );

void toastInfo(BuildContext context, String message) => showToastWidget(
      MessageToastWidget.info(message),
      context: context,
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      alignment: Alignment.centerLeft,
      axis: Axis.horizontal,
      position: StyledToastPosition.bottom,
      animDuration: const Duration(milliseconds: 400),
      duration: const Duration(seconds: 3),
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.fastOutSlowIn,
      isIgnoring: true,
    );

void toastMessage(BuildContext context, String message) => showToastWidget(
      MessageToastWidget.message(message),
      context: context,
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      alignment: Alignment.centerLeft,
      axis: Axis.horizontal,
      position: StyledToastPosition.bottom,
      animDuration: const Duration(milliseconds: 400),
      duration: const Duration(seconds: 3),
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.fastOutSlowIn,
      isIgnoring: true,
    );

class MessageToastWidget extends StatelessWidget {
  final Color backgroundColor;
  final String message;
  final Color messageColor;
  final IconData? icon;
  final Color? iconColor;

  const MessageToastWidget({
    super.key,
    required this.backgroundColor,
    required this.message,
    required this.messageColor,
    this.iconColor,
    this.icon,
  });

  factory MessageToastWidget.message(String msg) => MessageToastWidget(
        message: msg,
        messageColor: Colors.white,
        backgroundColor: AppColors.blue500,
      );

  factory MessageToastWidget.info(String msg) => MessageToastWidget(
        message: msg,
        messageColor: AppColors.infoBackground,
        // icon: IconsaxPlusBold.info_circle,
        iconColor: AppColors.infoBackground,
        backgroundColor: AppColors.infoText,
      );

  factory MessageToastWidget.warning(String msg) => MessageToastWidget(
        message: msg,
        messageColor: AppColors.warningText,
        // icon: IconsaxPlusBold.danger,
        iconColor: AppColors.warningText,
        backgroundColor: AppColors.warningBackground,
      );

  factory MessageToastWidget.fail(String msg) => MessageToastWidget(
        message: msg,
        messageColor: AppColors.errorBackground,
        // icon: IconsaxPlusBold.close_square,
        iconColor: AppColors.errorBackground,
        backgroundColor: AppColors.errorText,
      );

  factory MessageToastWidget.success(String msg) => MessageToastWidget(
        message: msg,
        messageColor: AppColors.successBackground,
        // icon: IconsaxPlusBold.tick_square,
        iconColor: AppColors.successBackground,
        backgroundColor: AppColors.successText,
      );

  @override
  Widget build(BuildContext context) {
    Widget content = Material(
      color: Colors.transparent,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 16.0, left: 32.0, right: 32.0),
          decoration: ShapeDecoration(
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Offstage(
                offstage: icon == null,
                child: Container(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Icon(
                    icon,
                    size: 24,
                    color: iconColor,
                  ),
                ),
              ),
              Text(
                message,
                style: typoRegular14.copyWith(
                  color: messageColor,
                ),
                softWrap: true,
                maxLines: 5,
              ),
            ],
          )),
    );

    return content;
  }
}
