import 'package:country_house/Screens/Country.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AllCountries extends StatefulWidget {
  @override
  _AllCountriesState createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  List countries = [];
  List filterCountries = [];
  bool ifSearching = false;

  getCountries() async {
    var response = await Dio().get('https://restcountries.eu/rest/v2/all');
    return response.data;
  }

  @override
  void initState() {
    getCountries().then((data) {
      setState(() {
        countries = filterCountries = data;
      });
    });
    super.initState();
  }

  void _filterCounters(String value) {
    setState(() {
      filterCountries = countries
          .where((Country) => Country['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    getCountries();
    return Scaffold(
      appBar: AppBar(
        title: !ifSearching
            ? Text("All Countries")
            : TextField(
                onChanged: (value) {
                  _filterCounters(value);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search Country name',
                  hintStyle: TextStyle(color: Colors.white),
                  icon: Icon(Icons.search, color: Colors.white),
                ),
              ),
        actions: [
          ifSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.ifSearching = false;
                      filterCountries = countries;
                    });
                  })
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.ifSearching = true;
                    });
                  })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: filterCountries.length > 0
            ? ListView.builder(
                itemCount: filterCountries.length,
                itemBuilder: (BuildContext cotext, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Country(filterCountries[index]);
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
                          filterCountries[index]['name'],
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(child: CircularProgressIndicator()),
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
      ),
    );
  }
}
