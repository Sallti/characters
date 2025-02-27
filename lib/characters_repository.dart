import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/response_model.dart';

class CharactersRepository {
  CharactersResponse? charactersResponse;
  List<Character> charactersList = [];

  Future fetchCharacters([String? url]) async {
    await http
        .get(Uri.parse(url ?? 'https://rickandmortyapi.com/api/character'))
        .catchError((e) {
      throw e;
    }).then((onValue) {
      charactersResponse = CharactersResponse.fromJson(
          jsonDecode(onValue.body) as Map<String, dynamic>);
      charactersList.addAll(charactersResponse?.charactersList ?? []);
    });
  }

  Future fetchMoreData() async {
    if ((charactersList.isEmpty ||
            charactersList.length < (charactersResponse?.info?.count ?? 0)) &&
        (charactersResponse?.info?.next != null)) {
      fetchCharacters(charactersResponse?.info?.next);
    }
  }
}
