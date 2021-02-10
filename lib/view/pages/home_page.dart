import 'package:flutter_svg/flutter_svg.dart';

import '../../model/flight.dart';
import '../../util/constants.dart';
import '../widgets/flight_item.dart';
import '../widgets/semi_transparent_button.dart';
import '../../view_model/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _pageSize = 10;

  final PagingController<int, Flight> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    if (mounted)
      _pagingController.addPageRequestListener((pageKey) {
        _fetchPage(pageKey);
      });
    _pagingController.refresh();
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await Provider.of<HomeProvider>(context, listen: false)
          .fetchFlights(pageKey);

      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(bottom: 30, left: 8, right: 8, top: 8),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Palette.blueRibbon, Palette.rose])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: statusBarHeight),
                  SizedBox(
                      height: kToolbarHeight,
                      child: IconButton(
                          icon: Icon(Icons.arrow_back), onPressed: () {})),
                  Text('FLIGHTS', style: Theme.of(context).textTheme.headline5),
                  SizedBox(height: 16),
                  buildSeatchField(context),
                  SizedBox(height: 12),
                  buildAirportNames(),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      buildDateTimePicker(context),
                      SizedBox(width: 10),
                      buildFilter1(context),
                      SizedBox(width: 10),
                      buildFilter2(context),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            buildSearchFilter(context),
            SizedBox(height: 16),
            Expanded(
              child: RefreshIndicator(
                  onRefresh: () async => Future.sync(() {
                        _pagingController.refresh();
                      }),
                  child: Stack(
                    children: [
                      PagedListView<int, Flight>(
                        pagingController: _pagingController,
                        padding: const EdgeInsets.all(8),
                        physics: BouncingScrollPhysics(),
                        builderDelegate: PagedChildBuilderDelegate(
                          noItemsFoundIndicatorBuilder: (_) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 16),
                              Text('Список пуст', textAlign: TextAlign.center),
                            ],
                          ),
                          itemBuilder:
                              (BuildContext context, Flight flight, int index) {
                            return FlightItem(
                              flight: flight,
                              onPressed: () {},
                            );
                          },
                        ),
                        shrinkWrap: true,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Colors.transparent,
                                Colors.black45
                              ])),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildFilter2(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 40,
        child: DropdownButtonFormField<String>(
          hint: Text('Round Trip'),
          iconSize: 20,
          style: Theme.of(context).textTheme.caption,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8),
              fillColor: Colors.white10,
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.transparent))),
          items: <String>['Round Trip', 'Another']
              .map((e) => DropdownMenuItem<String>(child: Text(e)))
              .toList(),
          onChanged: (val) {},
        ),
      ),
    );
  }

  Expanded buildFilter1(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 40,
        child: DropdownButtonFormField<String>(
          hint: Text('Non stop'),
          iconSize: 20,
          style: Theme.of(context).textTheme.caption,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8),
              fillColor: Colors.white10,
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.transparent))),
          items: <String>['Non stop', 'Another']
              .map((e) => DropdownMenuItem<String>(child: Text(e)))
              .toList(),
          onChanged: (val) {},
        ),
      ),
    );
  }

  Row buildDateTimePicker(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 40,
          child: FlatButton(
              onPressed: () {},
              color: Colors.white10,
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(8))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_today, size: 15),
                  SizedBox(width: 5),
                  Text('June 3', style: Theme.of(context).textTheme.caption)
                ],
              )),
        ),
        SizedBox(width: 2),
        SizedBox(
          height: 40,
          child: FlatButton(
              onPressed: () {},
              color: Colors.white10,
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(8))),
              child:
                  Text('June 8', style: Theme.of(context).textTheme.caption)),
        ),
      ],
    );
  }

  TextField buildSeatchField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          hintStyle: Theme.of(context).textTheme.bodyText2,
          hintText: 'Search another flight...',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white))),
    );
  }

  Row buildAirportNames() {
    return Row(
      children: [
        Expanded(
          child: TButton(title: 'New York', subtitle: 'JFK', onPressed: () {}),
        ),
        SizedBox(width: 16),
        Container(
          height: 52,
          padding: const EdgeInsets.all(8),
          child: RotatedBox(
              quarterTurns: 45, child: Icon(Icons.airplanemode_active)),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white10),
        ),
        SizedBox(width: 16),
        Expanded(
          child: TButton(title: 'San Fran', subtitle: 'SFO', onPressed: () {}),
        ),
      ],
    );
  }

  Padding buildSearchFilter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('SEARCH RESULTS', style: Theme.of(context).textTheme.bodyText2),
          IconButton(
              icon: SvgPicture.asset(Assets.filterIcon), onPressed: () {})
        ],
      ),
    );
  }
}
