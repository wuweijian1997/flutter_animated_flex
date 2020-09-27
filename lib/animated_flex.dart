library animated_flex;

import 'package:flutter/material.dart';

typedef AnimationWidgetBuilder = Widget Function(
    Animation animation, Widget child);

Widget _defaultAnimationWidgetBuilder(Animation animation, Widget child) {
  return Opacity(
    opacity: animation.value,
    child: Transform(
      transform:
          Matrix4.translationValues(0, 10 * (1.0 - animation.value), 0.0),
      child: child,
    ),
  );
}

///Custom animation effect flex
class AnimatedFlex extends StatefulWidget {
  final Axis direction;

  final MainAxisAlignment mainAxisAlignment;

  final MainAxisSize mainAxisSize;

  final CrossAxisAlignment crossAxisAlignment;

  final TextDirection textDirection;

  final VerticalDirection verticalDirection;

  final TextBaseline textBaseline;

  final Clip clipBehavior;

  final List<Widget> children;

  /// Animation duration
  final Duration duration;

  /// Delay animation execution
  final Duration delayed;

  /// Animation end event
  final VoidCallback onEnd;

  /// Custom animation effect
  final AnimationWidgetBuilder animationWidgetBuilder;

  const AnimatedFlex(
      {Key key,
      this.direction = Axis.vertical,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.mainAxisSize = MainAxisSize.max,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.textDirection,
      this.verticalDirection = VerticalDirection.down,
      this.textBaseline,
      this.clipBehavior = Clip.hardEdge,
      this.children = const <Widget>[],
      this.duration = const Duration(milliseconds: 1000),
      this.delayed = const Duration(milliseconds: 0),
      this.animationWidgetBuilder = _defaultAnimationWidgetBuilder,
      this.onEnd})
      : super(key: key);

  @override
  _AnimatedFlexState createState() => _AnimatedFlexState();
}

class _AnimatedFlexState extends State<AnimatedFlex>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  Axis get direction => widget.direction;

  MainAxisAlignment get mainAxisAlignment => widget.mainAxisAlignment;

  MainAxisSize get mainAxisSize => widget.mainAxisSize;

  CrossAxisAlignment get crossAxisAlignment => widget.crossAxisAlignment;

  TextDirection get textDirection => widget.textDirection;

  VerticalDirection get verticalDirection => widget.verticalDirection;

  TextBaseline get textBaseline => widget.textBaseline;

  Clip get clipBehavior => widget.clipBehavior;

  List<Widget> get children => widget.children;

  Duration get duration => widget.duration;

  Duration get delayed => widget.delayed;

  VoidCallback get onEnd => widget.onEnd;

  AnimationWidgetBuilder get animationWidgetBuilder =>
      widget.animationWidgetBuilder;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: duration);
    Future.delayed(delayed, () {
      if(mounted) {
        animationController?.forward();
      }
    });
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        onEnd?.call();
      }
    });
  }

  List<Widget> initAnimationList() {
    List<Widget> list = [];
    int count = children.length;
    for (int i = 0; i < count; i++) {
      final Animation<double> animation =
          Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      Widget child = children[i];
      if(child is Expanded) {
        Expanded newChild = child as Expanded;
        child = Expanded(child: animationWidgetBuilder(animation, newChild.child));
      } else {
        child = animationWidgetBuilder(animation, child);
      }
      list.add(child);
    }
    return list;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Flex(
            direction: direction,
            children: initAnimationList(),
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            crossAxisAlignment: crossAxisAlignment,
            textDirection: textDirection,
            verticalDirection: verticalDirection,
            textBaseline: textBaseline,
            clipBehavior: clipBehavior,
          );
        });
  }
}
