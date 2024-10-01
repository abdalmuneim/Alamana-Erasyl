import 'package:alamanaelrasyl/core/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.onPressed,
    this.color,
    this.radius,
    required this.child,
    this.side,
    this.maximumSize,
    this.minimumSize,
    this.isCircle,
    this.elevation,
    this.padding,
    this.borderRadius,
    this.label,
  });
  final void Function()? onPressed;
  final Color? color;
  final double? radius;
  final BorderSide? side;
  final Size? maximumSize, minimumSize;
  final bool? isCircle;
  final String? label;
  final double? elevation;
  final Widget child;
  final EdgeInsets? padding;
  final BorderRadiusGeometry? borderRadius;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              padding: WidgetStateProperty.all(padding),
              elevation: WidgetStateProperty.all(elevation),
              maximumSize: WidgetStateProperty.all(maximumSize),
              minimumSize: WidgetStateProperty.all(minimumSize),
              backgroundColor: WidgetStateProperty.all(
                color,
              ),
              shape: isCircle ?? false
                  ? WidgetStateProperty.all<CircleBorder>(
                      CircleBorder(side: side ?? BorderSide.none),
                    )
                  : WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: borderRadius ??
                              BorderRadius.circular(radius ?? 15),
                          side: side ?? BorderSide.none),
                    ),
            ),
        onPressed: onPressed,
        child: child);
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.color,
    this.radius = 10,
    this.border,
    this.height = 56,
    this.width,
    this.shape = BoxShape.rectangle,
    this.child,
    this.padding,
    this.borderRadius,
    this.margin,
    this.text,
    this.textTheme,
    this.textColor = AppColors.mainApp,
    this.fontWeight = FontWeight.bold,
    this.fontSize,
    this.gradient,
  });
  final void Function()? onPressed;
  final Color? color, textColor;
  final double? radius, height, width, fontSize;
  final BoxBorder? border;
  final String? text;
  final BoxShape? shape;
  final FontWeight? fontWeight;
  final ButtonTextTheme? textTheme;
  final Gradient? gradient;
  final Widget? child;
  final EdgeInsets? padding, margin;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width ?? 55.w,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          shape: shape!,
          border: border,
          borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 20),
          gradient: gradient,
          color: gradient != null ? null : color,
        ),
        child: text != null
            ? Text(
                text ?? "",
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize ?? 14.sp,
                  fontWeight: fontWeight,
                ),
              )
            : child,
      ),
    );
  }
}
