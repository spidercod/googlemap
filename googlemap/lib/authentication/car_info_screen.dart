import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:googlemap/global/global.dart';
import 'package:googlemap/screens/splash_screen.dart';
import 'package:googlemap/tabPages/home_tabs.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({Key? key}) : super(key: key);

  @override
  _CarInfoScreenState createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  TextEditingController carmodelEditingController = TextEditingController();
  TextEditingController carnumberTextEditingController =
      TextEditingController();
  TextEditingController carcolorTextEditingController = TextEditingController();
  List<String> carTypeslist = ["Riding", "Posts", "Bike"];
  String? selctedCarType;

  saveinfocard() {
    Map driverCarInfo = {
      "car_color": carcolorTextEditingController.text.trim(),
      "car_number": carnumberTextEditingController.text.trim(),
      "car_model": carmodelEditingController.text.trim(),
      "type": selctedCarType,
    };
    DatabaseReference driversRef =
        FirebaseDatabase.instance.ref().child("drivers");
    driversRef
        .child(currentFirebaseUser!.uid)
        .child("car_details")
        .set(driverCarInfo);
    Fluttertoast.showToast(msg: "Car Details has been saved");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => MySplashScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset('assets/images/taxi_car.jpg'),
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 250),
                      child: Container(
                        height: 600,
                        decoration: const BoxDecoration(
                          color: Color(0xffd3b231),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      margin: const EdgeInsets.only(top: 230, left: 100),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          'Write Car Details',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 250),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: carmodelEditingController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText: 'Car Model',
                                  hintStyle: const TextStyle(fontSize: 12)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: carnumberTextEditingController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText: 'Car Number',
                                  hintStyle: const TextStyle(fontSize: 12)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: carcolorTextEditingController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: 'Car Color',
                                hintStyle: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButton(
                            dropdownColor: Colors.black54,
                            hint: const Text(
                              'Riding',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            value: selctedCarType,
                            onChanged: (newVlaue) {
                              setState(() {
                                selctedCarType = newVlaue.toString();
                              });
                            },
                            items: carTypeslist.map((car) {
                              return DropdownMenuItem(
                                child: Text(
                                  car,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                value: car,
                              );
                            }).toList(),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            onPressed: () {
                              if (carcolorTextEditingController
                                      .text.isNotEmpty &&
                                  carnumberTextEditingController
                                      .text.isNotEmpty &&
                                  carmodelEditingController.text.isNotEmpty &&
                                  selctedCarType != null) {
                                saveinfocard();
                              }
                              print(saveinfocard());
                            },
                            child: Text('Save Now'),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
