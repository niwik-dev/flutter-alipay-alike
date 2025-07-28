class TabBarState{
  bool isDark;
  bool isHidden;

  TabBarState({
    this.isDark = false,
    this.isHidden = false
  });

  TabBarState copyWith({
    bool? isDark,
    bool? isHidden
  }){
    return TabBarState(
      isDark: isDark ?? this.isDark,
      isHidden: isHidden ?? this.isHidden
    );
  }
}