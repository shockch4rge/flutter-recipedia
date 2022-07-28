import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_recipedia/common/keep_alive_stateful.dart';
import 'package:flutter_recipedia/common/snack.dart';
import 'package:flutter_recipedia/features/recipes/app/create_recipe_provider.dart';
import 'package:flutter_recipedia/features/recipes/ui/create_recipe/widgets/create_recipe_app_bar.dart';
import 'package:flutter_recipedia/features/recipes/ui/create_recipe/widgets/reset_recipe_dialog.dart';
import 'package:flutter_recipedia/main.dart';
import 'package:flutter_recipedia/repositories/recipe_repository.dart';
import 'package:flutter_recipedia/utils/mock_data.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import 'widgets/add_ingredient_dialog.dart';
import 'widgets/add_step_dialog.dart';
import 'widgets/recipe_image_input.dart';

class CreateRecipeScreen extends KeepAliveStateful {
  static const routeName = "/create-recipe";

  const CreateRecipeScreen({Key? key}) : super(key: key);

  @override
  KeepAliveState createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends KeepAliveState with RouteAware {
  final _formKey =
      GlobalKey<FormBuilderState>(debugLabel: "create_recipe_form");

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CreateRecipeAppBar(
        onResetPressed: () {
          showDialog(
            context: context,
            builder: (_) => ResetRecipeDialog(
              onConfirm: () {
                _resetForms();
                Navigator.of(context).pop();
              },
            ),
          );
        },
      ),
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
                itemBuilder: (_, index) {
                  final ingredient =
                      context.read<CreateRecipeProvider>().ingredients[index];
                  return Slidable(
                    key: ValueKey(ingredient),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(
                        onDismissed: () {
                          context
                              .read<CreateRecipeProvider>()
                              .removeIngredient(index);
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
                          context
                              .read<CreateRecipeProvider>()
                              .ingredients[index],
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
                  context
                      .read<CreateRecipeProvider>()
                      .reorderIngredient(oldIndex, newIndex);
                },
                itemCount:
                    context.watch<CreateRecipeProvider>().ingredients.length,
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
                itemBuilder: (_, index) {
                  final step =
                      context.read<CreateRecipeProvider>().steps[index];
                  return Slidable(
                    key: ValueKey(step),
                    endActionPane: ActionPane(
                      motion: const StretchMotion(),
                      dismissible: DismissiblePane(
                        onDismissed: () {
                          context
                              .read<CreateRecipeProvider>()
                              .removeStep(index);
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
                          context.read<CreateRecipeProvider>().steps[index],
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
                  context
                      .read<CreateRecipeProvider>()
                      .reorderStep(oldIndex, newIndex);
                },
                itemCount: context.watch<CreateRecipeProvider>().steps.length,
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
                      initialValue: "",
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
                    _formKey.currentState!.save();
                    final canPostRecipe = _validateForms();

                    if (!canPostRecipe) {
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

                    final provider = context.read<CreateRecipeProvider>();
                    final title =
                        _formKey.currentState!.fields["title"]!.value as String;
                    final description = _formKey
                        .currentState!.fields["description"]!.value as String;
                    final notes =
                        _formKey.currentState!.fields["notes"] as String;

                    await context.read<RecipeRepository>().addRecipe(
                          authorId: mockMeId,
                          title: title,
                          description: description,
                          ingredients: provider.ingredients,
                          steps: provider.steps,
                          image: context
                              .read<CreateRecipeProvider>()
                              .uploadedImage!,
                          notes: notes,
                        );
                    print(_formKey.currentState!.value);
                  },
                  child: const Text("Post Recipe"),
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

  bool _validateForms() {
    final provider = context.read<CreateRecipeProvider>();
    return provider.ingredients.isNotEmpty &&
        provider.steps.isNotEmpty &&
        provider.uploadedImage != null &&
        _formKey.currentState!.validate();
  }

  void _resetForms() {
    _formKey.currentState!.reset();
    context.read<CreateRecipeProvider>().reset();
  }

  @override
  void didPop() {
    _formKey.currentState?.save();
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
