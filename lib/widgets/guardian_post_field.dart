import 'package:flutter/material.dart';
import 'package:hkk/service/single_play/game_table_data.dart';
import 'package:hkk/service/single_play/rule_set_service.dart';

class GuardianPostField extends StatefulWidget {
  bool amIEnemyField;
  GameTableData gameTableData;
  RuleSetService ruleSetService;

  GuardianPostField({
    this.ruleSetService,
    this.gameTableData,
    this.amIEnemyField,
  });

  @override
  _GuardianPostFieldState createState() => _GuardianPostFieldState(
        ruleSetService: ruleSetService,
        gameTableData: gameTableData,
        amIEnemyField: amIEnemyField,
      );
}

class _GuardianPostFieldState extends State<GuardianPostField> {
  RuleSetService ruleSetService;
  GameTableData gameTableData;
  bool amIEnemyField;

  int selectedCard;

  _GuardianPostFieldState(
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
                    ? gameTableData.enemyGuardianPost.length
                    : gameTableData.ownGuardianPost.length,
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
                            ? getEnemyGuardianPostImage(index)
                            : getOwnGuardianPostImage(index)),
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
                ? 'Őrposzt: ${gameTableData.enemyGuardianPost.length}'
                : 'Őrposzt: ${gameTableData.ownGuardianPost.length}',
            style: TextStyle(
              color: Colors.lightBlue[900],
              fontSize: MediaQuery.of(context).size.height * 0.01,
            ))
      ],
    );
  }

  String getEnemyGuardianPostImage(int index) {
    if (ruleSetService.canISeeEnemyGuardianPost &&
        gameTableData.enemyGuardianPost.length > 0) {
      return gameTableData.enemyGuardianPost[index].url;
    } else if (!ruleSetService.canISeeEnemyGuardianPost &&
        gameTableData.enemyGuardianPost.length > 0) {
      return 'assets/hatlap.jpg';
    } else if (!ruleSetService.canISeeEnemyGuardianPost &&
        gameTableData.enemyGuardianPost.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else if (ruleSetService.canISeeEnemyGuardianPost &&
        gameTableData.enemyGuardianPost.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else {
      return 'assets/card_placeholder.jpg';
    }
  }

  String getOwnGuardianPostImage(int index) {
    if (ruleSetService.canISeeOwnGuardianPost &&
        gameTableData.ownGuardianPost.length > 0) {
      return gameTableData.ownGuardianPost[index].url;
    } else if (!ruleSetService.canISeeOwnGuardianPost &&
        gameTableData.ownGuardianPost.length > 0) {
      return 'assets/hatlap.jpg';
    } else if (!ruleSetService.canISeeOwnGuardianPost &&
        gameTableData.ownGuardianPost.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else if (ruleSetService.canISeeOwnGuardianPost &&
        gameTableData.ownGuardianPost.length == 0) {
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
                      ? getEnemyGuardianPostImage(index)
                      : getOwnGuardianPostImage(index))),
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
      return ruleSetService.canISeeEnemyGuardianPost
          ? 'Kiválasztott kártya:\n ${gameTableData.enemyGuardianPost[selectedCard].name}'
          : 'Kiválasztott kártya:\n ${selectedCard + 1}. kártya';
    } else {
      return ruleSetService.canISeeOwnGuardianPost
          ? 'Kiválasztott kártya:\n ${gameTableData.ownGuardianPost[selectedCard].name}'
          : 'Kiválasztott kártya:\n ${selectedCard + 1}. kártya';
    }
  }

  double getFirstWidth() {
    if (amIEnemyField) {
      return gameTableData.enemyOther.length < 3
          ? MediaQuery.of(context).size.width *
              0.13 *
              gameTableData.enemyOther.length
          : MediaQuery.of(context).size.width * 0.39;
    } else {
      return gameTableData.ownOther.length < 3
          ? MediaQuery.of(context).size.width *
              0.13 *
              gameTableData.ownOther.length
          : MediaQuery.of(context).size.width * 0.39;
    }
  }

  double getSecondWidth(int index) {
    if (amIEnemyField) {
      return index < gameTableData.enemyGuardianPost.length
          ? MediaQuery.of(context).size.width * 0.015
          : 0.0;
    } else {
      return index < gameTableData.ownGuardianPost.length
          ? MediaQuery.of(context).size.width * 0.015
          : 0.0;
    }
  }

  double getThirdWidth() {
    if (amIEnemyField) {
      return gameTableData.enemyGuardianPost.length > 0
          ? MediaQuery.of(context).size.width * 0.015
          : 0.0;
    } else {
      return gameTableData.ownGuardianPost.length > 0
          ? MediaQuery.of(context).size.width * 0.015
          : 0.0;
    }
  }

  double getFourthWidth(int value) {
    if (amIEnemyField) {
      return gameTableData.enemyGuardianPost.length <= value
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    } else {
      return gameTableData.ownGuardianPost.length <= value
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    }
  }
}
