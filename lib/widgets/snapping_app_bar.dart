import 'package:flutter/material.dart';

class SnappingAppBar extends StatefulWidget {
  const SnappingAppBar({Key? key}) : super(key: key);

  @override
  _SnappingAppBarState createState() => _SnappingAppBarState();
}

class _SnappingAppBarState extends State<SnappingAppBar> {
  final _controller = ScrollController();

  double get minHeight => kToolbarHeight + MediaQuery.of(context).padding.top;
  double get maxHeight => 200 + MediaQuery.of(context).padding.top;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (_) {
          _snapAppbar();
          return false;
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _controller,
          slivers: [
            SliverAppBar(
              pinned: true,
              stretch: true,
              flexibleSpace: Header(
                maxHeight: maxHeight,
                minHeight: minHeight,
              ),
              expandedHeight: maxHeight - MediaQuery.of(context).padding.top,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _buildCard(index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card _buildCard(int index) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Text("Item $index"),
      ),
    );
  }

  void _snapAppbar() {
    final scrollDistance = maxHeight - minHeight;

    if (_controller.offset > 0 && _controller.offset < scrollDistance) {
      final double snapOffset =
          _controller.offset / scrollDistance > 0.5 ? scrollDistance : 0;

      Future.microtask(
        () => _controller.animateTo(snapOffset,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutCubicEmphasized),
      );
    }
  }
}

class Header extends StatelessWidget {
  final double maxHeight;
  final double minHeight;

  const Header({Key? key, required this.maxHeight, required this.minHeight})
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
