class ConsoleInterfaceCursorState {
  final int row;
  final int column;

  ConsoleInterfaceCursorState({required this.row, required this.column});

  addedTo(int rows, int columns) {
    return ConsoleInterfaceCursorState(
        row: row + rows, column: column + columns);
  }
}

class ConsoleInterfaceCursor {
  ConsoleInterfaceCursorState _state =
      ConsoleInterfaceCursorState(row: 0, column: 0);

  ConsoleInterfaceCursorState get state {
    return _state;
  }

  void add(int rows, int columns) {
    _state = _state.addedTo(rows, columns);
  }

  void down([int amount = 1]) {
    add(amount, 0);
  }

  void up([int amount = 1]) {
    add(-amount, 0);
  }

  void right([int amount = 1]) {
    add(0, amount);
  }

  void left([int amount = 1]) {
    add(0, -amount);
  }

  void setState(ConsoleInterfaceCursorState state) {
    _state = state;
  }

  void setPosition(int row, int column) {
    _state = ConsoleInterfaceCursorState(row: row, column: column);
  }
}
