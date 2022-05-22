import 'package:flutter/material.dart';

T getArgs<T>(BuildContext context) {
  return ModalRoute.of(context)!.settings.arguments as T;
}
