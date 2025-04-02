
import 'package:calculator_app/lib/src/models/symbols.dart';
import 'package:calculator_app/lib/src/utils/services/calculator_service.dart';

class KeyboardService {
  String inputNumber(String expression, String number) {
    if (number == '.' && expression.isEmpty) {
      return '0.';
    } else {
      return expression + number;
    }
  }

  String handlerFunction(String expression, String function) {
    if (function == 'clear') {
      return '';
    } else if (function == 'delete') {
      return expression.substring(0, expression.length - 1);
    } else if (function == 'percentage') {
      return Calculate().percentageFunction(expression);
    } else {
      return expression;
    }
  }

  String handlerOperation(
    String expression,
    SymbolModel operation, {
    String result = '',
  }) {
    if (expression.isEmpty) {
      return '';
    } else if (operation.name == 'equal') {
      return result;
    } else {
      return expression + operation.textName();
    }
  }
}
