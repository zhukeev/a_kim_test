import 'package:flutter/material.dart';

class TButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String subtitle;

  const TButton(
      {Key key,
      @required this.onPressed,
      @required this.title,
      @required this.subtitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        height: 52,
        color: Colors.white10,
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: onPressed,
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ));
  }
}
