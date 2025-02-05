import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plugilo/core/theme/app_styles.dart';
import 'package:plugilo/core/theme/colors.dart';
import 'package:plugilo/core/theme/typography.dart';
import 'package:plugilo/generated/locale_keys.g.dart';

dynamic bsMessage(
  BuildContext context, {
  Widget? icon,
  String? title,
  String? message,
  Widget? messageWidget,
  String? primaryButtonTitle,
  ButtonStyle? primaryButtonStyle,
  String? secondaryButtonTitle,
  ButtonStyle? secondaryButtonStyle,
  void Function()? onPrimary,
  void Function()? onSecondary,
  void Function()? onDismiss,
}) =>
    showModalBottomSheet<dynamic>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Offstage(
                offstage: icon == null,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.w),
                  child: icon,
                ),
              ),
              Offstage(
                offstage: title == null,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.w),
                  child: Text(
                    title ?? "",
                    style: typoIBMSemiBold24.copyWith(color: AppColors.neutral700),
                  ),
                ),
              ),
              Offstage(
                offstage: message == null,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.w),
                  child: Text(
                    message ?? "",
                    style: typoRegular16.copyWith(color: AppColors.neutral600),
                  ),
                ),
              ),
              Offstage(
                offstage: messageWidget == null,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.w),
                  child: messageWidget,
                ),
              ),
              if (primaryButtonTitle == null && secondaryButtonTitle == null)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: styleButtonPrimary,
                    onPressed: () {
                      onDismiss?.call();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      LocaleKeys.accept.tr(),
                    ),
                  ),
                )
              else
                Row(
                  children: [
                    if (secondaryButtonTitle != null)
                      Expanded(
                        child: ElevatedButton(
                          style: secondaryButtonStyle ?? styleButtonSecondary,
                          onPressed: () {
                            Navigator.of(context).pop();
                            onSecondary?.call();
                          },
                          child: Text(secondaryButtonTitle),
                        ),
                      ),
                    if (primaryButtonTitle != null && secondaryButtonTitle != null) SizedBox(width: 20.w),
                    if (primaryButtonTitle != null)
                      Expanded(
                        child: ElevatedButton(
                          style: primaryButtonStyle ?? styleButtonPrimary,
                          onPressed: () {
                            Navigator.of(context).pop();
                            onPrimary?.call();
                          },
                          child: Text(primaryButtonTitle),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        );
      },
    );

dynamic bsFullScreenMessage(BuildContext context, Widget content, {void Function()? onDismiss}) => showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: content,
        );
      },
    );
