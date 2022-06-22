import 'package:flutter/material.dart';

extension SnapshotHelpers on AsyncSnapshot {
  bool get waiting => connectionState == ConnectionState.waiting;
  bool get done => connectionState == ConnectionState.done;
}
