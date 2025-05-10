import 'package:flutter/material.dart';

enum ToastType { success, error, warning, info }

class SmartToast {
  static void show(
    BuildContext context, 
    String message, {
    ToastType? overrideType,
    String? actionLabel, // Custom action label
    VoidCallback? onActionPressed, // Action callback
    Duration? duration, // Custom duration
    Color? backgroundColor, // Custom background color
  }) {
    final type = overrideType ?? _detectType(message);
    
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(_iconForType(type), color: Colors.white),
          const SizedBox(width: 10),
          Expanded(child: Text(message)),
        ],
      ),
      backgroundColor: backgroundColor ?? _colorForType(type), // Use custom color if provided
      action: _actionForType(type, actionLabel, onActionPressed), // Handle custom action
      duration: duration ?? const Duration(seconds: 3), // Use custom duration if provided
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static ToastType _detectType(String message) {
    final lower = message.toLowerCase();
    if (lower.contains("error") || lower.contains("failed")) return ToastType.error;
    if (lower.contains("success") || lower.contains("done") || lower.contains("updated")) return ToastType.success;
    if (lower.contains("warn") || lower.contains("caution") || lower.contains("oops")) return ToastType.warning;
    return ToastType.info;
  }

  static Color _colorForType(ToastType type) {
    switch (type) {
      case ToastType.error:
        return Colors.red;
      case ToastType.success:
        return Colors.green;
      case ToastType.warning:
        return Colors.orange;
      case ToastType.info:
      default:
        return Colors.blue;
    }
  }

  static IconData _iconForType(ToastType type) {
    switch (type) {
      case ToastType.error:
        return Icons.error;
      case ToastType.success:
        return Icons.check_circle;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.info:
      default:
        return Icons.info;
    }
  }

  static SnackBarAction? _actionForType(
    ToastType type, 
    String? actionLabel, 
    VoidCallback? onActionPressed,
  ) {
    if (actionLabel != null && onActionPressed != null) {
      return SnackBarAction(
        label: actionLabel,
        onPressed: onActionPressed,
      );
    } else if (type == ToastType.error) {
      return SnackBarAction(
        label: "Retry",
        onPressed: onActionPressed ?? () {},
      );
    } else if (type == ToastType.warning) {
      return SnackBarAction(
        label: "Dismiss",
        onPressed: onActionPressed ?? () {},
      );
    }
    return null;
  }
}
