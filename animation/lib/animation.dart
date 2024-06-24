import 'package:flutter/material.dart';

// Enum to define the possible directions for the fade-in animation
enum FadeInDirection { ttb, btt, ltr, rtl }

// StatefulWidget to handle the fade-in animation
class FadeInAnimation extends StatefulWidget {
  const FadeInAnimation(
      {super.key,
        required this.child,
        required this.delay,
        required this.direction,
        required this.fadeOffset});

  // The widget to be animated
  final Widget child;
  // Delay before the animation starts
  final double delay;
  // Offset distance for the animation
  final double fadeOffset;
  // Direction of the animation
  final FadeInDirection direction;

  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

// State class to manage the animation state
class _FadeInAnimationState extends State<FadeInAnimation>
    with TickerProviderStateMixin {
  // Animation controller to manage the animation timing
  late AnimationController controller;
  // Animation for the opacity transition
  late Animation<double> opacityAnimation;
  // Animation for the positional transition
  late Animation<double> inAnimation;

  @override
  void initState() {
    super.initState();

    // Initializing the animation controller with the specified delay
    controller = AnimationController(
        duration: Duration(milliseconds: (500 * widget.delay).round()),
        vsync: this);

    // Setting up the positional animation to move the widget from the offset to the final position
    inAnimation = Tween<double>(begin: -widget.fadeOffset, end: 0).animate(controller)
      ..addListener(() {
        // Updating the widget state whenever the animation value changes
        setState(() {});
      });

    // Setting up the opacity animation to fade in the widget
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        // Updating the widget state whenever the animation value changes
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    // Starting the animation
    controller.forward();
    return Transform.translate(
      // Determining the offset based on the direction of the animation
      offset: switch (widget.direction) {
        FadeInDirection.ltr => Offset(inAnimation.value, 0), // Left to Right
        FadeInDirection.rtl => Offset(-inAnimation.value, 0), // Right to Left
        FadeInDirection.ttb => Offset(0, inAnimation.value), // Top to Bottom
        FadeInDirection.btt => Offset(0, -inAnimation.value), // Bottom to Top
      },
      child: Opacity(
        // Applying the opacity animation to the child widget
        opacity: opacityAnimation.value,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    // Disposing the animation controller to free up resources
    controller.dispose();
    super.dispose();
  }
}
