import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'characters_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff82dcf8)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Rick and Morty Characters'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CharactersViewModel>(
      create: (BuildContext context) => CharactersViewModel(),
      child: Consumer<CharactersViewModel>(
        builder: (context, data, child) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: data.showSearchBar
                    ? TextField(
                        controller: TextEditingController(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Icon(Icons.search, color: Colors.white),
                            ),
                            suffixIcon: IconButton(
                              icon: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Icon(Icons.close),
                              ),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                            border: InputBorder.none,
                            hintText: 'Type character name',
                            hintStyle: TextStyle(color: Colors.white)))
                    : Text(title),
                actions: [
                  IconButton(onPressed: () => {}, icon: Icon(Icons.filter_alt)),
                  IconButton(
                    onPressed: () => data.showSearchBar = !data.showSearchBar,
                    icon: Icon(
                      Icons.search,
                    ),
                  ),
                ],
              ),
              body: Stack(
                children: [
                  ListView.builder(
                    controller: data.listController,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: data.filteredCharactersList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final character = data.filteredCharactersList[index];
                      return Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              character.image ?? '',
                              height: MediaQuery.of(context).size.height * 0.16,
                              fit: BoxFit.cover,
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(character.name ?? ''),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Species: ${character.species ?? ''}'),
                                    Text(
                                        'Origin: ${character.origin?.name ?? ''}'),
                                    Text('Gender: ${character.gender ?? ''}'),
                                    Text('Status: ${character.status ?? ''}'),
                                    Text(
                                        'Location: ${character.location?.name ?? ''}'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  if (data.isLoading)
                    Center(
                        child: CircularProgressIndicator(
                      color: Colors.blue[300],
                    ))
                ],
              ));
        },
      ),
    );
  }
}
