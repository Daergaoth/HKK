import 'package:flutter/material.dart';
import 'package:hkk/service/single_play/game_table_data.dart';
import 'package:hkk/service/single_play/rule_set_service.dart';

class HandField extends StatefulWidget {
  // List<String> enemyHand;
  // String enemyName;
  bool amIEnemyField;
  GameTableData gameTableData;
  RuleSetService ruleSetService;

  HandField({
    this.ruleSetService,
    this.gameTableData,
    this.amIEnemyField,
  });

  @override
  _HandFieldState createState() => _HandFieldState(
        ruleSetService: ruleSetService,
        gameTableData: gameTableData,
        amIEnemyField: amIEnemyField,
      );
}

class _HandFieldState extends State<HandField> {
  RuleSetService ruleSetService;
  GameTableData gameTableData;
  bool amIEnemyField;

  int selectedCard;

  _HandFieldState(
      {this.ruleSetService, this.gameTableData, this.amIEnemyField});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(amIEnemyField ? gameTableData.enemyName : gameTableData.ownName,
            style: TextStyle(
              color: Colors.lightBlue[900],
              fontSize: MediaQuery.of(context).size.height * 0.02,
            )),
        Row(
          children: [
            Container(
              width: getFirstWidth(),
              height: MediaQuery.of(context).size.height * 0.08,
              child: ListView.builder(
                itemCount: amIEnemyField
                    ? gameTableData.enemyHand.length
                    : gameTableData.ownHand.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      SizedBox(width: getSecondWidth(index)),
                      InkWell(
                        onTap: () {
                          cardTapped(index);
                        },
                        child: Image.asset(amIEnemyField
                            ? getEnemyHandImage(index)
                            : getOwnHandImage(index)),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              width: getThirdWidth(),
              // gameTableData.enemyHand.length > 0
              //     ? MediaQuery.of(context).size.width * 0.015
              //     : 0.0,
            ),
            Container(
              width: getFourthWidth(6),
              height: MediaQuery.of(context).size.height * 0.08,
              child: Image.asset('assets/card_placeholder.jpg'),
            ),
            Container(
              width: getFourthWidth(5),
              height: MediaQuery.of(context).size.height * 0.08,
              child: Image.asset('assets/card_placeholder.jpg'),
            ),
            Container(
              width: getFourthWidth(4),
              height: MediaQuery.of(context).size.height * 0.08,
              child: Image.asset('assets/card_placeholder.jpg'),
            ),
            Container(
              width: getFourthWidth(3),
              height: MediaQuery.of(context).size.height * 0.08,
              child: Image.asset('assets/card_placeholder.jpg'),
            ),
            Container(
              width: getFourthWidth(2),
              height: MediaQuery.of(context).size.height * 0.08,
              child: Image.asset('assets/card_placeholder.jpg'),
            ),
            Container(
              width: getFourthWidth(1),
              height: MediaQuery.of(context).size.height * 0.08,
              child: Image.asset('assets/card_placeholder.jpg'),
            ),
            Container(
              width: getFourthWidth(0),
              height: MediaQuery.of(context).size.height * 0.08,
              child: Image.asset('assets/card_placeholder.jpg'),
            ),
          ],
        ),
        Text(
            amIEnemyField
                ? 'Kéz: ${gameTableData.enemyHand.length}'
                : 'Kéz: ${gameTableData.ownHand.length}',
            style: TextStyle(
              color: Colors.lightBlue[900],
              fontSize: MediaQuery.of(context).size.height * 0.01,
            ))
      ],
    );
  }

  String getEnemyHandImage(int index) {
    if (ruleSetService.canISeeEnemyHand && gameTableData.enemyHand.length > 0) {
      return gameTableData.enemyHand[index].url;
    } else if (!ruleSetService.canISeeEnemyHand &&
        gameTableData.enemyHand.length > 0) {
      return 'assets/hatlap.jpg';
    } else if (!ruleSetService.canISeeEnemyHand &&
        gameTableData.enemyHand.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else if (ruleSetService.canISeeEnemyHand &&
        gameTableData.enemyHand.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else {
      return 'assets/card_placeholder.jpg';
    }
  }

  String getOwnHandImage(int index) {
    if (ruleSetService.canISeeOwnHand && gameTableData.ownHand.length > 0) {
      return gameTableData.ownHand[index].url;
    } else if (!ruleSetService.canISeeOwnHand &&
        gameTableData.ownHand.length > 0) {
      return 'assets/hatlap.jpg';
    } else if (!ruleSetService.canISeeOwnHand &&
        gameTableData.ownHand.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else if (ruleSetService.canISeeOwnHand &&
        gameTableData.ownHand.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else {
      return 'assets/card_placeholder.jpg';
    }
  }

  void cardTapped(int index) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
      content: Builder(
        builder: (context) {
          selectedCard = index;
          // var height = MediaQuery.of(context).size.height * 0.8;
          // var width = MediaQuery.of(context).size.width;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                getCardName(),
                style: TextStyle(color: Colors.white),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(amIEnemyField
                      ? getEnemyHandImage(index)
                      : getOwnHandImage(index))),
              RaisedButton(
                onPressed: () {
                  //TODO: Ezt még ki kell találni.
                },
                child: Text('Kijátszás'),
                color: Color.fromRGBO(0, 0, 0, 0.0),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Bezárás'),
                color: Colors.red,
              ),
            ],
          );
        },
      ),
    );

    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  String getCardName() {
    if (amIEnemyField) {
      return ruleSetService.canISeeEnemyHand
          ? 'Kiválasztott kártya:\n ${gameTableData.enemyHand[selectedCard].name}'
          : 'Kiválasztott kártya:\n ${selectedCard + 1}. kártya';
    } else {
      return ruleSetService.canISeeOwnHand
          ? 'Kiválasztott kártya:\n ${gameTableData.ownHand[selectedCard].name}'
          : 'Kiválasztott kártya:\n ${selectedCard + 1}. kártya';
    }
  }

  double getFirstWidth() {
    if (amIEnemyField) {
      return gameTableData.enemyHand.length < 7
          ? MediaQuery.of(context).size.width *
              0.13 *
              gameTableData.enemyHand.length
          : MediaQuery.of(context).size.width * 0.92;
    } else {
      return gameTableData.ownHand.length < 7
          ? MediaQuery.of(context).size.width *
              0.13 *
              gameTableData.ownHand.length
          : MediaQuery.of(context).size.width * 0.92;
    }
  }

  double getSecondWidth(int index) {
    if (amIEnemyField) {
      return index < gameTableData.enemyHand.length
          ? MediaQuery.of(context).size.width * 0.015
          : 0.0;
    } else {
      return index < gameTableData.ownHand.length
          ? MediaQuery.of(context).size.width * 0.015
          : 0.0;
    }
  }

  double getThirdWidth() {
    if (amIEnemyField) {
      return gameTableData.enemyHand.length > 0
          ? MediaQuery.of(context).size.width * 0.015
          : 0.0;
    } else {
      return gameTableData.ownHand.length > 0
          ? MediaQuery.of(context).size.width * 0.015
          : 0.0;
    }
  }

  double getFourthWidth(int value) {
    if (amIEnemyField) {
      return gameTableData.enemyHand.length <= value
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    } else {
      return gameTableData.ownHand.length <= value
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    }
  }
}
