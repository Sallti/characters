import 'package:flutter/material.dart';
import 'package:rick_and_morty/characters_repository.dart';
import 'package:rick_and_morty/response_model.dart';

class CharactersViewModel with ChangeNotifier {
  bool isLoading = false;

  String error = '';

  final repository = CharactersRepository();

  final listController = ScrollController();

  List<Character> filteredCharactersList = [];

  bool _showSearchBar = false;

  String _searchNameText = '';

  Character?
  selectedCharacter;

  String get searchNameText => _searchNameText;

  set searchNameText(String value) {
    _searchNameText = value;
  }

  bool get showSearchBar => _showSearchBar;

  set showSearchBar(bool value) {
    _showSearchBar = value;
    notifyListeners();
  }

  CharactersViewModel() {
    listController.addListener(loadNextPage);
    loadNextPage();
  }

  Future loadNextPage() async {

    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    if (repository.charactersResponse == null) {
      await repository.fetchCharacters();
    } else if (listController.position.pixels ==
        listController.position.maxScrollExtent) {
      await repository.fetchMoreData();
    } else {
      isLoading = false;
      notifyListeners();
      return;
    }

    filteredCharactersList.clear();

    for (var character in repository.charactersList) {
      if (searchNameText.isEmpty ||
          (character.name != null &&
              character.name!.contains(searchNameText))) {
        filteredCharactersList.add(character);
      }
    }
    isLoading = false;
    notifyListeners();
  }

   setSelectedCharacter(Character selected) {
    selectedCharacter = selected;
    notifyListeners();
   }
}
