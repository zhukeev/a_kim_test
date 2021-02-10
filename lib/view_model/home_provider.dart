import 'package:flutter/material.dart';

import '../model/flight.dart';
import '../repositories/repository.dart';

class HomeProvider extends ChangeNotifier {
  final IFlightsRepository repository;

  HomeProvider(this.repository);

  Future<List<Flight>> fetchFlights(int pageKey) {
    final res = repository.fetchFlights(pageKey);

    return res;
  }
}
