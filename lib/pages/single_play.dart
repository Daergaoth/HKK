import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hkk/service/single_play/card_list_service.dart';
import 'package:hkk/service/single_play/rule_set_service.dart';
import 'package:hkk/service/single_play/screen_rotate_service.dart';

class SinglePlay extends StatefulWidget {
  @override
  _SinglePlayState createState() => _SinglePlayState();
}

class _SinglePlayState extends State<SinglePlay> {
  RuleSetService ruleSetService;
  GameTableData gameTableData;

  bool enemyInDangerZone = false;

  // int enemyHP = 20;

  bool isScreenPortrait;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);

    ruleSetService = new RuleSetService(canISeeEnemyHand: true);
    gameTableData = new GameTableData(
        enemyHand: [
          'assets/angyali_kozbelepes.jpg',
          'assets/angyali_kozbelepes.jpg',
          'assets/angyali_kozbelepes.jpg',
          'assets/angyali_kozbelepes.jpg',
          'assets/angyali_kozbelepes.jpg'
        ],
        enemyHP: 20,
        enemyMaxHP: 20,
        enemyMana: 0,
        enemyMaxMana: 20,
        enemyName: 'Béla bá');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (width <= height && !ScreenRotateService.didIRotateScreen) {
      ScreenRotateService.didIRotateScreen = true;
      isScreenPortrait = true;
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    } else if (width > height && !ScreenRotateService.didIRotateScreen) {
      ScreenRotateService.didIRotateScreen = true;
      isScreenPortrait = false;
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(175, 155, 123, 1.0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.005),
          /**FIRST ROW: Enemy Column(HP/MAX HP/Mana/MAX Mana) - Column(Name, Cards in hand, "Enemy Deck" label)*/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.005),
              /**Column(HP/MAX HP/MANA/MAX MANA)*/
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.025,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: enemyInDangerZone ? Colors.red : Colors.green,
                      ),
                    ),
                    child: Text('ÉP: ${gameTableData.enemyHP}',
                        style: TextStyle(
                          color: enemyInDangerZone ? Colors.red : Colors.green,
                          fontSize: MediaQuery.of(context).size.height * 0.01,
                        )),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.025,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: enemyInDangerZone ? Colors.red : Colors.green,
                      ),
                    ),
                    child: Text('Max ÉP: ${gameTableData.enemyMaxHP}',
                        style: TextStyle(
                          color: enemyInDangerZone ? Colors.red : Colors.green,
                          fontSize: MediaQuery.of(context).size.height * 0.01,
                        )),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.025,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: enemyInDangerZone ? Colors.red : Colors.green,
                      ),
                    ),
                    child: Text('Mana: ${gameTableData.enemyMana}',
                        style: TextStyle(
                          color: enemyInDangerZone ? Colors.red : Colors.green,
                          fontSize: MediaQuery.of(context).size.height * 0.01,
                        )),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.025,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: enemyInDangerZone ? Colors.red : Colors.green,
                      ),
                    ),
                    child: Text('Max Mana: ${gameTableData.enemyMaxMana}',
                        style: TextStyle(
                          color: enemyInDangerZone ? Colors.red : Colors.green,
                          fontSize: MediaQuery.of(context).size.height * 0.01,
                        )),
                  )
                  // ),
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.005),
              /**ENEMY HAND*/

              Column(
                children: [
                  Text('${gameTableData.enemyName}',
                      style: TextStyle(
                        color: Colors.lightBlue[900],
                        fontSize: MediaQuery.of(context).size.height * 0.01,
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: ListView.builder(
                      itemCount: gameTableData.enemyHand.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        // print(enemyHand.length);
                        return Row(
                          children: [
                            SizedBox(
                              width: index < gameTableData.enemyHand.length
                                  ? MediaQuery.of(context).size.width * 0.015
                                  : 0.0,
                            ),
                            Image.asset(ruleSetService.canISeeEnemyHand
                                ? '${gameTableData.enemyHand[index]}'
                                : 'assets/hatlap.jpg'),
                          ],
                        );
                      },
                    ),
                  ),
                  Text('Enemy Deck',
                      style: TextStyle(
                        color: Colors.lightBlue[900],
                        fontSize: MediaQuery.of(context).size.height * 0.01,
                      ))
                ],
              ),
              /**PLACEHOLDER*/
              // SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
            ],
          ),
          /**PLACEHOLDER*/
          SizedBox(height: MediaQuery.of(context).size.height * 0.87),
        ],
      ),
    );
  }
}
