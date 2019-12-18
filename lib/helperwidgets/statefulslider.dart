import 'package:flutter/material.dart';

class MoneySlider extends StatefulWidget {
  final int min;
  final int max;
  final TextEditingController controller = TextEditingController();
  MoneySlider(this.min, this.max);

  @override
  _MoneySliderState createState() => _MoneySliderState();
}

class _MoneySliderState extends State<MoneySlider> {
  int valueHolder;
  @override
  Widget build(BuildContext context) {
    if(valueHolder == null){
      valueHolder = widget.min;
    }
    widget.controller.text = '$valueHolder هزار تومان';
        
    return Center(
        child: Column(children: [
      Container(
          margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: Slider(
              value: valueHolder.toDouble(),
              min: widget.min.toDouble(),
              max: widget.max.toDouble(),
              divisions: 100,
              activeColor: Colors.green,
              inactiveColor: Colors.grey,
              label: '${valueHolder.round()}',
              onChanged: (double newValue) {
                setState(() {
                  valueHolder = newValue.round();
                });
              },
              semanticFormatterCallback: (double newValue) {
                return '${newValue.round()}';
              })),
      TextField(
        controller: widget.controller,
      )
    ]));
  }
}
