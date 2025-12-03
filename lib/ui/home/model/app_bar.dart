/// The app bar UI state model for Home screen
// FIX: State should be immutable
class HomeAppBarUiState {
  bool isHideCompletedTasksIconActive;
  // Room for future filters
  HomeAppBarUiState({
    this.isHideCompletedTasksIconActive = false,
  });
  // FIX: State should be immutable
}
