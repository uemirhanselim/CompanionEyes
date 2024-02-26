import 'package:flutter/material.dart';

// --------------------- HEIGHT / WIDTH ---------------------

double getDynamicHeight(BuildContext context, double value) =>
    MediaQuery.sizeOf(context).height * value;

double getDynamicWidth(BuildContext context, double value) =>
    MediaQuery.sizeOf(context).width * value;

SizedBox emptySpaceHeight(BuildContext context, double value) =>
    SizedBox(height: MediaQuery.sizeOf(context).height * value);

SizedBox emptySpaceWidth(BuildContext context, double value) => SizedBox(
      width: MediaQuery.sizeOf(context).width * value,
    );
