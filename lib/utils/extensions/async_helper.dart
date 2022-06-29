import 'package:flutter/material.dart';

// this extensions helps us to avoid some boilerplate when it comes to checking Future states.
extension SnapshotHelpers on AsyncSnapshot {
  bool get waiting => connectionState == ConnectionState.waiting;
  bool get done => connectionState == ConnectionState.done;
}
