import 'package:flutter/material.dart';

class DurationSelector extends StatefulWidget {
  @override
  _DurationSelectorState createState() => _DurationSelectorState();
}

class _DurationSelectorState extends State<DurationSelector> {
  List<int> durationsInMinutes = List.generate(20, (index) => (index + 1) * 15);

  int selectedDuration = 15;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: selectedDuration,
      items: durationsInMinutes.map((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text('${value ~/ 60} horas ${value % 60} minutos'),
        );
      }).toList(),
      onChanged: (int? newValue) {
        if (newValue != null) {
          setState(() {
            selectedDuration = newValue;
          });
        }
      },
    );
  }
}
