import 'package:flutter/material.dart';

extension ExtBox on num {
  SizedBox get SH => SizedBox(height: toDouble());
  SizedBox get SW => SizedBox(width: toDouble());
}
