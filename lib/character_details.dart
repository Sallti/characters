import 'package:flutter/material.dart';
import 'package:rick_and_morty/response_model.dart';

class CharacterDetails extends StatelessWidget {
  const CharacterDetails(this.character, {super.key});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return orientation == Orientation.portrait
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    character.image ?? '',
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                  _infoRow('Species', character.species ?? ''),
                  _infoRow('Origin', character.origin?.name ?? ''),
                  _infoRow('Gender', character.gender ?? ''),
                  _infoRow('Status', character.status ?? ''),
                  _infoRow('Location', character.location?.name ?? ''),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    character.image ?? '',
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                  Column(children: [
                  _infoRow('Species', character.species ?? ''),
                  _infoRow('Origin', character.origin?.name ?? ''),
                  _infoRow('Gender', character.gender ?? ''),
                  _infoRow('Status', character.status ?? ''),
                  _infoRow('Location', character.location?.name ?? ''),
                  ],)
                ],
              );
  }

  Widget _infoRow(String title, String info) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Row(mainAxisSize: MainAxisSize.min,
        children: [
          Text('$title:   ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18)),
          Expanded(
            child: Text(
              info,
              style: TextStyle(fontSize: 19),
            ),
          )
        ],
      ),
    );
  }
}
