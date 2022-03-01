import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfToal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfToal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(
            child: Text(
              '৳ ${spendingAmount.toStringAsFixed(0)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfToal,
                child: Container(
                  decoration: BoxDecoration(color: Color.fromRGBO(3, 75, 3, 1)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
