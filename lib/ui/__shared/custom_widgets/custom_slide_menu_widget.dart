import 'package:flutter/material.dart';

class CustomSlideMenu extends StatefulWidget {
  final Widget child;
  final List<Widget> menuItems;

  const CustomSlideMenu({
    Key? key,
    required this.child,
    required this.menuItems,
  }) : super(key: key);

  @override
  State<CustomSlideMenu> createState() => _CustomSlideMenuState();
}

class _CustomSlideMenuState extends State<CustomSlideMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = Tween(begin: const Offset(0.0, 0.0), end: const Offset(-0.2, 0.0))
        .animate(CurveTween(curve: Curves.decelerate).animate(_controller));

    return GestureDetector(
      onHorizontalDragUpdate: (data) {
        setState(() {
          _controller.value -= (data.primaryDelta! / (context.size!.width * 0.2));
        });
      },
      onHorizontalDragEnd: (data) {
        if (data.primaryVelocity! > 1500) {
          _controller.animateTo(.0);
        } else if (_controller.value >= .5 || data.primaryVelocity! < -1500) {
          _controller.animateTo(1.0);
        } else {
          _controller.animateTo(.0);
        }
      },
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Stack(
            children: [
              SlideTransition(
                position: animation,
                child: widget.child,
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Positioned(
                    right: .0,
                    top: .0,
                    bottom: .0,
                    width: constraint.maxWidth * animation.value.dx * -1,
                    child: Row(
                      children: widget.menuItems.map((child) {
                        return Expanded(
                          child: child,
                        );
                      }).toList(),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
