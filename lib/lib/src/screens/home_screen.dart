import 'package:calculator_app/lib/src/models/symbols.dart';
import 'package:calculator_app/lib/src/widgets/switch_theme_button.dart';
import 'package:flutter/material.dart';
import '../utils/services/calculator_service.dart';
import '../utils/services/keyboard_service.dart';
import '../utils/styles.dart';
import '../widgets/button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDarkMode = false;

  String _expression = '';

  String _result = '';

  void handleOperatorInput(SymbolModel symbol) {
    setState(() {
      _expression = KeyboardService().handlerOperation(
        _expression,
        symbol,
        result: _result,
      );
    });

    _calculate();
  }

  void handlerNumberInput(SymbolModel number) {
    setState(() {
      _expression = KeyboardService().inputNumber(_expression, number.name);
    });

    _calculate();
  }

  void handlerFunction(SymbolModel function) {
    setState(() {
      _expression = KeyboardService().handlerFunction(
        _expression,
        function.name,
      );
    });

    _calculate();
  }

  void _calculate() {
    setState(() {
      _result = Calculate().calculate(_expression);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: isDarkMode ? Color(0xff000000) : Color(0xfff8f9fa),
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SwitchThemeButton(
              isDarkMode: isDarkMode,
              onLightModePressed:
                  () => setState(() {
                    isDarkMode = false;
                  }),
              onDarkModePressed:
                  () => setState(() {
                    isDarkMode = true;
                  }),
            ),
            _displayView(context),
            _keyboard(),
          ],
        ),
      ),
    );
  }

  Flexible _displayView(BuildContext context) {
    return Flexible(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.only(right: 36, bottom: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (_expression.isEmpty)
              FittedBox(
                child: Text(
                  '0',
                  style: AppStyles.displayTextStyle(isDarkMode, context),
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: FittedBox(
                      child: RichText(
                        text: TextSpan(
                          children:
                              CalculateHelper()
                                  .splitExpression(_expression)
                                  .map((symbol) {
                                    if (CalculateHelper().isContainsOperator(
                                      symbol,
                                    )) {
                                      return TextSpan(
                                        text: symbol,
                                        style: AppStyles.displayIconStyle(
                                          context,
                                        ),
                                      );
                                    }

                                    return TextSpan(
                                      text: symbol,
                                      style: AppStyles.displayTextStyle(
                                        isDarkMode,
                                        context,
                                      ),
                                    );
                                  })
                                  .toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '= $_result',
                    style: AppStyles.displaySubTextStyle(isDarkMode, context),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _keyboard() {
    return Flexible(
      flex: 10,
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Color(0xff212529) : Color(0xffe9ecef),
          borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _rowWidget(Symbols.firstRow),
            _rowWidget(Symbols.secondRow),
            _rowWidget(Symbols.thirdRow),
            _rowWidget(Symbols.fourthRow),
            _rowWidget(Symbols.fifthRow),
          ],
        ),
      ),
    );
  }

  _rowWidget(List<SymbolModel> symbols) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children:
          symbols.map((symbol) {
            return Flexible(
              child: Center(
                child: ButtonWidget(
                  isDarkMode: isDarkMode,
                  expression: _expression,
                  symbol: symbol,
                  onPressed: () {
                    if (symbol.type == SymbolType.number) {
                      handlerNumberInput(symbol);
                    } else if (symbol.type == SymbolType.operator) {
                      handleOperatorInput(symbol);
                    } else {
                      handlerFunction(symbol);
                    }
                  },
                ),
              ),
            );
          }).toList(),
    );
  }
}
