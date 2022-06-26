import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_recipedia/features/recipes/app/create_recipe_provider.dart';
import 'package:flutter_recipedia/features/recipes/ui/create_recipe/widgets/add_ingredient_dialog.dart';
import 'package:flutter_recipedia/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import 'recipe_image_input.dart';

class CreateRecipeForm extends StatefulWidget {
  const CreateRecipeForm({Key? key}) : super(key: key);

  @override
  State<CreateRecipeForm> createState() => _CreateRecipeFormState();
}

class _CreateRecipeFormState extends State<CreateRecipeForm> with RouteAware {
  final _formKey =
      GlobalKey<FormBuilderState>(debugLabel: "create_recipe_form");

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      autoFocusOnValidationFailure: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                RecipeImageInput(),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  name: "recipe_name",
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: "Give your recipe a title...",
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(
                      10,
                      allowEmpty: false,
                      errorText: "Title must be at least 3 characters long",
                    )
                  ]),
                ),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  name: "recipe_description",
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: "Describe your recipe...",
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(
                      10,
                      allowEmpty: false,
                      errorText:
                          "Description must be at least 10 characters long",
                    ),
                  ]),
                  minLines: 2,
                  maxLines: 10,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Ingredients",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ),
          SliverReorderableList(
            itemBuilder: (_, index) {
              final ingredient =
                  context.read<CreateRecipeProvider>().addedIngredients[index];
              return ListTile(
                key: ValueKey(ingredient),
                title: Text(
                  context.read<CreateRecipeProvider>().addedIngredients[index],
                ),
                trailing: ReorderableDragStartListener(
                  index: index,
                  child: Icon(FontAwesomeIcons.burger),
                ),
                style: ListTileStyle.drawer,
              );
            },
            onReorder: (oldIndex, newIndex) {
              context
                  .read<CreateRecipeProvider>()
                  .reorderIngredient(oldIndex, newIndex);
            },
            itemCount:
                context.read<CreateRecipeProvider>().addedIngredients.length,
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width / 2.5,
            ),
            sliver: SliverToBoxAdapter(
              child: ElevatedButton.icon(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => AddIngredientDialog(),
                ),
                icon: const Icon(FontAwesomeIcons.plus),
                label: Text("Add ingredient"),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      // child: Padding(
      //   padding: const EdgeInsets.all(24),
      //   child: Column(
      //     children: [
      //       RecipeImageInput(),
      //       const SizedBox(height: 20),
      //       FormBuilderTextField(
      //         name: "recipe_name",
      //         decoration: const InputDecoration(
      //           border: OutlineInputBorder(),
      //           floatingLabelBehavior: FloatingLabelBehavior.never,
      //           labelText: "Give your recipe a title...",
      //         ),
      //         validator: FormBuilderValidators.compose([
      //           FormBuilderValidators.required(),
      //           FormBuilderValidators.minLength(
      //             10,
      //             allowEmpty: false,
      //             errorText: "Title must be at least 3 characters long",
      //           )
      //         ]),
      //       ),
      //       const SizedBox(height: 20),
      //       FormBuilderTextField(
      //         name: "recipe_description",
      //         decoration: const InputDecoration(
      //           border: OutlineInputBorder(),
      //           floatingLabelBehavior: FloatingLabelBehavior.never,
      //           labelText: "Describe your recipe...",
      //         ),
      //         validator: FormBuilderValidators.compose([
      //           FormBuilderValidators.required(),
      //           FormBuilderValidators.minLength(
      //             10,
      //             allowEmpty: false,
      //             errorText: "Description must be at least 10 characters long",
      //           ),
      //         ]),
      //         minLines: 2,
      //         maxLines: 10,
      //       ),
      //       const SizedBox(height: 20),
      //       Align(
      //         alignment: Alignment.centerLeft,
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(
      //               "Ingredients",
      //               style: Theme.of(context).textTheme.headline3,
      //             ),
      //             Wrap(
      //               runSpacing: 4,
      //               children: _ingredients.mapIndexed((index, ingredient) {
      //                 return Text(ingredient);
      //               }).toList(),
      //             ),
      //             const SizedBox(height: 10),
      //             ElevatedButton.icon(
      //               onPressed: () {},
      //               icon: Icon(FontAwesomeIcons.plus),
      //               label: Text("Add ingredient"),
      //               style: ElevatedButton.styleFrom(
      //                 primary: Theme.of(context).primaryColor,
      //               ),
      //             )
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }

  @override
  void didPop() {
    context.read<CreateRecipeProvider>().reset();
    super.didPop();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
