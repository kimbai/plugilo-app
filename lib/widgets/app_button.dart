import 'dart:async';

import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final Duration debounceDuration;

  const AppButton({
    super.key,
    this.onPressed,
    required this.child,
    this.style,
    this.debounceDuration = const Duration(milliseconds: 500),
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isProcessing = false;
  Timer? _debounceTimer;

  void _handleTap() {
    if (_isProcessing) return;

    _isProcessing = true;
    widget.onPressed?.call();

    _debounceTimer = Timer(widget.debounceDuration, () {
      _isProcessing = false;
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _handleTap,
      style: widget.style,
      child: widget.child,
    );
  }
}
