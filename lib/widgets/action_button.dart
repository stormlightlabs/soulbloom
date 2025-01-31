// Copyright 2025, Stormlight Labs the Flutter project authors.

import 'dart:math';

import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const ActionButton({super.key, required this.child, this.onPressed});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return MouseRegion(
      onEnter: (event) => _controller.repeat(),
      onExit: (event) => _controller.stop(canceled: false),
      child: RotationTransition(
        turns: _controller.drive(const _MySineTween(0.005)),
        child: FilledButton(
          style: ButtonStyle(
            textStyle: WidgetStateProperty.fromMap({
              WidgetState.any: theme.labelLarge,
            }),
            padding: WidgetStateProperty.fromMap({
              WidgetState.any: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
            }),
            backgroundColor: WidgetStateColor.fromMap({
              WidgetState.any: Color(0xff354f52).withValues(alpha: 0.85),
            }),
          ),
          onPressed: widget.onPressed,
          child: widget.child,
        ),
      ),
    );
  }
}

class _MySineTween extends Animatable<double> {
  final double maxExtent;

  const _MySineTween(this.maxExtent);

  @override
  double transform(double t) {
    return sin(t * 2 * pi) * maxExtent;
  }
}
