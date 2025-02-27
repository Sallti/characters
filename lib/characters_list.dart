import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'character_details.dart';
import 'characters_view_model.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CharactersViewModel>(builder: (context, data, child) {
      return Stack(
        children: [
          ListView.builder(
            controller: data.listController,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: data.filteredCharactersList.length,
            itemBuilder: (BuildContext context, int index) {
              final character = data.filteredCharactersList[index];
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: Text(character.name ?? ''),
                        ),
                        body: CharacterDetails(character)),
                  ),
                ),
                child: Card(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(character.name ?? ''),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Species: ${character.species ?? ''}'),
                              Text('Status: ${character.status ?? ''}'),
                            ],
                          ),
                        ),
                      ),
                      Image.network(
                        character.image ?? '',
                        height: MediaQuery.of(context).size.height * 0.1,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
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
      );
    });
  }
}
