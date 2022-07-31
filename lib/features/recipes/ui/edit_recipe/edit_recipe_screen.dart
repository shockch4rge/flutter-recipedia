import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_recipedia/common/snack.dart';
import 'package:flutter_recipedia/features/recipes/app/create_recipe_provider.dart';
import 'package:flutter_recipedia/features/recipes/ui/edit_recipe/widgets/edit_recipe_app_bar.dart';
import 'package:flutter_recipedia/models/recipe.dart';
import 'package:flutter_recipedia/providers/auth_provider.dart';
import 'package:flutter_recipedia/repositories/recipe_repository.dart';
import 'package:flutter_recipedia/utils/get_args.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../../app/edit_recipe_provider.dart';
import '../create_recipe/widgets/add_ingredient_dialog.dart';
import '../create_recipe/widgets/add_step_dialog.dart';
import '../create_recipe/widgets/recipe_image_input.dart';

class EditRecipeScreen extends StatefulWidget {
  static const routeName = "/create-recipe";

  const EditRecipeScreen({Key? key}) : super(key: key);

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final user = context.read<AuthProvider>().user!;
  late final editRecipeProvider = context.read<EditRecipeProvider>();
  late final recipe = getArgs<Recipe>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EditRecipeAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: FormBuilder(
          key: _formKey,
          autoFocusOnValidationFailure: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const RecipeImageInput(),
                    const SizedBox(height: 20),
                    FormBuilderTextField(
                      name: "title",
                      initialValue: recipe.title,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: "Give your recipe a title...",
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(
                          3,
                          allowEmpty: false,
                          errorText: "Title must be at least 3 characters long",
                        ),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    FormBuilderTextField(
                      name: "description",
                      initialValue: recipe.description,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                    const SizedBox(height: 40),
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
              const SliverToBoxAdapter(
                child: SizedBox(height: 10),
              ),
              SliverReorderableList(
                itemCount:
                    context.watch<EditRecipeProvider>().ingredients.length,
                itemBuilder: (_, index) {
                  final ingredient = editRecipeProvider.ingredients[index];
                  return Slidable(
                    key: ValueKey(ingredient),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(
                        onDismissed: () {
                          editRecipeProvider.removeIngredient(index);
                        },
                      ),
                      children: [
                        SlidableAction(
                          onPressed: (_) {},
                          icon: FontAwesomeIcons.trash,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                        )
                      ],
                    ),
                    child: Material(
                      child: ListTile(
                        title: Text(
                          ingredient,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: ReorderableDragStartListener(
                          index: index,
                          child: const Icon(
                            FontAwesomeIcons.bars,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                onReorder: (oldIndex, newIndex) {
                  editRecipeProvider.reorderIngredient(oldIndex, newIndex);
                },
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
              SliverToBoxAdapter(
                child: ElevatedButton.icon(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => const AddIngredientDialog(),
                  ),
                  icon: const Icon(FontAwesomeIcons.plus),
                  label: const Text("Add Ingredient"),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    onPrimary: Colors.grey,
                    primary: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 40),
              ),
              SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Directions",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 10),
              ),
              SliverReorderableList(
                itemCount: context.watch<EditRecipeProvider>().steps.length,
                itemBuilder: (_, index) {
                  final step = editRecipeProvider.steps[index];
                  return Slidable(
                    key: ValueKey(step),
                    endActionPane: ActionPane(
                      motion: const StretchMotion(),
                      dismissible: DismissiblePane(
                        onDismissed: () {
                          editRecipeProvider.removeStep(index);
                        },
                      ),
                      children: [
                        SlidableAction(
                          onPressed: (_) {
                            context
                                .read<CreateRecipeProvider>()
                                .removeStep(index);
                          },
                          icon: FontAwesomeIcons.trash,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                        )
                      ],
                    ),
                    child: Material(
                      child: ListTile(
                        title: Text("Step ${index + 1}"),
                        subtitle: Text(
                          step,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: ReorderableDragStartListener(
                          index: index,
                          child: const Icon(
                            FontAwesomeIcons.bars,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                onReorder: (oldIndex, newIndex) {
                  editRecipeProvider.reorderStep(oldIndex, newIndex);
                },
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
              SliverToBoxAdapter(
                child: ElevatedButton.icon(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => const AddStepDialog(),
                  ),
                  icon: const Icon(FontAwesomeIcons.plus),
                  label: const Text("Add Direction"),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    onPrimary: Colors.grey,
                    primary: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 40),
              ),
              SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Notes",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    FormBuilderTextField(
                      name: "notes",
                      minLines: 3,
                      maxLines: 6,
                      initialValue: recipe.notes,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.saveAndValidate()) {
                      Snack.bad(
                        context,
                        "Check invalid fields!",
                        SnackBarAction(
                          label: "Dismiss",
                          textColor: Colors.white,
                          onPressed: () {},
                        ),
                      );
                      return;
                    }

                    final title =
                        _formKey.currentState!.fields["title"]!.value as String;
                    final description = _formKey
                        .currentState!.fields["description"]!.value as String;
                    final notes =
                        _formKey.currentState!.fields["notes"] as String;

                    await context.read<RecipeRepository>().editRecipe(
                          authorId: user.id,
                          title: title,
                          description: description,
                          ingredients: editRecipeProvider.ingredients,
                          steps: editRecipeProvider.steps,
                          image: editRecipeProvider.uploadedImage!,
                          notes: notes,
                        );
                  },
                  child: const Text("Save Changes"),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColorDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(20),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
