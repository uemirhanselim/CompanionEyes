import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatelessWidget {
  const SvgImage({super.key, this.assetName});
  final String? assetName; 
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(assetName!);
  }
}