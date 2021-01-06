import 'package:country_house/Screens/CountryMap.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Country extends StatelessWidget {
  final Map country;
  Country(this.country);

  @override
  Widget build(BuildContext context) {
    print(country);
    return Scaffold(
      appBar: AppBar(
        title: Text(country['name']),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: <Widget>[
            FlipCard(
              front: CardWidget(title: 'Capital'),
              back: countryDetailsCard(country['capital'], Colors.blue),
              direction: FlipDirection.VERTICAL,
            ),
            FlipCard(
              front: CardWidget(title: 'Currency'),
              back: countryDetailsCard(
                  country['currencies'][0]['name'].toString(), Colors.orange),
              direction: FlipDirection.VERTICAL,
            ),
            FlipCard(
              front: CardWidget(title: 'Population'),
              back: countryDetailsCard(
                  country['population'].toString(), Colors.pink),
              direction: FlipDirection.VERTICAL,
            ),
            FlipCard(
              front: CardWidget(title: 'Flag'),
              back: Card(
                elevation: 10,
                color: Colors.white,
                child: Center(
                    child: SvgPicture.network(
                  country['flag'],
                  width: 100,
                  height: 50,
                )),
              ),
              direction: FlipDirection.VERTICAL,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => CountryMap(),
                    ),
                  );
                },
                child: CardWidget(title: 'Show on map')),
          ],
        ),
      ),
    );
  }
}

class countryDetailsCard extends StatelessWidget {
  final String text;
  final MaterialColor color;
  countryDetailsCard(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String title;

  const CardWidget({this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Center(
          child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      )),
    );
  }
}
