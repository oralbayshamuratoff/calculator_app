import 'package:calculator_app/lib/src/widgets/svg_icon_widget.dart';
import 'package:flutter/material.dart';

class SwitchThemeButton extends StatelessWidget {
  const SwitchThemeButton({
    super.key,
    required this.isDarkMode,
    required this.onLightModePressed,
    required this.onDarkModePressed,
  });

  final bool isDarkMode;
  final VoidCallback onLightModePressed;
  final VoidCallback onDarkModePressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          color: isDarkMode ? Color(0xff212529) : Color(0xffe9ecef),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgIconWidget(
              color: isDarkMode ? Colors.grey : Colors.black,
              scale: isDarkMode ? 0.7 : 0.8,
              assetName: 'assets/svgs/brightness.svg',
              onPressed: onLightModePressed,
            ),
            SvgIconWidget(
              color: isDarkMode ? Colors.white : Colors.grey,
              scale: isDarkMode ? 0.8 : 0.7,
              assetName: 'assets/svgs/moon.svg',
              onPressed: onDarkModePressed,
            ),
          ],
        ),
      ),
    );
  }
}
