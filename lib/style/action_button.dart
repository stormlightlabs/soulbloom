// Copyright 2023, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:soulbloom/style/palette.dart';

class ActionButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const ActionButton({super.key, required this.child, this.onPressed});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton>
    with SingleTickerProviderStateMixin {
  final Palette palette = Palette();
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
    return MouseRegion(
      onEnter: (event) {
        _controller.repeat();
      },
      onExit: (event) {
        _controller.stop(canceled: false);
      },
      child: RotationTransition(
        turns: _controller.drive(const _MySineTween(0.005)),
        child: FilledButton(
          style: ButtonStyle(
            textStyle: WidgetStateProperty.fromMap({
              WidgetState.any: TextStyle(
                fontSize: 30,
                fontFamily: "Jersey 15",
              ),
            }),
            padding: WidgetStateProperty.fromMap({
              WidgetState.any: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
            }),
            backgroundColor: WidgetStateColor.fromMap({
              WidgetState.any: palette.buttonBackground.withValues(alpha: 0.75),
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
