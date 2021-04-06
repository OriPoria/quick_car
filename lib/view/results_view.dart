
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quick_car/api/api.dart';
import 'package:quick_car/data_class/tests/car_model.dart';
import 'package:quick_car/view/search_parameters.dart';

import 'car_listview/car_Item.dart';

class ResultsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ResultsView();
}
class ResultsView extends State<ResultsPage> {

@override
void initState() {
  super.initState();
}
@override
Widget build(BuildContext context) {
  return Column(
    children: [
      SizedBox(height: 40,),
      InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchParameters()),
          );
        },
        splashColor: Colors.white,
        hoverColor: Colors.blue,
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
                Icon(Icons.search),
                SizedBox(
                  width: 10,
                ),
                Text("Search your car",style:TextStyle(fontSize: 13,color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
      Expanded (
          child: SizedBox(
              height: 100.0,
                child: ListCreator()
          )
      )
    ],
  );

}

}



class ListCreator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListCreatorWidget();
}

class ListCreatorWidget extends State<ListCreator> {

  Future<Welcome> _carsList;

  @override
  void initState() {
    _carsList = API().getCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Welcome>(future: _carsList, builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
            itemCount: snapshot.data.cars.length,
            itemBuilder: (context, index) {
              var car = snapshot.data.cars[index];
              return CarItemView(myCar: car);
            });
      } else {
        return Center(child: CircularProgressIndicator()); }
    });

  }

}

