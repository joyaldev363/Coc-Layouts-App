import 'package:flutter/material.dart';

/// LoadingWidget provides a standardized circular progress indicator.
class LoadingWidget extends StatelessWidget {
  final double size;
  final Color? color;
  final double strokeWidth;

  const LoadingWidget({
    super.key,
    this.size = 40.0,
    this.color,
    this.strokeWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).colorScheme.primary,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
