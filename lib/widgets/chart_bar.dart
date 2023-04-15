import 'package:flutter/material.dart';

class Chartbar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double SpendingPercentOfTotal;

  Chartbar(this.label, this.spendingAmount, this.SpendingPercentOfTotal);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint){
        return Column(
      children: [
        Container(
          height:constraint.maxHeight * 0.15,
          child: FittedBox(
            child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: constraint.maxHeight * 0.6,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: SpendingPercentOfTotal >= 0? SpendingPercentOfTotal: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: constraint.maxHeight * 0.05,
        ),
        Container(
          height: constraint.maxHeight * 0.1,
          child: FittedBox(child: Text(label))),
      ],
    );
    },); 
  }
}
