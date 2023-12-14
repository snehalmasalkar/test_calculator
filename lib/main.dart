import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData.dark().copyWith(
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              surface: Colors.grey[900],
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
        ),
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '';
  String result = '';
  int _num1 = 0;
  int _num2 = 0;
  String history = '';
  String _operand = '';

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        // Clear button pressed
        _output = '';
        _num1 = 0;
        _num2 = 0;
        _operand = '';
        result = '';
        history = '';
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == '*' ||
          buttonText == '/') {
        // Operator button pressed
        _num1 = int.parse(_output);
        _operand = buttonText;
        result = '';
      } else if (buttonText == '=') {
        // Equals button pressed
        _num2 = int.parse(_output);
        if (_operand == '+') {
          result = (_num1 + _num2).toString();
          history = _num1.toString() + _operand.toString() + _num2.toString();
        }
        if (_operand == '-') {
          result = (_num1 - _num2).toString();
          history = _num1.toString() + _operand.toString() + _num2.toString();
        }
        if (_operand == '*') {
          result = (_num1 * _num2).toString();
          history = _num1.toString() + _operand.toString() + _num2.toString();
        }
        if (_operand == '/') {
          result = (_num1 / _num2).toString();
          history = _num1.toString() + _operand.toString() + _num2.toString();
        }
        _num1 = 0;
        _num2 = 0;
        _operand = '';
      } else {
        print('digit display');
        // Number button pressed
        result = (_output + buttonText).toString();
      }
      setState(() {
        _output = result;
      });
    });
  }

  Widget _buildButton(
    String buttonText,
    Color buttonColor,
    Color textColor,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: textColor,
            backgroundColor: buttonColor,
          ),
          onPressed: () {
            _buttonPressed(buttonText);
          },
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      children: buttons
          .map((button) => _buildButton(
                button,
                button == 'C' ? Colors.grey[700]! : Colors.grey[900]!,
                button == '=' ||
                        button == '/' ||
                        button == '*' ||
                        button == '-' ||
                        button == '+'
                    ? Colors.white
                    : Colors.amber,
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          Text(
            history,
            style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _output,
                style: const TextStyle(
                    fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Divider(height: 0.0),
          Column(
            children: [
              // Rows of buttons
              _buildButtonRow(['7', '8', '9', '/']),
              _buildButtonRow(['4', '5', '6', '*']),
              _buildButtonRow(['1', '2', '3', '-']),
              _buildButtonRow(['C', '0', '=', '+']),
            ],
          ),
        ],
      ),
    );
  }
}
