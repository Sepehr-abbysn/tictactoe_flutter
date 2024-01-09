import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String winnerTitle = "";

  bool isTurnO = true;
  bool gameHasResult = false;

  List xoList = ["", "", "", "", "", "", "", "", ""];

  int filledBoxes = 0;
  int scoreX = 0;
  int scoreO = 0;

  void setResult(String winner, String title) {
    setState(() {
      gameHasResult = true;
      winnerTitle = title;
      if (winner == "X") {
        scoreX++;
        return;
      }
      if (winner == "O") {
        scoreO++;
        return;
      } else if (winner == "") {
        scoreO++;
        scoreX++;
      }
    });
  }

  void resetGame() {
    setState(() {
      for (int i = 0; i < xoList.length; i++) {
        xoList[i] = "";
      }
      isTurnO = true;
      gameHasResult = false;
    });
    filledBoxes = 0;
  }

  void tapped(int index) {
    if (gameHasResult) {
      return;
    }
    setState(() {
      if (xoList[index] != "") {
        return;
      }
      if (isTurnO) {
        xoList[index] = "O";
        filledBoxes++;
      } else {
        xoList[index] = "X";
        filledBoxes++;
      }
      isTurnO = !isTurnO;
    });

    checkWinner();
  }

  void checkWinner() {
    if (xoList[0] == xoList[1] && xoList[0] == xoList[2] && xoList[0] != "") {
      String winner = xoList.elementAt(0);
      setResult(winner, "winner is $winner");
      return;
    }
    if (xoList[3] == xoList[4] && xoList[3] == xoList[5] && xoList[3] != "") {
      String winner = xoList.elementAt(3);
      setResult(winner, "winner is $winner");
      return;
    }
    if (xoList[6] == xoList[7] && xoList[6] == xoList[8] && xoList[6] != "") {
      String winner = xoList.elementAt(6);
      setResult(winner, "winner is $winner");
      return;
    }
    if (xoList[0] == xoList[3] && xoList[0] == xoList[6] && xoList[0] != "") {
      String winner = xoList.elementAt(0);
      setResult(winner, "winner is $winner");
      return;
    }
    if (xoList[1] == xoList[4] && xoList[1] == xoList[7] && xoList[1] != "") {
      String winner = xoList.elementAt(1);
      setResult(winner, "winner is $winner");
      return;
    }
    if (xoList[2] == xoList[5] && xoList[2] == xoList[8] && xoList[2] != "") {
      String winner = xoList.elementAt(2);
      setResult(winner, "winner is $winner");
      return;
    }
    if (xoList[0] == xoList[4] && xoList[0] == xoList[8] && xoList[0] != "") {
      String winner = xoList.elementAt(0);
      setResult(winner, "winner is $winner");
      return;
    }
    if (xoList[2] == xoList[4] && xoList[2] == xoList[6] && xoList[2] != "") {
      String winner = xoList.elementAt(2);
      setResult(winner, "winner is $winner");
      return;
    } else if (filledBoxes == 9) {
      String winner = "";
      setResult(winner, "Draw");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: getAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            getScoreBoard(),
            getResultButton(),
            SizedBox(height: 20),
            getGridView(),
            getTurn(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            resetGame();
            setState(() {
              scoreO = 0;
              scoreX = 0;
            });
          },
          icon: Icon(
            Icons.refresh,
            size: 30,
          ),
        ),
      ],
      centerTitle: true,
      elevation: 0,
      title: Text(
        "TicTacToe",
      ),
      backgroundColor: Colors.grey[900],
    );
  }

  Widget getTurn() {
    return Text(
      isTurnO ? "Turn O" : "Turn X",
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget getGridView() {
    return Expanded(
      child: GridView.builder(
        itemCount: 9,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              tapped(index);
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Text(
                  xoList[index],
                  style: TextStyle(
                    color: xoList[index] == "X" ? Colors.white : Colors.red,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            gameHasResult = false;
            resetGame();
          });
        },
        child: Text(
          "$winnerTitle , Play Again!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          side: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget getScoreBoard() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Player O",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "$scoreO",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Player X",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "$scoreX",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
