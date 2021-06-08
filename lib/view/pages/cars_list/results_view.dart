
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_car/constants/cars_globals.dart';

import '../../../data_class/car_data.dart';

import 'package:http/http.dart' as http;
import 'package:quick_car/states/search_state.dart';
import 'package:quick_car/view/pages/cars_list/car_item.dart';
import 'package:quick_car/view/pages/cars_list/search_parameters.dart';
import 'package:quick_car/view/pages/cars_list/sort.dart';


class ResultsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ResultsViewState();
}
class ResultsViewState extends State<ResultsView> {

  List<CarData> cars = [];
  bool isLoading;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build results view");
    return Consumer<SearchState>(
        builder: (context, state, child) {
          isLoading = state.isLoading();
          cars = state.carsList;
          print("build consumer results view");
          return SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    splashColor: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black87),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1,vertical: 10),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            // TODO: search with search icon, filter by car company
                            Icon(Icons.search),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Search your car",style:TextStyle(fontSize: 13,color: Colors.black54),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12),
                              child: GestureDetector(
                                onTap: () {
                                  print("on pressed");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          SearchParameters()));
                                },
                                child:Icon(Icons.filter_alt)                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Sort())),
                                  child: Icon(Icons.sort)

                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  body()
                ],
              )
          );
        }
      );

}
  Widget body() {
    if (cars.contains(null) || cars.length < 0 || isLoading) {
      return SizedBox(
        height: 200,
          child: Center(child: CircularProgressIndicator())
      );
    }
    if (cars.length == 0) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("No results found", style: TextStyle(fontSize: 20),),
      );
    }
    return Expanded(
        child:ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return CarItem(cars[index]);
        }));

  }

}


