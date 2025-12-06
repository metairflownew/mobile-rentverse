import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';

class SearchAndSortCubit extends Cubit<SearchAndSortState> {
  SearchAndSortCubit() : super(const SearchAndSortState());

  void updateQuery(String query) {
    emit(state.copyWith(query: query));
  }

  void selectType(String type) {
    emit(state.copyWith(selectedType: type));
  }
}
