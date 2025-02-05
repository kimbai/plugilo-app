import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plugilo/core/theme/colors.dart';
import 'package:plugilo/core/theme/typography.dart';

/// bottom sheet
const shapeBottomSheet = RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(
    top: Radius.circular(24),
  ),
);

/// button
final styleButtonPrimary = ButtonStyle(
  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
    const RoundedRectangleBorder(
      borderRadius: brRound10,
      side: BorderSide(color: Colors.transparent),
    ),
  ),
  backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return AppColors.neutral300;
    }
    return AppColors.blue700;
  }),
  foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
    return states.contains(WidgetState.disabled) ? AppColors.neutral500 : Colors.white;
  }),
  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.w)),
  textStyle: WidgetStateProperty.all<TextStyle>(typoSemiBold14),
  elevation: WidgetStateProperty.all<double>(0),
);

final styleButtonSecondary = ButtonStyle(
  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
    const RoundedRectangleBorder(
      borderRadius: brRound10,
      side: BorderSide(color: Colors.transparent),
    ),
  ),
  backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return AppColors.neutral300;
    }
    return AppColors.blue100;
  }),
  foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
    return states.contains(WidgetState.disabled) ? AppColors.neutral500 : AppColors.neutral800;
  }),
  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.w)),
  textStyle: WidgetStateProperty.all<TextStyle>(typoSemiBold14),
  elevation: WidgetStateProperty.all<double>(0),
);

final styleButtonCompat = ButtonStyle(
  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
    const RoundedRectangleBorder(
      borderRadius: brRound10,
      side: BorderSide(color: Colors.white, width: 2),
    ),
  ),
  backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
    return Colors.transparent;
  }),
  foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
    return states.contains(WidgetState.disabled) ? Colors.transparent : Colors.white;
  }),
  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w)),
  textStyle: WidgetStateProperty.all<TextStyle>(typoSemiBold14),
  elevation: WidgetStateProperty.all<double>(0),
  minimumSize: WidgetStateProperty.all<Size>(const Size(0, 0)),
);

/// textfield
final decorTextField = InputDecoration(
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.neutral300),
    borderRadius: brRound10,
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.blue400),
    borderRadius: brRound10,
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.red),
    borderRadius: brRound10,
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.red),
    borderRadius: brRound10,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
  labelStyle: typoRegular16.copyWith(color: AppColors.neutral800),
  hintStyle: typoRegular16.copyWith(color: AppColors.neutral400),
  errorStyle: typoRegular14.copyWith(color: Colors.red),
  counterText: '',
  fillColor: Colors.transparent,
  filled: true,
);

final decorCommentTextField = InputDecoration(
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  hintStyle: typoRegular14.copyWith(color: AppColors.contentSecondary),
  errorStyle: typoRegular14.copyWith(color: Colors.red),
  counterText: '',
  fillColor: Colors.transparent,
  filled: true,
);

final switchTheme = SwitchThemeData(
  thumbColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return AppColors.neutral300;
    }
    return AppColors.blue700;
  }),
  trackColor: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return AppColors.neutral300;
    }
    return AppColors.blue100;
  }),
);

/// decor container
const decorScreenContainer = BoxDecoration(
  color: AppColors.backgroundPrimary,
);

final decorSelectBox = BoxDecoration(
  borderRadius: brRoundMedium,
  color: Colors.transparent,
  border: Border.all(
    color: AppColors.linePrimary,
  ),
);

final decorBoxShadowBlue = BoxDecoration(
  color: AppColors.backgroundPrimary,
  borderRadius: BorderRadius.circular(16.0),
  boxShadow: [
    BoxShadow(
      color: AppColors.blue900.withOpacity(0.25),
      spreadRadius: 0,
      blurRadius: 16,
      offset: const Offset(0, 0),
    ),
  ],
);

const decorBackgroundBlueGradient = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.blue500,
      AppColors.blue700,
    ],
  ),
);

final decorContainerWhiteRadius20 = BoxDecoration(
  color: AppColors.white,
  borderRadius: BorderRadius.circular(20.0),
);

final flatButtonStyle = ButtonStyle(
  padding: WidgetStateProperty.all(EdgeInsets.zero),
  backgroundColor: WidgetStateProperty.all(Colors.transparent),
  elevation: WidgetStateProperty.all(0),
  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
);

/// border radius
const BorderRadius brRoundSquare = BorderRadius.all(Radius.zero);
const BorderRadius brRoundSmall = BorderRadius.all(Radius.circular(4));
const BorderRadius brRoundMedium = BorderRadius.all(Radius.circular(8));
const BorderRadius brRound10 = BorderRadius.all(Radius.circular(10));
const BorderRadius brRound20 = BorderRadius.all(Radius.circular(20));
const BorderRadius brRoundLarge = BorderRadius.all(Radius.circular(16));
