import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIconWidget extends StatelessWidget {
  const SvgIconWidget({
    super.key,
    required this.color,
    required this.scale,
    required this.assetName,
    required this.onPressed,
  });

  final Color color;
  final double scale;
  final String assetName;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Transform.scale(
        scale: scale,
        child: SvgPicture.asset(
          assetName,
          height: MediaQuery.of(context).size.height * 0.025,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
    );
  }
}
