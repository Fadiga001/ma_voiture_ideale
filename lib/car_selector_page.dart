
import 'dart:ffi';

import 'package:flutter/material.dart';

class CarSelectorPage extends StatefulWidget {

  const CarSelectorPage({super.key});

  @override
  State<CarSelectorPage> createState() {
    return _CarSelectorPageState();
  }

}

class _CarSelectorPageState extends State<CarSelectorPage> {
  
  String _firstName = "";
  double _kms = 0;
  bool _electric = true;
  List<int> _places = [2, 4, 5, 7];
  int _placeSelector = 2;
  
  Padding _interactiveWidget({required List<Widget> children, bool isRow = false}){
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            (isRow)
            ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: children,
            )
            : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children
            ),
            const Divider()
          ],
        ),
    );
  }

  void _updateFirstName(String newValue){
    setState(() {
      _firstName = newValue;
    });
  }

  void _updateKms(double newValue){
    setState(() {
      _kms = newValue;
    });
  }

  void _updateEngine(bool newValue){
    setState(() {
      _electric = newValue;
    });
  }

  void _updatePlace(int? newValue){
    setState(() {
      _placeSelector = newValue ?? 2;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurateur de voiture"),
        actions: [
          ElevatedButton(
              onPressed: (){}, 
              child: Text("Je Valide")
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
                "Bienvenue : $_firstName",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.normal
                ),
            ),
            _interactiveWidget(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Entrez votre nom",
                      filled: true
                    ),
                    onSubmitted: _updateFirstName
                  )
                ]
            ),
            _interactiveWidget(
                children: [
                  Text("Nombre de kilomètre annuel : ${_kms.toInt()}"),
                  Slider(
                      min: 0,
                      max: 25000,
                      value: _kms,
                      onChanged: _updateKms
                  )
                ]
            ),
            _interactiveWidget(
                isRow: true,
                children: [
                  Text(_electric ? "Moteur electrique" : "Moteur thermique"),
                  Switch(value: _electric, onChanged: _updateEngine)
                ]
            ),
            _interactiveWidget(
                children: [
                  Text("Nombre de places : $_placeSelector"),
                  RadioGroup(
                      groupValue: _placeSelector,
                      onChanged: _updatePlace,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: _places.map((place){
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<int>(
                                  value: place
                              ),
                              Text(place.toString())
                            ],
                          );
                        }).toList(),
                      )
                  )
                ]
            )
          ],
        ),
      ),
    );
  }
}