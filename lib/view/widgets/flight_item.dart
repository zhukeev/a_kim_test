import 'package:a_kim_test/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/flight.dart';
import '../../util/duration_formatter.dart';

class FlightItem extends StatelessWidget {
  final Flight flight;
  final VoidCallback onPressed;
  const FlightItem({Key key, @required this.flight, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dateTimeFrom = DateTime.fromMillisecondsSinceEpoch(flight.timeFrom);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitle(textTheme),
                SizedBox(height: 8),
                Text(
                    '${DateFormat.Hm().format(dateTimeFrom)} - ${DateFormat.Hm().format(dateTimeFrom.add(Duration(seconds: flight.duration)))}'),
                SizedBox(height: 8),
                Text(
                  formatDuration(Duration(seconds: flight.duration)),
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset(Assets.image1),
                    SizedBox(width: 8),
                    Text(
                      'Nonstop • 8h'.toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.w700),
                    )
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('\$${flight.price}',
                    style: Theme.of(context).textTheme.headline5),
                SizedBox(height: 8),
                Text(
                  '\$${flight.discount} less than usual',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: flight.tip.color,
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    flight.tip.name,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  RichText buildTitle(TextTheme textTheme) {
    return RichText(
        text: TextSpan(
            text: flight?.name ?? '',
            style: textTheme.bodyText2.copyWith(fontWeight: FontWeight.w700),
            children: [
          TextSpan(text: " (${flight.abbr})", style: textTheme.bodyText2)
        ]));
  }
}
