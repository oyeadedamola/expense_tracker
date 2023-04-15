import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class AdaptiveFlatButton extends StatelessWidget {
  // const AdaptiveFlatButton({super.key});

  final String text;
  final VoidCallback handler;
 
  AdaptiveFlatButton(this.text, this.handler);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ?
                    CupertinoButton(
                      child: Text(text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold),
                      ),
                        onPressed: handler,)
                     : 
                    TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          text,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: handler
                        );
  }
}