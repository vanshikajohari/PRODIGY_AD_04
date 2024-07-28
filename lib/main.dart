import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToeHomePage(),
    );
  }
}

class TicTacToeHomePage extends StatefulWidget {
  @override
  _TicTacToeHomePageState createState() => _TicTacToeHomePageState();
}

class _TicTacToeHomePageState extends State<TicTacToeHomePage> {
  List<List<String>> _board = List.generate(3, (_) => List.filled(3, ''));
  String _currentPlayer = 'X';
  String _winner = '';

  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.filled(3, ''));
      _currentPlayer = 'X';
      _winner = '';
    });
  }

  void _handleTap(int row, int col) {
    if (_board[row][col] != '' || _winner != '') {
      return;
    }

    setState(() {
      _board[row][col] = _currentPlayer;
      if (_checkWinner(row, col)) {
        _winner = _currentPlayer;
      } else {
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      }
    });
  }

  bool _checkWinner(int row, int col) {
    // Check row
    if (_board[row].every((cell) => cell == _currentPlayer)) {
      return true;
    }

    // Check column
    if (_board.every((r) => r[col] == _currentPlayer)) {
      return true;
    }

    // Check diagonal
    if (row == col && [_board[0][0], _board[1][1], _board[2][2]].every((cell) => cell == _currentPlayer)) {
      return true;
    }

    // Check anti-diagonal
    if (row + col == 2 && [_board[0][2], _board[1][1], _board[2][0]].every((cell) => cell == _currentPlayer)) {
      return true;
    }

    return false;
  }

  Widget _buildCell(int row, int col) {
    return GestureDetector(
      onTap: () => _handleTap(row, col),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Center(
          child: Text(
            _board[row][col],
            style: TextStyle(fontSize: 48.0),
          ),
        ),
      ),
    );
  }

  Widget _buildBoard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (col) {
            return _buildCell(row, col);
          }),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetGame,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildBoard(),
            if (_winner.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Player $_winner wins!',
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
