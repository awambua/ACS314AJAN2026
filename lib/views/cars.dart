import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/car_model.dart';
import 'package:http/http.dart' as http;

var myCars = [];
bool loaded = false;

class CarsPage extends StatefulWidget {
  const CarsPage({super.key});

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  @override
  void initState() {
    fetchCars();
    super.initState();
  }

  fetchCars() async {
    final response = await http.get(
      Uri.parse("http://localhost/cars/readcars.php"),
    );
    print(response.body);
    if (response.statusCode == 200) {
      var serverData = jsonDecode(response.body);
      var carData = serverData['data'];

      for (var car in carData) {
        myCars.add(
          CarModel(name: car['name'], year: car['yom'], imageUrl: car['image']),
        );
      }
      setState(() {
        loaded = true;
      });
    } else {
      throw Exception("Failed to load cars");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: myCars.length,
      itemBuilder: (context, index) {
        return loaded
            ? Row(
                children: [
                  Image.network(
                    "http://localhost/cars/car_images/${myCars[index].imageUrl}",
                    width: 100,
                    height: 100,
                  ),
                  Column(
                    children: [
                      Text(myCars[index].name),
                      Text(myCars[index].year),
                    ],
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
