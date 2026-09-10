
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

  void _updateFirstName(newValue){
    setState(() {
      _firstName = newValue;
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
            )
          ],
        ),
      ),
    );
  }
}