import 'package:flutter/material.dart';


class DataSearch extends SearchDelegate<String> {
  final cities = [
    "Abejorral",
    "Amalfi",
    "Andes",
    "Angostura",
    "Arboletes",
    "Argelia",
    "Armenia",
    "Barbosa",
    "Bello",
    "Belmira",
    "Betania",
    "Betulia",
    "Caicedo",
    "Caldas",
    "Campamento",
    "Caramanta",
    "Carepa",
    "Caucasia",
    "Cisneros ",
    "Concordia",
    "Copacabana",
    "Dabeiba"
  ];

  final recentCities = ["Cisneros", "Concordia", "Copacabana", "Dabeiba"];

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // ahow some result based on the selection
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: Card(
          color: Colors.red,
          child: Text(query),
        )
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
            onTap: (){
              showResults(context);
            },
            leading: Icon(Icons.location_city),
            title: RichText(
                text: TextSpan(
                    text: suggestionList[index].substring(0, query.length),
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: suggestionList[index].substring(query.length),
                        style: TextStyle(color: Colors.grey),
                      )
                    ]
                )
            )
        );
      },
      itemCount: suggestionList.length,
    );
  }
}
