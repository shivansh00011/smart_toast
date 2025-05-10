
A smart, context-aware toast notification package for Flutter that automatically detects message types and displays appropriately styled notifications.

## Features

- Automatic detection of message type (success, error, warning, info) based on content.
- Custom styling based on message type (colors and icons).
- Support for custom action buttons with callbacks.
- Customizable display duration.
- Override options for background color, type, and actions.

## Getting Started

To add `smart_toast` to your project, include it in your `pubspec.yaml`:

```yaml
dependencies:
  smart_toast: ^1.0.0
```

Run:

```bash
flutter pub get
```

## Usage

```dart
import 'package:smart_toast/smart_toast.dart';

// Simple usage with auto-detection
SmartToast.show(context, "Operation successful!");

// Error message (will automatically use error styling)
SmartToast.show(context, "Failed to load data");

// With custom action
SmartToast.show(
  context, 
  "Profile updated successfully", 
  actionLabel: "View Profile",
  onActionPressed: () {
    Navigator.pushNamed(context, '/profile');
  }
);

// With custom duration and background color
SmartToast.show(
  context, 
  "Custom colored toast", 
  backgroundColor: Colors.purple,
  duration: const Duration(seconds: 5)
);
```

## Additional information

### Auto-detection Mechanism

SmartToast intelligently detects the type of notification by analyzing the message content:

```dart
static ToastType _detectType(String message) {
  final lower = message.toLowerCase();
  if (lower.contains("error") || lower.contains("failed")) return ToastType.error;
  if (lower.contains("success") || lower.contains("done") || lower.contains("updated")) return ToastType.success;
  if (lower.contains("warn") || lower.contains("caution") || lower.contains("oops")) return ToastType.warning;
  return ToastType.info;
}
```


