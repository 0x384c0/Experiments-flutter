enum SelectedPageState {
  forms(0),
  posts(1),
  weather(2),
  webView(3),
  experiments(4),
  stackoverflow(5);

  const SelectedPageState(this.id);

  final int id;

  static SelectedPageState defaultPage = SelectedPageState.forms;
}
