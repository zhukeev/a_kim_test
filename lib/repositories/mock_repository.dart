import 'dart:math';

import '../model/flight.dart';
import 'repository.dart';

class MockRepoistory extends IFlightsRepository {
  @override
  Future<List<Flight>> fetchFlights(int page) async {
    final json = '''{
  "name": "San Francisco",
  "abbr": "SFO",
  "time_from": 1612789865,
  "time_from": 1612889865,
  "duration": 7600,
  "stops_type": "nonstop",
  "price": 100.0,
  "discount": 80,
  "tip": 0
}''';

    await Future.delayed(Duration(seconds: 2));

    return page > 3
        ? []
        : List.generate(
            10,
            (index) => flightFromJson(json).copyWith(
                price: Random().nextInt(1000).toDouble(),
                discount: Random().nextInt(80 - 20) + 20,
                tip:
                    Tip.values.elementAt(Random().nextInt(Tip.values.length))));
  }
}
