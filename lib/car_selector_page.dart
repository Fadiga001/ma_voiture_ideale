import 'package:flutter/material.dart';

class CarSelectorPage extends StatefulWidget {

  const CarSelectorPage({super.key});

  @override
  State<CarSelectorPage> createState() {
    return _CarSelectorPageState();
  }

}

class _CarSelectorPageState extends State<CarSelectorPage> {
  
  String _resultat = "";
  String _firstName = "";
  double _kms = 0;
  bool _electric = true;
  final List<int> _places = [2, 4, 5, 7];
  int _placeSelector = 2;
  final Map<String, bool> _options = {
    "GPS" : false,
    "Clim par Zone" : false,
    "Caméra de recule " : false,
    "Régulateur de vitesse" : false,
    "Toit ouvrant" : false,
    "Siège chauffante" : false,
    "Roue de sécours" : false,
    "Jantes alu" : false
  };

  Car? _carSelected;

 final  List<Car> _cars = [
    Car(name: "MG", url: "MG", places: 2, isElectric: true),
    Car(name: "R5 Electrique", url: "R5", places: 4, isElectric: true),
    Car(name: "Tesla", url: "tesla", places: 5, isElectric: true),
    Car(name: "Van VW", url: "van", places: 7, isElectric: true),
    Car(name: "Alpine", url: "Alpine", places: 2, isElectric: false),
    Car(name: "Fiat 500", url: "Fiat 500", places: 4, isElectric: false),
    Car(name: "Peugeot 3008", url: "P3008", places: 5, isElectric: false),
    Car(name: "Dacia Jogger", url: "Jogger", places: 7, isElectric: false),
  ];

  String? _image;
  
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

  void _updateOptions(bool? newValue, String key){
    setState(() {
      _options[key] = newValue ?? false;
    });
  }

  void _handleResult(){
    setState(() {
      _resultat = isGoodChoice();
      _carSelected = _cars.firstWhere((car) => car.isElectric == _electric && car.places == _placeSelector);
    });
  }

  String isGoodChoice(){
    if (_kms > 15000 && _electric){
      return "Vous devriez pensez à un moteur thermique compte tenu de la distance";
    }else if(_kms < 5000 && !_electric){
      return "Vous faites un peu de kilomètre, pensez à regarder les voitures électriques";
    }else {
      return "Voici la voiture faite pour vous !";
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurateur de voiture"),
        actions: [
          ElevatedButton(
              onPressed: _handleResult,
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
            Card(
              margin: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(_resultat),
                    (_carSelected == null)
                    ? const SizedBox(height: 0)
                    : Image.asset(_carSelected!.urlString, fit: BoxFit.contain),
                    Text(_carSelected!.name)
                  ],
                ),
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
            ),
            _interactiveWidget(
                children: [
                  Text("Les options de la voiture"),
                  Column(
                    children: _options.keys.map((key){
                      return CheckboxListTile(
                          title: Text(key),
                          value: _options[key],
                          onChanged: ((b)=> _updateOptions(b, key))
                      );
                    }).toList(),
                  )
                ]
            )
          ],
        ),
      ),
    );
  }
}

class Car {
  String name;
  String url;
  int places;
  bool isElectric;

  Car({required this.name, required this.url, required this.places, required this.isElectric});

  String get urlString => "assets/$url.jpg";
}