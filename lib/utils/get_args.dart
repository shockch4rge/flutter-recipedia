import 'package:flutter/material.dart';

// helper function to receive args passed from previous screens
T getArgs<T>(BuildContext context) {
  return ModalRoute.of(context)!.settings.arguments as T;
}
