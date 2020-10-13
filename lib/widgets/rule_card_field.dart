import 'package:flutter/material.dart';
import 'package:hkk/service/single_play/game_table_data.dart';
import 'package:hkk/service/single_play/rule_set_service.dart';

class RuleCardField extends StatefulWidget {
  RuleSetService ruleSetService;
  GameTableData gameTableData;
  bool amIEnemyField;

  RuleCardField({this.ruleSetService, this.gameTableData, this.amIEnemyField});

  @override
  _RuleCardFieldState createState() => _RuleCardFieldState(
      ruleSetService: ruleSetService,
      gameTableData: gameTableData,
      amIEnemyField: amIEnemyField);
}

class _RuleCardFieldState extends State<RuleCardField> {
  RuleSetService ruleSetService;
  GameTableData gameTableData;
  bool amIEnemyField;

  int selectedCard;

  _RuleCardFieldState(
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
                    ? gameTableData.enemyRuleCard.length
                    : gameTableData.ownRuleCard.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
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
                            ? getEnemyRuleCardImage(index)
                            : getOwnRuleCardImage(index)),
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
                ? 'Szabálylap: ${gameTableData.enemyRuleCard.length}'
                : 'Szabályalap: ${gameTableData.ownRuleCard.length}',
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
                      ? getEnemyRuleCardImage(index)
                      : getOwnRuleCardImage(index))),
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

  String getOwnRuleCardImage(int index) {
    if (ruleSetService.canISeeOwnRuleCard &&
        gameTableData.ownRuleCard.length > 0) {
      return gameTableData.ownRuleCard[index].url;
    } else if (!ruleSetService.canISeeOwnRuleCard &&
        gameTableData.ownRuleCard.length > 0) {
      return 'assets/hatlap.jpg';
    } else if (!ruleSetService.canISeeOwnRuleCard &&
        gameTableData.ownRuleCard.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else if (ruleSetService.canISeeOwnRuleCard &&
        gameTableData.ownRuleCard.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else {
      return 'assets/card_placeholder.jpg';
    }
  }

  String getEnemyRuleCardImage(int index) {
    if (ruleSetService.canISeeEnemyRuleCard &&
        gameTableData.enemyRuleCard.length > 0) {
      return gameTableData.enemyRuleCard[index].url;
    } else if (!ruleSetService.canISeeEnemyRuleCard &&
        gameTableData.enemyRuleCard.length > 0) {
      return 'assets/hatlap.jpg';
    } else if (!ruleSetService.canISeeEnemyRuleCard &&
        gameTableData.enemyRuleCard.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else if (ruleSetService.canISeeEnemyRuleCard &&
        gameTableData.enemyRuleCard.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else {
      return 'assets/card_placeholder.jpg';
    }
  }

  String getCardName() {
    if (amIEnemyField) {
      return ruleSetService.canISeeEnemyRuleCard
          ? 'Kiválasztott kártya:\n ${gameTableData.enemyRuleCard[selectedCard].name}'
          : 'Kiválasztott kártya:\n ${selectedCard + 1}. kártya';
    } else {
      return ruleSetService.canISeeOwnRuleCard
          ? 'Kiválasztott kártya:\n ${gameTableData.ownRuleCard[selectedCard].name}'
          : 'Kiválasztott kártya:\n ${selectedCard + 1}. kártya';
    }
  }

  double getFirstWidth() {
    if (amIEnemyField) {
      return gameTableData.enemyRuleCard.length > 0
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    } else {
      return gameTableData.ownRuleCard.length > 0
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    }
  }

  double getSecondWidth() {
    if (amIEnemyField) {
      return gameTableData.enemyRuleCard.length == 0
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    } else {
      return gameTableData.ownRuleCard.length == 0
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    }
  }

  double getThirdWidth(int index) {
    if (amIEnemyField) {
      return index < gameTableData.enemyRuleCard.length
          ? MediaQuery.of(context).size.width * 0.01
          : 0.0;
    } else {
      return index < gameTableData.ownRuleCard.length
          ? MediaQuery.of(context).size.width * 0.01
          : 0.0;
    }
  }
}
