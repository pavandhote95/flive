import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({Key? key, this.value = 0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Container(
          height:5,
          width:17,
          child: Icon(
            index < value ? Icons.star : Icons.star_border,color: Colors.amber,size:20,
          ),
        );
      }),
    );
  }
}