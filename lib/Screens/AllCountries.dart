import 'package:country_house/Screens/Country.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AllCountries extends StatefulWidget {
  @override
  _AllCountriesState createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  Future<List> countries;

  Future<List> getCountries() async {
    var response = await Dio().get('https://restcountries.eu/rest/v2/all');
    return response.data;
  }

  @override
  void initState() {
    countries = getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getCountries();
    return Scaffold(
      appBar: AppBar(
        title: Text("Countries"),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder<List>(
          future: countries, // async work
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (BuildContext cotext, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Country(snapshot.data[index]);
                          },
                        ),
                      );
                    },
                    child: Card(
                      //color: Colors.white54,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: Text(
                          snapshot.data[index]['name'],
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        )
        /* ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Country("BD");
                    },
                  ),
                );
              },
              child: Card(
                //color: Colors.white54,
                elevation: 10,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: Text(
                    'BD ',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Country("USA");
                    },
                  ),
                );
              },
              child: Card(
                //color: Colors.white54,
                elevation: 10,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: Text(
                    'USA',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        )*/
        ,
      ),
    );
  }
}
