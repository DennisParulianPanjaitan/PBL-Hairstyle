import 'package:flutter_bloc/flutter_bloc.dart';
import 'features_event.dart';
import 'features_state.dart';

class FeaturesBloc extends Bloc<FeaturesEvent, FeaturesState> {
  FeaturesBloc() : super(const FeaturesState()) {
    on<SelectTabEvent>((event, emit) {
      emit(state.copyWith(currentTabIndex: event.selectedIndex));
    });

    on<ToggleBookmarkEvent>((event, emit) {
      Set<int> updatedBookmarks;

      if (event.tabName == "HairCut") {
        updatedBookmarks = Set.from(state.bookmarkedHaircuts);
        if (updatedBookmarks.contains(event.index)) {
          updatedBookmarks.remove(event.index);
        } else {
          updatedBookmarks.add(event.index);
        }
        emit(state.copyWith(bookmarkedHaircuts: updatedBookmarks));
      } else if (event.tabName == "HairProduct") {
        updatedBookmarks = Set.from(state.bookmarkedProducts);
        if (updatedBookmarks.contains(event.index)) {
          updatedBookmarks.remove(event.index);
        } else {
          updatedBookmarks.add(event.index);
        }
        emit(state.copyWith(bookmarkedProducts: updatedBookmarks));
      } else if (event.tabName == "BarberShop") {
        updatedBookmarks = Set.from(state.bookmarkedBarbershops);
        if (updatedBookmarks.contains(event.index)) {
          updatedBookmarks.remove(event.index);
        } else {
          updatedBookmarks.add(event.index);
        }
        emit(state.copyWith(bookmarkedBarbershops: updatedBookmarks));
      }
    });
  }
}
