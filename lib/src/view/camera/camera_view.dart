import 'package:auto_route/auto_route.dart';
import 'package:companioneyes/src/viewmodel/camera/camera_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CameraView extends StatelessWidget {
  const CameraView({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CameraViewModel(),
      child: const Scaffold(),
    );
  }
}
