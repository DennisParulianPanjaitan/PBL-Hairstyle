import 'package:equatable/equatable.dart';

abstract class FeaturesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectTabEvent extends FeaturesEvent {
  final int selectedIndex;

  SelectTabEvent(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}

class ToggleBookmarkEvent extends FeaturesEvent {
  final int index;
  final String tabName; // "HairCut", "HairProduct", "BarberShop"

  ToggleBookmarkEvent(this.index, this.tabName);

  @override
  List<Object?> get props => [index, tabName];
}
