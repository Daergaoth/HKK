import 'package:flutter/material.dart';
import 'package:hkk/service/single_play/game_table_data.dart';
import 'package:hkk/service/single_play/rule_set_service.dart';

class NothingnessField extends StatefulWidget {
  RuleSetService ruleSetService;
  GameTableData gameTableData;
  bool amIEnemyField;

  NothingnessField(
      {this.gameTableData, this.ruleSetService, this.amIEnemyField});

  @override
  _NothingnessFieldState createState() => _NothingnessFieldState(
      ruleSetService: ruleSetService,
      gameTableData: gameTableData,
      amIEnemyField: amIEnemyField);
}

class _NothingnessFieldState extends State<NothingnessField> {
  RuleSetService ruleSetService;
  GameTableData gameTableData;
  bool amIEnemyField;

  int selectedCard;

  _NothingnessFieldState(
      {this.gameTableData, this.ruleSetService, this.amIEnemyField});

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
                    ? gameTableData.enemyNothingness.length
                    : gameTableData.ownNothingness.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  // print(gameTableData.ownNothingness.length);
                  return Row(
                    children: [
                      SizedBox(
                        width: getThirdWidth(index),
                      ),
                      InkWell(
                        onTap: () {
                          cardTapped(index);
                        },
                        child: Image.asset(amIEnemyField
                            ? getEnemyNothingnessImage(index)
                            : getOwnNothingnessImage(index)),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              width: getSecondWidth(),
              height: MediaQuery.of(context).size.height * 0.08,
              child: Image.asset('assets/card_placeholder.jpg'),
            ),
          ],
        ),
        Text(
            amIEnemyField
                ? 'Semmi: ${gameTableData.enemyNothingness.length}'
                : 'Semmi: ${gameTableData.ownNothingness.length}',
            style: TextStyle(
              color: Colors.lightBlue[900],
              fontSize: MediaQuery.of(context).size.height * 0.01,
            ))
      ],
    );
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
                      ? getEnemyNothingnessImage(index)
                      : getOwnNothingnessImage(selectedCard))),
              // RaisedButton(
              //   onPressed: () {
              //     //TODO: Ezt még ki kell találni.
              //   },
              //   child: Text('Kijátszás'),
              //   color: Color.fromRGBO(0, 0, 0, 0.0),
              // ),
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

  String getOwnNothingnessImage(int index) {
    if (ruleSetService.canISeeOwnNothingness &&
        gameTableData.ownNothingness.length > 0) {
      return gameTableData.ownNothingness[index].url;
    } else if (!ruleSetService.canISeeOwnNothingness &&
        gameTableData.ownNothingness.length > 0) {
      return 'assets/hatlap.jpg';
    } else if (!ruleSetService.canISeeOwnNothingness &&
        gameTableData.ownNothingness.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else if (ruleSetService.canISeeOwnNothingness &&
        gameTableData.ownNothingness.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else {
      return 'assets/card_placeholder.jpg';
    }
  }

  String getEnemyNothingnessImage(int index) {
    if (ruleSetService.canISeeEnemyNothingness &&
        gameTableData.enemyNothingness.length > 0) {
      return gameTableData.enemyNothingness[index].url;
    } else if (!ruleSetService.canISeeEnemyNothingness &&
        gameTableData.enemyNothingness.length > 0) {
      return 'assets/hatlap.jpg';
    } else if (!ruleSetService.canISeeEnemyNothingness &&
        gameTableData.enemyNothingness.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else if (ruleSetService.canISeeEnemyNothingness &&
        gameTableData.enemyNothingness.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else {
      return 'assets/card_placeholder.jpg';
    }
  }

  String getCardName() {
    if (amIEnemyField) {
      return ruleSetService.canISeeEnemyNothingness
          ? 'Kiválasztott kártya:\n ${gameTableData.enemyNothingness[selectedCard].name}'
          : 'Kiválasztott kártya:\n ${selectedCard + 1}. kártya';
    } else {
      return ruleSetService.canISeeOwnNothingness
          ? 'Kiválasztott kártya:\n ${gameTableData.ownNothingness[selectedCard].name}'
          : 'Kiválasztott kártya:\n ${selectedCard + 1}. kártya';
    }
  }

  double getFirstWidth() {
    if (amIEnemyField) {
      return gameTableData.enemyNothingness.length > 0
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    } else {
      return gameTableData.ownNothingness.length > 0
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    }
  }

  double getSecondWidth() {
    if (amIEnemyField) {
      return gameTableData.enemyNothingness.length == 0
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    } else {
      return gameTableData.ownNothingness.length == 0
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    }
  }

  double getThirdWidth(int index) {
    if (amIEnemyField) {
      return index < gameTableData.enemyNothingness.length
          ? MediaQuery.of(context).size.width * 0.01
          : 0.0;
    } else {
      return index < gameTableData.ownNothingness.length
          ? MediaQuery.of(context).size.width * 0.01
          : 0.0;
    }
  }
}
