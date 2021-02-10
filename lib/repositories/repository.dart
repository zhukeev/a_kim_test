import '../model/flight.dart';

abstract class IFlightsRepository {
  Future<List<Flight>> fetchFlights(int page);
}
