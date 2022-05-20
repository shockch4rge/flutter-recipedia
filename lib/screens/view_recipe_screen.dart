import 'package:flutter/material.dart';
import 'package:flutter_recipedia/widgets/view_recipe/snapping_app_bar.dart';

class ViewRecipeScreen extends StatefulWidget {
  const ViewRecipeScreen({Key? key}) : super(key: key);

  @override
  _ViewRecipeScreenState createState() => _ViewRecipeScreenState();
}

class _ViewRecipeScreenState extends State<ViewRecipeScreen> {
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
          physics: const BouncingScrollPhysics(),
          controller: _controller,
          slivers: [
            SnappingAppBar(maxHeight: maxHeight, minHeight: minHeight),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildCard(1),
                    _buildCard(1),
                    _buildCard(1),
                    _buildCard(1),
                    _buildCard(1),
                    _buildCard(1),
                    _buildCard(1),
                    _buildCard(1),
                    _buildCard(1),
                    _buildCard(1),
                    _buildCard(1),
                    _buildCard(1),
                    _buildCard(1),
                    _buildCard(1),
                    _buildCard(1),
                  ],
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
