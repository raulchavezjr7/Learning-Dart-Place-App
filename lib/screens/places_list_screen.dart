import 'package:flutter/material.dart';
import 'package:placeapp/providers/great_places.dart';
import 'package:placeapp/screens/add_place_screen.dart';
import 'package:placeapp/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlace(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlaces>(
                  builder: (ctx, greatPlaces, ch) => greatPlaces.items.isEmpty
                      ? ch!
                      : ListView.builder(
                          itemBuilder: (ctx, i) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                greatPlaces.items[i].image,
                              ),
                            ),
                            title: Text(greatPlaces.items[i].title),
                            subtitle:
                                Text(greatPlaces.items[i].location.address),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                PlaceDetailScreen.routeName,
                                arguments: greatPlaces.items[i].id,
                              );
                            },
                          ),
                          itemCount: greatPlaces.items.length,
                        ),
                  child: const Center(
                    child: Text('Got no places yet, start adding some'),
                  ),
                ),
        ),
      ),
    );
  }
}
