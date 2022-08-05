import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipedia/models/recipe.dart';

class ViewSearchedRecipeAppBar extends StatelessWidget {
  final double maxHeight;
  final double minHeight;
  final SpoonacularRecipe recipe;

  const ViewSearchedRecipeAppBar({
    Key? key,
    required this.recipe,
    required this.maxHeight,
    required this.minHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
        splashRadius: 20,
        icon: const Icon(Icons.arrow_back),
        tooltip: "Back",
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: _ViewRecipeAppBarSpacer(
        recipe: recipe,
        maxHeight: maxHeight,
        minHeight: minHeight,
      ),
      expandedHeight: maxHeight - MediaQuery.of(context).padding.top,
    );
  }
}

class _ViewRecipeAppBarSpacer extends StatelessWidget {
  final double maxHeight;
  final double minHeight;
  final SpoonacularRecipe recipe;

  const _ViewRecipeAppBarSpacer(
      {Key? key,
      required this.recipe,
      required this.maxHeight,
      required this.minHeight})
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
            _AppBarImage(imageUrl: recipe.imageUrl),
            _AppBarGradient(animation: animation),
            _AppBarTitle(animation: animation, recipe: recipe),
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
}

class _AppBarTitle extends StatelessWidget {
  final Animation<double> animation;
  final SpoonacularRecipe recipe;

  const _AppBarTitle({Key? key, required this.animation, required this.recipe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentTween(
              begin: Alignment.bottomCenter, end: Alignment.bottomLeft)
          .evaluate(animation),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.only(bottom: 12, left: 12),
        child: Text(
          recipe.name,
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
}

class _AppBarGradient extends StatelessWidget {
  final Animation<double> animation;

  const _AppBarGradient({Key? key, required this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            ColorTween(
              begin: Colors.black87,
              end: Colors.black45,
            ).evaluate(animation)!,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

class _AppBarImage extends StatelessWidget {
  final String imageUrl;

  const _AppBarImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
