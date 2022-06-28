import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_recipedia/features/recipes/app/create_recipe_provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class AddStepDialog extends StatefulWidget {
  const AddStepDialog({Key? key}) : super(key: key);

  @override
  State<AddStepDialog> createState() => _AddStepDialogState();
}

class _AddStepDialogState extends State<AddStepDialog> {
  final _stepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Step"),
      content: FormBuilderTextField(
        name: "step_name",
        controller: _stepController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey[400]),
          hintText: "e.g. Add salt to soup",
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        minLines: 2,
        maxLines: 6,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(
            errorText: "Direction cannot be empty.",
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
            context.read<CreateRecipeProvider>().addStep(_stepController.text);
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
    _stepController.dispose();
    super.dispose();
  }
}
