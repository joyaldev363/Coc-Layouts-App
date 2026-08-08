import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';
import '../constants/app_strings.dart';
import 'primary_button.dart';

/// ErrorWidget provides a standard UI for error states.
class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const AppErrorWidget({
    super.key,
    this.message = AppStrings.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.paddingLg,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            AppSpacing.hMd,
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (onRetry != null) ...[
              AppSpacing.hLg,
              PrimaryButton(
                text: AppStrings.retry,
                onPressed: onRetry,
                width: 150,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
