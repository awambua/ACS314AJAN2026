import 'package:flutter/material.dart';

class Cars extends StatefulWidget {
  const Cars({super.key});

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  final List<Map<String, dynamic>> cars = [
    {
      "name": "Toyota Land Cruiser",
      "price": "KSh 8,500,000",
      "year": "2023",
      "type": "SUV",
      "image": Icons.local_shipping,
    },
    {
      "name": "Mercedes C200",
      "price": "KSh 6,200,000",
      "year": "2024",
      "type": "Sedan",
      "image": Icons.directions_car,
    },
    {
      "name": "Porsche 911",
      "price": "KSh 25,000,000",
      "type": "Sports",
      "image": Icons.speed,
    },
    {
      "name": "Range Rover SV",
      "price": "KSh 18,000,000",
      "year": "2025",
      "type": "Luxury",
      "image": Icons.local_shipping,
    },
  ];

  String selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  "Browsed Cars",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 63, 3, 3),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildFilterChip("All"),
                _buildFilterChip("SUV"),
                _buildFilterChip("Sports"),
                _buildFilterChip("Luxury"),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: cars.length,
              itemBuilder: (context, index) {
                return _buildCarCard(cars[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            selectedFilter = label;
          });
        },
        selectedColor: const Color.fromARGB(255, 63, 3, 3),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildCarCard(Map<String, dynamic> car) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(
                child: Icon(
                  car["image"],
                  size: 60,
                  color: const Color.fromARGB(255, 63, 3, 3),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car["name"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${car["year"]} • ${car["type"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        car["price"],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 63, 3, 3),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 63, 3, 3),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
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
