import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final Widget child;
  final double delay;

  const FadeAnimation(this.delay, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween('opacity', Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 500))
          .thenTween('y', Tween(begin: -30.0, end: 0.0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack);

    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (250 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, value, child) => Opacity(
        opacity: value.get("opacity"),
        child: Transform.translate(
            offset: Offset(0, value.get("y")), child: child),
      ),
    );
  }
}
