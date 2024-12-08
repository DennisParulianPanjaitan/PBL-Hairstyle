import 'package:equatable/equatable.dart';

class FeaturesState extends Equatable {
  final int currentTabIndex;
  final Set<int> bookmarkedHaircuts;
  final Set<int> bookmarkedProducts;
  final Set<int> bookmarkedBarbershops;

  const FeaturesState({
    this.currentTabIndex = 0,
    this.bookmarkedHaircuts = const {},
    this.bookmarkedProducts = const {},
    this.bookmarkedBarbershops = const {},
  });

  FeaturesState copyWith({
    int? currentTabIndex,
    Set<int>? bookmarkedHaircuts,
    Set<int>? bookmarkedProducts,
    Set<int>? bookmarkedBarbershops,
  }) {
    return FeaturesState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      bookmarkedHaircuts: bookmarkedHaircuts ?? this.bookmarkedHaircuts,
      bookmarkedProducts: bookmarkedProducts ?? this.bookmarkedProducts,
      bookmarkedBarbershops: bookmarkedBarbershops ?? this.bookmarkedBarbershops,
    );
  }

  @override
  List<Object?> get props => [
        currentTabIndex,
        bookmarkedHaircuts,
        bookmarkedProducts,
        bookmarkedBarbershops,
      ];
}
