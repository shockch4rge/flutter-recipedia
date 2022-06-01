import 'package:flutter/material.dart';

class ExpandableContainer extends StatefulWidget {
  final double width;
  final double height;

  const ExpandableContainer(
      {Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  State<ExpandableContainer> createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  bool isPressed = false;
  final expandFactor = 1.2;

  double get expandedWidth => widget.width * expandFactor;
  double get expandedHeight => widget.height * expandFactor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        print("Hello tap down $expandedHeight $expandedWidth");
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (details) {
        print("Hello tap up $expandedHeight $expandedWidth");
        setState(() {
          isPressed = false;
        });
      },
      child: AnimatedPhysicalModel(
        color: Colors.black,
        shadowColor: Colors.black,
        shape: BoxShape.rectangle,
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
        elevation: isPressed ? 8.0 : 0,
        borderRadius: BorderRadius.circular(6),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          decoration: BoxDecoration(
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/post_placeholder.jpg"),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
