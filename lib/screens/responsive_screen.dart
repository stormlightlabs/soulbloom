// Copyright 2025, Stormlight Labs and the Flutter project authors.

import 'package:flutter/material.dart';

/// A widget that makes it easy to create a screen with a square-ish
/// main area, a smaller menu area, and a small area for a message on top.
/// It works in both orientations on mobile- and tablet-sized screens.
class ResponsiveScreen extends StatelessWidget {
  /// Square "hero" of the screen. In the visual "center" of the screen.
  final Widget squarishMainArea;

  /// Second-largest area after [squarishMainArea]. Narrow or wide.
  final Widget rectangularMenuArea;

  /// An area reserved for some static text close to the top of the screen.
  final Widget topMessageArea;

  const ResponsiveScreen({
    required this.squarishMainArea,
    required this.rectangularMenuArea,
    this.topMessageArea = const SizedBox.shrink(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        final padding = EdgeInsets.all(size.shortestSide / 30);
        final isMobile = size.height >= size.width;
        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SafeArea(
                bottom: false,
                child: Padding(padding: padding, child: topMessageArea),
              ),
              Expanded(
                child: SafeArea(
                  top: false,
                  bottom: false,
                  minimum: padding,
                  child: squarishMainArea,
                ),
              ),
              SafeArea(
                top: false,
                maintainBottomViewPadding: true,
                child: Padding(
                  padding: padding,
                  child: Center(child: rectangularMenuArea),
                ),
              ),
            ],
          );
        } else {
          final isTablet = size.width > 900;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: isTablet ? 7 : 5,
                child: SafeArea(
                  right: false,
                  maintainBottomViewPadding: true,
                  minimum: padding,
                  child: squarishMainArea,
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    SafeArea(
                      bottom: false,
                      left: false,
                      maintainBottomViewPadding: true,
                      child: Padding(padding: padding, child: topMessageArea),
                    ),
                    Expanded(
                      child: SafeArea(
                        top: false,
                        left: false,
                        maintainBottomViewPadding: true,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: padding,
                            child: rectangularMenuArea,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
