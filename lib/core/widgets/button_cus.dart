import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import 'loading_internal.dart';

/* Tự định nghĩa 1 button
  
  - text: nội dung hiển thị trên button
  - onPressed: hàm được gọi khi button được nhấn
  - backgroundColor: màu nền của button
  - textColor: màu chữ của button

*/

class ButtonCus extends StatelessWidget {
  final bool isLoading;
  final double? width;
  final double? height;
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const ButtonCus({
    super.key,
    required this.isLoading,
    required this.text,
    required this.width,
    required this.height,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    required TextStyle textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Button: $text',
      child: SizedBox(
        height: height ?? 50,
        width: width ?? double.infinity,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 5,
            disabledBackgroundColor: AppColors.textSecondary.withOpacity(0.5),
            backgroundColor: backgroundColor ?? AppColors.primary,
            foregroundColor: textColor ?? AppColors.textPrimary,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: isLoading == true
              ? LoadingInternal(
                  color: AppColors.textPrimary,
                  loading: isLoading,
                )
              : Text(
                  text,
                  style: AppStyles.button.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor ?? AppColors.textPrimary,
                  ),
                ),
        ),
      ),
    );
  }
}
