import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_recipedia/features/recipes/app/create_recipe_provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class AddIngredientDialog extends StatefulWidget {
  const AddIngredientDialog({Key? key}) : super(key: key);

  @override
  State<AddIngredientDialog> createState() => _AddIngredientDialogState();
}

class _AddIngredientDialogState extends State<AddIngredientDialog> {
  // controllers to manage text field state
  final _ingredientController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Ingredient"),
      content: FormBuilderTextField(
        name: "ingredient_name",
        controller: _ingredientController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey[400]),
          hintText: "e.g. 1 tbsp olive oil",
        ),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(
            errorText: "Ingredient cannot be empty.",
          ),
        ]),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
          style: TextButton.styleFrom(
            primary: Colors.red,
          ),
        ),
        TextButton(
          onPressed: () async {
            context
                .read<CreateRecipeProvider>()
                .addIngredient(_ingredientController.text);
            Navigator.of(context).pop();
          },
          child: const Text("Add"),
          style: TextButton.styleFrom(
            primary: Theme.of(context).primaryColorDark,
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }
}
