import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterNotifier extends StateNotifier<Map<String, dynamic>> {
  FilterNotifier()
      : super({
          'drinks': false,
          "desserts": false,
          "meal": false,
          "open": false,
          "preferred": false,
          "sale": false,
          "minPrice": 100.0,
          "maxPrice": 300.0,
        });

  void changeFilter(key, value) {
    state[key] = value;
    print(state);

    state = state;
  }

  void clearFilter() {
    state = {
      'drinks': false,
      "desserts": false,
      "meal": false,
      "open": false,
      "preferred": false,
      "sale": false,
      "minPrice": 100.0,
      "maxPrice": 300.0,
    };
  }
}

final filterProvider =
    StateNotifierProvider<FilterNotifier, Map<String, dynamic>>(
  (ref) => FilterNotifier(),
);
