import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/tab_bar_state.dart';

part 'tab_bar_state_store.g.dart';

@Riverpod(keepAlive: true)
class TabBarStateStore extends _$TabBarStateStore {
  @override
  TabBarState build() {
    return TabBarState();
  }

  void setDarkMode(bool isDark){
    state = state.copyWith(isDark: isDark);
  }

  void setHidden(bool isHidden){
    state = state.copyWith(isHidden: isHidden);
  }
}