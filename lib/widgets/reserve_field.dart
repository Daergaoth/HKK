import 'package:flutter/material.dart';
import 'package:hkk/service/single_play/game_table_data.dart';
import 'package:hkk/service/single_play/rule_set_service.dart';

class ReserveField extends StatefulWidget {
  bool amIEnemyField;
  GameTableData gameTableData;
  RuleSetService ruleSetService;

  ReserveField({
    this.ruleSetService,
    this.gameTableData,
    this.amIEnemyField,
  });

  @override
  _ReserveFieldState createState() => _ReserveFieldState(
        ruleSetService: ruleSetService,
        gameTableData: gameTableData,
        amIEnemyField: amIEnemyField,
      );
}

class _ReserveFieldState extends State<ReserveField> {
  bool amIEnemyField;
  GameTableData gameTableData;
  RuleSetService ruleSetService;

  int selectedCard;

  _ReserveFieldState(
      {this.ruleSetService, this.gameTableData, this.amIEnemyField});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              width: getFirstWidth(),
              height: MediaQuery.of(context).size.height * 0.08,
              child: ListView.builder(
                itemCount: amIEnemyField
                    ? gameTableData.enemyReserve.length
                    : gameTableData.ownReserve.length,
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
                            ? getEnemyReserveImage(index)
                            : getOwnReserveImage(index)),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              width: getThirdWidth(),
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
                ? 'Tartalék: ${gameTableData.enemyReserve.length}'
                : 'Tartalék: ${gameTableData.ownReserve.length}',
            style: TextStyle(
              color: Colors.lightBlue[900],
              fontSize: MediaQuery.of(context).size.height * 0.01,
            ))
      ],
    );
  }

  String getEnemyReserveImage(int index) {
    if (ruleSetService.canISeeEnemyReserve &&
        gameTableData.enemyReserve.length > 0) {
      return gameTableData.enemyReserve[index].url;
    } else if (!ruleSetService.canISeeEnemyReserve &&
        gameTableData.enemyReserve.length > 0) {
      return 'assets/hatlap.jpg';
    } else if (!ruleSetService.canISeeEnemyReserve &&
        gameTableData.enemyReserve.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else if (ruleSetService.canISeeEnemyReserve &&
        gameTableData.enemyReserve.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else {
      return 'assets/card_placeholder.jpg';
    }
  }

  String getOwnReserveImage(int index) {
    if (ruleSetService.canISeeOwnReserve &&
        gameTableData.ownReserve.length > 0) {
      return gameTableData.ownReserve[index].url;
    } else if (!ruleSetService.canISeeOwnReserve &&
        gameTableData.ownReserve.length > 0) {
      return 'assets/hatlap.jpg';
    } else if (!ruleSetService.canISeeOwnReserve &&
        gameTableData.ownReserve.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else if (ruleSetService.canISeeOwnReserve &&
        gameTableData.ownReserve.length == 0) {
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
                      ? getEnemyReserveImage(index)
                      : getOwnReserveImage(index))),
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
      return ruleSetService.canISeeEnemyReserve
          ? 'Kiválasztott kártya:\n ${gameTableData.enemyReserve[selectedCard].name}'
          : 'Kiválasztott kártya:\n ${selectedCard + 1}. kártya';
    } else {
      return ruleSetService.canISeeOwnReserve
          ? 'Kiválasztott kártya:\n ${gameTableData.ownReserve[selectedCard].name}'
          : 'Kiválasztott kártya:\n ${selectedCard + 1}. kártya';
    }
  }

  double getFirstWidth() {
    if (amIEnemyField) {
      return gameTableData.enemyReserve.length < 4
          ? MediaQuery.of(context).size.width *
              0.13 *
              gameTableData.enemyReserve.length
          : MediaQuery.of(context).size.width * 0.92;
    } else {
      return gameTableData.ownReserve.length < 4
          ? MediaQuery.of(context).size.width *
              0.13 *
              gameTableData.ownReserve.length
          : MediaQuery.of(context).size.width * 0.92;
    }
  }

  double getSecondWidth(int index) {
    if (amIEnemyField) {
      return index < gameTableData.enemyReserve.length
          ? MediaQuery.of(context).size.width * 0.015
          : 0.0;
    } else {
      return index < gameTableData.ownReserve.length
          ? MediaQuery.of(context).size.width * 0.015
          : 0.0;
    }
  }

  double getThirdWidth() {
    if (amIEnemyField) {
      return gameTableData.enemyReserve.length > 0
          ? MediaQuery.of(context).size.width * 0.015
          : 0.0;
    } else {
      return gameTableData.ownReserve.length > 0
          ? MediaQuery.of(context).size.width * 0.015
          : 0.0;
    }
  }

  double getFourthWidth(int value) {
    if (amIEnemyField) {
      return gameTableData.enemyReserve.length <= value
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    } else {
      return gameTableData.ownReserve.length <= value
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    }
  }
}
