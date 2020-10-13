import 'package:flutter/material.dart';
import 'package:hkk/service/single_play/game_table_data.dart';
import 'package:hkk/service/single_play/rule_set_service.dart';

class OtherField extends StatefulWidget {
  bool amIEnemyField;
  GameTableData gameTableData;
  RuleSetService ruleSetService;

  OtherField({
    this.ruleSetService,
    this.gameTableData,
    this.amIEnemyField,
  });

  @override
  _OtherFieldState createState() => _OtherFieldState(
        ruleSetService: ruleSetService,
        gameTableData: gameTableData,
        amIEnemyField: amIEnemyField,
      );
}

class _OtherFieldState extends State<OtherField> {
  RuleSetService ruleSetService;
  GameTableData gameTableData;
  bool amIEnemyField;

  int selectedCard;

  _OtherFieldState(
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
                    ? gameTableData.enemyOther.length
                    : gameTableData.ownOther.length,
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
                            ? getEnemyOtherImage(index)
                            : getOwnOtherImage(index)),
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
                ? 'Egyéb: ${gameTableData.enemyOther.length}'
                : 'Egyéb: ${gameTableData.ownOther.length}',
            style: TextStyle(
              color: Colors.lightBlue[900],
              fontSize: MediaQuery.of(context).size.height * 0.01,
            ))
      ],
    );
  }

  String getEnemyOtherImage(int index) {
    if (ruleSetService.canISeeEnemyOther &&
        gameTableData.enemyOther.length > 0) {
      return gameTableData.enemyOther[index].url;
    } else if (!ruleSetService.canISeeEnemyOther &&
        gameTableData.enemyOther.length > 0) {
      return 'assets/hatlap.jpg';
    } else if (!ruleSetService.canISeeEnemyOther &&
        gameTableData.enemyOther.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else if (ruleSetService.canISeeEnemyOther &&
        gameTableData.enemyOther.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else {
      return 'assets/card_placeholder.jpg';
    }
  }

  String getOwnOtherImage(int index) {
    if (ruleSetService.canISeeOwnOther && gameTableData.ownOther.length > 0) {
      return gameTableData.ownOther[index].url;
    } else if (!ruleSetService.canISeeOwnOther &&
        gameTableData.ownOther.length > 0) {
      return 'assets/hatlap.jpg';
    } else if (!ruleSetService.canISeeOwnOther &&
        gameTableData.ownOther.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else if (ruleSetService.canISeeOwnOther &&
        gameTableData.ownOther.length == 0) {
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
                      ? getEnemyOtherImage(index)
                      : getOwnOtherImage(index))),
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
      return ruleSetService.canISeeEnemyOther
          ? 'Kiválasztott kártya:\n ${gameTableData.enemyOther[selectedCard].name}'
          : 'Kiválasztott kártya:\n ${selectedCard + 1}. kártya';
    } else {
      return ruleSetService.canISeeOwnOther
          ? 'Kiválasztott kártya:\n ${gameTableData.ownOther[selectedCard].name}'
          : 'Kiválasztott kártya:\n ${selectedCard + 1}. kártya';
    }
  }

  double getFirstWidth() {
    if (amIEnemyField) {
      return gameTableData.enemyOther.length < 4
          ? MediaQuery.of(context).size.width *
              0.13 *
              gameTableData.enemyOther.length
          : MediaQuery.of(context).size.width * 0.52;
    } else {
      return gameTableData.ownOther.length < 4
          ? MediaQuery.of(context).size.width *
              0.13 *
              gameTableData.ownOther.length
          : MediaQuery.of(context).size.width * 0.52;
    }
  }

  double getSecondWidth(int index) {
    if (amIEnemyField) {
      return index < gameTableData.enemyOther.length
          ? MediaQuery.of(context).size.width * 0.015
          : 0.0;
    } else {
      return index < gameTableData.ownOther.length
          ? MediaQuery.of(context).size.width * 0.015
          : 0.0;
    }
  }

  double getThirdWidth() {
    if (amIEnemyField) {
      return gameTableData.enemyOther.length > 0
          ? MediaQuery.of(context).size.width * 0.015
          : 0.0;
    } else {
      return gameTableData.ownOther.length > 0
          ? MediaQuery.of(context).size.width * 0.015
          : 0.0;
    }
  }

  double getFourthWidth(int value) {
    if (amIEnemyField) {
      return gameTableData.enemyOther.length <= value
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    } else {
      return gameTableData.ownOther.length <= value
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    }
  }
}
