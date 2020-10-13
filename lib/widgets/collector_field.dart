import 'package:flutter/material.dart';
import 'package:hkk/service/single_play/game_table_data.dart';
import 'package:hkk/service/single_play/rule_set_service.dart';

class CollectorField extends StatefulWidget {
  RuleSetService ruleSetService;
  GameTableData gameTableData;
  bool amIEnemyField;

  CollectorField({this.gameTableData, this.ruleSetService, this.amIEnemyField});

  @override
  _CollectorFieldState createState() => _CollectorFieldState(
      ruleSetService: ruleSetService,
      gameTableData: gameTableData,
      amIEnemyField: amIEnemyField);
}

class _CollectorFieldState extends State<CollectorField> {
  RuleSetService ruleSetService;
  GameTableData gameTableData;
  bool amIEnemyField;

  int selectedCard;

  _CollectorFieldState(
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
                    ? gameTableData.enemyCollector.length
                    : gameTableData.ownCollector.length,
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
                            ? getEnemyCollectorImage(index)
                            : getOwnCollectorImage(index)),
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
                ? 'Gyüjtő: ${gameTableData.enemyCollector.length}'
                : 'Gyüjtő: ${gameTableData.ownCollector.length}',
            style: TextStyle(
              color: Colors.lightBlue[900],
              fontSize: MediaQuery.of(context).size.height * 0.01,
            ))
      ],
    );
  }

  String getCardName() {
    if (amIEnemyField) {
      return ruleSetService.canISeeEnemyCollector
          ? 'Kiválasztott kártya:\n ${gameTableData.enemyCollector[selectedCard].name}'
          : 'Kiválasztott kártya:\n ${selectedCard + 1}. kártya';
    } else {
      return ruleSetService.canISeeOwnCollector
          ? 'Kiválasztott kártya:\n ${gameTableData.ownCollector[selectedCard].name}'
          : 'Kiválasztott kártya:\n ${selectedCard + 1}. kártya';
    }
  }

  double getFirstWidth() {
    if (amIEnemyField) {
      return gameTableData.enemyCollector.length > 0
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    } else {
      return gameTableData.ownCollector.length > 0
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    }
  }

  double getSecondWidth() {
    if (amIEnemyField) {
      return gameTableData.enemyCollector.length == 0
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    } else {
      return gameTableData.ownCollector.length == 0
          ? MediaQuery.of(context).size.width * 0.13
          : 0.0;
    }
  }

  double getThirdWidth(int index) {
    if (amIEnemyField) {
      return index < gameTableData.enemyCollector.length
          ? MediaQuery.of(context).size.width * 0.01
          : 0.0;
    } else {
      return index < gameTableData.ownCollector.length
          ? MediaQuery.of(context).size.width * 0.01
          : 0.0;
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
                      ? getEnemyCollectorImage(index)
                      : getOwnCollectorImage(selectedCard))),
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
          // alertOpened = true;
          return alertDialog;
        });
  }

  String getOwnCollectorImage(int index) {
    if (ruleSetService.canISeeOwnCollector &&
        gameTableData.ownCollector.length > 0) {
      return gameTableData.ownCollector[index].url;
    } else if (!ruleSetService.canISeeOwnCollector &&
        gameTableData.ownCollector.length > 0) {
      return 'assets/hatlap.jpg';
    } else if (!ruleSetService.canISeeOwnCollector &&
        gameTableData.ownCollector.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else if (ruleSetService.canISeeOwnCollector &&
        gameTableData.ownCollector.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else {
      return 'assets/card_placeholder.jpg';
    }
  }

  String getEnemyCollectorImage(int index) {
    if (ruleSetService.canISeeEnemyCollector &&
        gameTableData.enemyCollector.length > 0) {
      return gameTableData.enemyCollector[index].url;
    } else if (!ruleSetService.canISeeEnemyCollector &&
        gameTableData.enemyCollector.length > 0) {
      return 'assets/hatlap.jpg';
    } else if (!ruleSetService.canISeeEnemyCollector &&
        gameTableData.enemyCollector.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else if (ruleSetService.canISeeEnemyCollector &&
        gameTableData.enemyCollector.length == 0) {
      return 'assets/card_placeholder.jpg';
    } else {
      return 'assets/card_placeholder.jpg';
    }
  }
}
