/// The app bar UI state model for Home screen
// FIX: State should be immutable
class HomeAppBarUiState {
  bool isFilterIconActive;
  bool isHideCompletedTasksIconActive;

  HomeAppBarUiState({
    this.isFilterIconActive = false,
    this.isHideCompletedTasksIconActive = false,
  });
  // FIX: State should be immutable
}
