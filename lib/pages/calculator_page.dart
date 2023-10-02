import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = '';
  String _currentValue = '';
  double _result = 0;
  String _operator = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _display = '';
        _currentValue = '';
        _result = 0;
        _operator = '';
      } else if (buttonText == '=') {
        switch (_operator) {
          case '+':
            _result = int.parse(_currentValue) + _result;
            break;
          case '-':
            _result = _result - int.parse(_currentValue);
            break;
          case '*':
            _result = _result * int.parse(_currentValue);
            break;
          case '/':
            _result = (_result / double.parse(_currentValue));
            break;
        }
        _display = _result.toString();
        _currentValue = '';
        _operator = '';
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == '*' ||
          buttonText == '/') {
        if (_currentValue.isNotEmpty) {
          _operator = buttonText;
          _result = double.parse(_currentValue);
          _currentValue = '';
        }
      } else {
        _currentValue += buttonText;
      }
      _display = _currentValue.isNotEmpty ? _currentValue : _result.toString();
    });
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          _onButtonPressed(buttonText);
        },
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 50.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.bottomRight,
            child: Text(
              _display,
              style:
                  const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 15,
              ),
              _buildButton('7'),
              const SizedBox(
                width: 15,
              ),
              _buildButton('8'),
              const SizedBox(
                width: 15,
              ),
              _buildButton('9'),
              const SizedBox(
                width: 15,
              ),
              _buildButton('/'),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 15,
              ),
              _buildButton('4'),
              const SizedBox(
                width: 15,
              ),
              _buildButton('5'),
              const SizedBox(
                width: 15,
              ),
              _buildButton('6'),
              const SizedBox(
                width: 15,
              ),
              _buildButton('*'),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 15,
              ),
              _buildButton('1'),
              const SizedBox(
                width: 15,
              ),
              _buildButton('2'),
              const SizedBox(
                width: 15,
              ),
              _buildButton('3'),
              const SizedBox(
                width: 15,
              ),
              _buildButton('-'),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 15,
              ),
              _buildButton('0'),
              const SizedBox(
                width: 15,
              ),
              _buildButton('C'),
              const SizedBox(
                width: 15,
              ),
              _buildButton('='),
              const SizedBox(
                width: 15,
              ),
              _buildButton('+'),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
