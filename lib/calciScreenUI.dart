import 'package:flutter/material.dart';


class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = "0";

  double firstNumber = 0;
  String operation = "";
  bool isNewInput = true;

  void onButtonClick(String value) {
    setState(() {
      //when pressed  Clear
      if (value == "C") {
        display = "0";
        firstNumber = 0;
        operation = "";
        isNewInput = true;
        return;
      }

      // when pressed Equal
      if (value == "=") {
        double secondNumber = double.tryParse(display) ?? 0;
        double result = 0;

        if (operation == "+") result = firstNumber + secondNumber;
        if (operation == "-") result = firstNumber - secondNumber;
        if (operation == "×") result = firstNumber * secondNumber;
        if (operation == "÷") result = (secondNumber != 0) ? firstNumber / secondNumber : 0;

        display = result.toString();
        isNewInput = true;
        operation = "";
        return;
      }

      // when pressed Operators
      if (value == "+" || value == "-" || value == "×" || value == "÷") {
        firstNumber = double.tryParse(display) ?? 0;
        operation = value;
        isNewInput = true;
        return;
      }

      // Dot
      if (value == ".") {
        if (!display.contains(".")) {
          display = isNewInput ? "0." : display + ".";
          isNewInput = false;
        }
        return;
      }

      // Add Numbers
      if (isNewInput) {
        display = value;
        isNewInput = false;
      } else {
        display = display == "0" ? value : display + value;
      }
    });
  }


  Widget calcButton(String text, {Color bgColor = Colors.grey}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            padding: const EdgeInsets.symmetric(vertical: 22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Calculator",style: TextStyle(
          color: Colors.white
        ),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Display
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Text(
                display,
                style: const TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Buttons
          Row(
            children: [
              calcButton("7"),
              calcButton("8"),
              calcButton("9"),
              calcButton("÷", bgColor: Colors.orange),
            ],
          ),
          Row(
            children: [
              calcButton("4"),
              calcButton("5"),
              calcButton("6"),
              calcButton("×", bgColor: Colors.orange),
            ],
          ),
          Row(
            children: [
              calcButton("1"),
              calcButton("2"),
              calcButton("3"),
              calcButton("-", bgColor: Colors.orange),
            ],
          ),
          Row(
            children: [
              calcButton("C", bgColor: Colors.red),
              calcButton("0"),
              calcButton(".", bgColor: Colors.grey.shade700),
              calcButton("+", bgColor: Colors.orange),
            ],
          ),
          Row(
            children: [
              calcButton("=", bgColor: Colors.green),
            ],
          ),
        ],
      ),
    );
  }
}