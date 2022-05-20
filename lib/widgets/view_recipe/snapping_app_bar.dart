import 'package:flutter/material.dart';

class SnappingAppBar extends StatelessWidget {
  final double maxHeight;
  final double minHeight;

  const SnappingAppBar(
      {Key? key, required this.maxHeight, required this.minHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      flexibleSpace: SnappingAppBarSpacer(
        maxHeight: maxHeight,
        minHeight: minHeight,
      ),
      expandedHeight: maxHeight - MediaQuery.of(context).padding.top,
    );
  }
}

class SnappingAppBarSpacer extends StatelessWidget {
  final double maxHeight;
  final double minHeight;

  const SnappingAppBarSpacer(
      {Key? key, required this.maxHeight, required this.minHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final expandRatio = _calculateExpandRatio(constraints);
        final animation = AlwaysStoppedAnimation(expandRatio);

        return Stack(
          fit: StackFit.expand,
          children: [
            _buildImage(),
            _buildGradient(animation),
            _buildTitle(animation),
          ],
        );
      },
    );
  }

  double _calculateExpandRatio(BoxConstraints constraints) {
    var expandRatio =
        (constraints.maxHeight - minHeight) / (maxHeight - minHeight);
    if (expandRatio > 1.0) expandRatio = 1.0;
    if (expandRatio < 0.0) expandRatio = 0.0;
    return expandRatio;
  }

  Align _buildTitle(Animation<double> animation) {
    return Align(
      alignment: AlignmentTween(
              begin: Alignment.bottomCenter, end: Alignment.bottomLeft)
          .evaluate(animation),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.only(bottom: 12, left: 12),
        child: Text(
          "Neapolitan Pizza",
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
            fontSize: Tween<double>(
              begin: 18,
              end: 28,
            ).evaluate(animation),
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Container _buildGradient(Animation<double> animation) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            ColorTween(
              begin: Colors.black87,
              end: Colors.black38,
            ).evaluate(animation)!,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Image _buildImage() {
    return Image.asset(
      "assets/images/post_placeholder.jpg",
      fit: BoxFit.cover,
    );
  }
}
