import 'package:calculator_app/src/widgets/svg_icon_widget.dart';
import 'package:flutter/material.dart';

import '../models/symbols.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.isDarkMode,
    required this.expression,
    required this.symbol,
    required this.onPressed,
  });

  final bool isDarkMode;
  final String expression;
  final SymbolModel symbol;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    bool isNumber = symbol.type == SymbolType.number;
    bool isOperator = symbol.type == SymbolType.operator;

    if (symbol.name == 'clear') {
      String clearSymbolName = Symbols.clearSymbolName(expression);

      return IconButton(
        onPressed: onPressed,
        icon: Text(clearSymbolName, style: AppStyles.clearTextStyle(context)),
      );
    }

    return isNumber
        ? IconButton(
          onPressed: onPressed,
          icon: Text(
            symbol.name,
            style: AppStyles.textStyle(isDarkMode, context),
          ),
        )
        : SvgIconWidget(
          scale: 0.75,
          color: isOperator ? AppColors.iconSecondary : AppColors.iconPrimary,
          assetName: symbol.assetName(),
          onPressed: onPressed,
        );
  }
}
