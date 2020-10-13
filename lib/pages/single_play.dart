import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hkk/dto/card.dart';
import 'package:hkk/service/single_play/game_table_data.dart';
import 'package:hkk/service/single_play/rule_set_service.dart';
import 'package:hkk/service/single_play/screen_rotate_service.dart';
import 'package:hkk/widgets/collector_field.dart';
import 'package:hkk/widgets/data_field.dart';
import 'package:hkk/widgets/deck_field.dart';
import 'package:hkk/widgets/follower_field.dart';
import 'package:hkk/widgets/guardian_post_field.dart';
import 'package:hkk/widgets/hand_field.dart';
import 'package:hkk/widgets/nothingness_field.dart';
import 'package:hkk/widgets/other_field.dart';
import 'package:hkk/widgets/reserve_field.dart';
import 'package:hkk/widgets/rule_card_field.dart';

class SinglePlay extends StatefulWidget {
  @override
  _SinglePlayState createState() => _SinglePlayState();
}

class _SinglePlayState extends State<SinglePlay> {
  RuleSetService ruleSetService;
  GameTableData gameTableData;

  // bool enemyInDangerZone = false;

  // int enemyHP = 20;

  bool isScreenPortrait;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    initTableAndRules();

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
              SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.005),
              /**Column(HP/MAX HP/MANA/MAX MANA)*/
              SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.005),
              /**ENEMY HAND*/
              HandField(
                ruleSetService: ruleSetService,
                gameTableData: gameTableData,
                amIEnemyField: true,
              ),
              /**PLACEHOLDER*/
              // SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
            ],
          ),
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .height * 0.005),
          /**SECOND ROW: Enemy( Column(Deck) Column(Collector) Column(Nothingness) Column(Row(Other)))*/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /**Enemy Deck*/
              DeckField(
                  gameTableData: gameTableData,
                  ruleSetService: ruleSetService,
                  amIEnemyField: true),
              SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.005),
              /**Enemy Collector*/
              CollectorField(
                  gameTableData: gameTableData,
                  ruleSetService: ruleSetService,
                  amIEnemyField: true),
              SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.005),
              /**Enemy Nothingness*/
              NothingnessField(
                  gameTableData: gameTableData,
                  ruleSetService: ruleSetService,
                  amIEnemyField: true),
              SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.005),
              /**Enemy Other*/
              OtherField(
                  gameTableData: gameTableData,
                  ruleSetService: ruleSetService,
                  amIEnemyField: true),
              SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.005),
            ],
          ),
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .height * 0.005),
          /**Third ROW: Enemy Reserve Field*/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.005),
              ReserveField(
                  gameTableData: gameTableData,
                  ruleSetService: ruleSetService,
                  amIEnemyField: true
              ),
            ],
          ),
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .height * 0.005),
          /**FURTH ROW: Enemy (Guardian post, rule card, follower) */
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.005),
              DataField(
                HP: gameTableData.enemyHP,
                isInDangerZone: gameTableData.enemyInDangerZone,
                Mana: gameTableData.enemyMana,
                MaxHP: gameTableData.enemyMaxHP,
                MaxMana: gameTableData.enemyMaxMana,
              ),
              GuardianPostField(
                  gameTableData: gameTableData,
                  ruleSetService: ruleSetService,
                  amIEnemyField: true
              ),
              RuleCardField(
                  gameTableData: gameTableData,
                  ruleSetService: ruleSetService,
                  amIEnemyField: true
              ),
              FollowerField(
                  gameTableData: gameTableData,
                  ruleSetService: ruleSetService,
                  amIEnemyField: true
              )
            ],
          ),
          Divider(
            thickness: 5.0,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.005),
              /**OWN Guardian etc.*/
              DataField(
                HP: gameTableData.ownHP,
                isInDangerZone: gameTableData.ownInDangerZone,
                Mana: gameTableData.ownMana,
                MaxHP: gameTableData.ownMaxHP,
                MaxMana: gameTableData.ownMaxMana,
              ),
              GuardianPostField(
                  gameTableData: gameTableData,
                  ruleSetService: ruleSetService,
                  amIEnemyField: false
              ),
              RuleCardField(
                  gameTableData: gameTableData,
                  ruleSetService: ruleSetService,
                  amIEnemyField: false
              ),
              FollowerField(
                  gameTableData: gameTableData,
                  ruleSetService: ruleSetService,
                  amIEnemyField: false
              )
            ],),
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .height * 0.005),
          /**OWN Reserve*/
          Row(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.005),
              ReserveField(
                  gameTableData: gameTableData,
                  ruleSetService: ruleSetService,
                  amIEnemyField: false
              ),
            ],),
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .height * 0.005),
          /**OWN Deck etc*/
          Row(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /**Own Deck*/
              DeckField(
                  gameTableData: gameTableData,
                  ruleSetService: ruleSetService,
                  amIEnemyField: false),
              SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.005),
              /**Own Collector*/
              CollectorField(
                  gameTableData: gameTableData,
                  ruleSetService: ruleSetService,
                  amIEnemyField: false),
              SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.005),
              /**Own Nothingness*/
              NothingnessField(
                  gameTableData: gameTableData,
                  ruleSetService: ruleSetService,
                  amIEnemyField: false),
              SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.005),
              /**Own Other*/
              OtherField(
                  gameTableData: gameTableData,
                  ruleSetService: ruleSetService,
                  amIEnemyField: false),
              SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.005),
            ],),
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .height * 0.005),
          /**OWN Hand*/
          Row(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.005),
              /**Column(HP/MAX HP/MANA/MAX MANA)*/
              SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.005),
              /**Own HAND*/
              HandField(
                ruleSetService: ruleSetService,
                gameTableData: gameTableData,
                amIEnemyField: false,
              ),
              /**PLACEHOLDER*/
              // SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
            ],),
        ],
      ),
    );
  }

  void initTableAndRules() {
    initRules();
    initTable();
  }

  initRules() {
    ruleSetService = new RuleSetService(
        canISeeEnemyHand: true,
        canISeeEnemyDeck: true,
        canISeeEnemyCollector: true,
        canISeeEnemyNothingness: true,
        canISeeOwnDeck: true,
        canISeeEnemyOther: true,
        canISeeOwnOther: true,
        canISeeEnemyReserve: true,
        canISeeOwnCollector: true,
        canISeeOwnHand: true,
        canISeeOwnNothingness: true,
        canISeeOwnReserve: true,
        canISeeEnemyGuardianPost: true,
        canISeeOwnGuardianPost: true,
        canISeeEnemyRuleCard: true,
        canISeeOwnRuleCard: true,
        canISeeEnemyFollower: true,
        canISeeOwnFollower: true
    );
  }

  void initTable() {
    gameTableData = new GameTableData(
        enemyHand: [
          new CardObject(url: 'assets/angyali_kozbelepes.jpg',
              isRotated: false,
              name: 'Angyali közbelépés'),
          new CardObject(url: 'assets/angyali_kozbelepes.jpg',
              isRotated: false,
              name: 'Angyali közbelépés'),
          new CardObject(url: 'assets/angyali_kozbelepes.jpg',
              isRotated: false,
              name: 'Angyali közbelépés'),
          new CardObject(url: 'assets/angyali_kozbelepes.jpg',
              isRotated: false,
              name: 'Angyali közbelépés'),
          new CardObject(url: 'assets/angyali_kozbelepes.jpg',
              isRotated: false,
              name: 'Angyali közbelépés'),
          new CardObject(url: 'assets/angyali_kozbelepes.jpg',
              isRotated: false,
              name: 'Angyali közbelépés'),
          new CardObject(url: 'assets/angyali_kozbelepes.jpg',
              isRotated: false,
              name: 'Angyali közbelépés'),
          new CardObject(url: 'assets/angyali_kozbelepes.jpg',
              isRotated: false,
              name: 'Angyali közbelépés'),
          new CardObject(url: 'assets/angyali_kozbelepes.jpg',
              isRotated: false,
              name: 'Angyali közbelépés'),
        ],
        enemyDeck: [
          new CardObject(url: 'assets/a_boseg_zavara.jpg',
              isRotated: false,
              name: 'A bőség zavara'),
          new CardObject(url: 'assets/a_boseg_zavara.jpg',
              isRotated: false,
              name: 'A bőség zavara'),
          new CardObject(url: 'assets/a_boseg_zavara.jpg',
              isRotated: false,
              name: 'A bőség zavara'),
          new CardObject(url: 'assets/a_boseg_zavara.jpg',
              isRotated: false,
              name: 'A bőség zavara'),
          new CardObject(url: 'assets/a_boseg_zavara.jpg',
              isRotated: false,
              name: 'A bőség zavara'),
          new CardObject(url: 'assets/a_boseg_zavara.jpg',
              isRotated: false,
              name: 'A bőség zavara'),
          new CardObject(url: 'assets/a_boseg_zavara.jpg',
              isRotated: false,
              name: 'A bőség zavara'),
          new CardObject(url: 'assets/a_boseg_zavara.jpg',
              isRotated: false,
              name: 'A bőség zavara'),
          new CardObject(url: 'assets/a_boseg_zavara.jpg',
              isRotated: false,
              name: 'A bőség zavara'),
          new CardObject(url: 'assets/a_boseg_zavara.jpg',
              isRotated: false,
              name: 'A bőség zavara'),
          new CardObject(url: 'assets/a_boseg_zavara.jpg',
              isRotated: false,
              name: 'A bőség zavara'),
          new CardObject(url: 'assets/a_boseg_zavara.jpg',
              isRotated: false,
              name: 'A bőség zavara'),
          new CardObject(url: 'assets/a_boseg_zavara.jpg',
              isRotated: false,
              name: 'A bőség zavara'),
          new CardObject(url: 'assets/a_boseg_zavara.jpg',
              isRotated: false,
              name: 'A bőség zavara'),
          new CardObject(url: 'assets/a_boseg_zavara.jpg',
              isRotated: false,
              name: 'A bőség zavara'),
          new CardObject(url: 'assets/a_boseg_zavara.jpg',
              isRotated: false,
              name: 'A bőség zavara'),
        ],
        enemyOther: [
          new CardObject(url: 'assets/apro_gombvillam.jpg',
              isRotated: false,
              name: 'Apró gömbvillám'),
          new CardObject(url: 'assets/apro_gombvillam.jpg',
              isRotated: false,
              name: 'Apró gömbvillám'),
          new CardObject(url: 'assets/apro_gombvillam.jpg',
              isRotated: false,
              name: 'Apró gömbvillám'),
          new CardObject(url: 'assets/apro_gombvillam.jpg',
              isRotated: false,
              name: 'Apró gömbvillám'),
          new CardObject(url: 'assets/apro_gombvillam.jpg',
              isRotated: false,
              name: 'Apró gömbvillám'),
          new CardObject(url: 'assets/apro_gombvillam.jpg',
              isRotated: false,
              name: 'Apró gömbvillám'),
          new CardObject(url: 'assets/apro_gombvillam.jpg',
              isRotated: false,
              name: 'Apró gömbvillám'),
          new CardObject(url: 'assets/apro_gombvillam.jpg',
              isRotated: false,
              name: 'Apró gömbvillám'),
          new CardObject(url: 'assets/apro_gombvillam.jpg',
              isRotated: false,
              name: 'Apró gömbvillám'),
          new CardObject(url: 'assets/apro_gombvillam.jpg',
              isRotated: false,
              name: 'Apró gömbvillám'),
          new CardObject(url: 'assets/apro_gombvillam.jpg',
              isRotated: false,
              name: 'Apró gömbvillám'),
          new CardObject(url: 'assets/apro_gombvillam.jpg',
              isRotated: false,
              name: 'Apró gömbvillám'),
          new CardObject(url: 'assets/apro_gombvillam.jpg',
              isRotated: false,
              name: 'Apró gömbvillám'),
          new CardObject(url: 'assets/apro_gombvillam.jpg',
              isRotated: false,
              name: 'Apró gömbvillám'),
          new CardObject(url: 'assets/apro_gombvillam.jpg',
              isRotated: false,
              name: 'Apró gömbvillám'),
          new CardObject(url: 'assets/apro_gombvillam.jpg',
              isRotated: false,
              name: 'Apró gömbvillám'),
        ],
        enemyCollector: [
          new CardObject(url: 'assets/az_angyalgarda_parancsnoka.jpg',
              isRotated: false,
              name: 'Az angyalgárda parancsnoka'),
          new CardObject(url: 'assets/az_angyalgarda_parancsnoka.jpg',
              isRotated: false,
              name: 'Az angyalgárda parancsnoka'),
          new CardObject(url: 'assets/az_angyalgarda_parancsnoka.jpg',
              isRotated: false,
              name: 'Az angyalgárda parancsnoka'),
          new CardObject(url: 'assets/az_angyalgarda_parancsnoka.jpg',
              isRotated: false,
              name: 'Az angyalgárda parancsnoka'),
          new CardObject(url: 'assets/az_angyalgarda_parancsnoka.jpg',
              isRotated: false,
              name: 'Az angyalgárda parancsnoka'),
          new CardObject(url: 'assets/az_angyalgarda_parancsnoka.jpg',
              isRotated: false,
              name: 'Az angyalgárda parancsnoka'),
          new CardObject(url: 'assets/az_angyalgarda_parancsnoka.jpg',
              isRotated: false,
              name: 'Az angyalgárda parancsnoka'),
          new CardObject(url: 'assets/az_angyalgarda_parancsnoka.jpg',
              isRotated: false,
              name: 'Az angyalgárda parancsnoka'),
          new CardObject(url: 'assets/az_angyalgarda_parancsnoka.jpg',
              isRotated: false,
              name: 'Az angyalgárda parancsnoka'),
          new CardObject(url: 'assets/az_angyalgarda_parancsnoka.jpg',
              isRotated: false,
              name: 'Az angyalgárda parancsnoka'),
          new CardObject(url: 'assets/az_angyalgarda_parancsnoka.jpg',
              isRotated: false,
              name: 'Az angyalgárda parancsnoka'),
          new CardObject(url: 'assets/az_angyalgarda_parancsnoka.jpg',
              isRotated: false,
              name: 'Az angyalgárda parancsnoka'),
        ],
        enemyNothingness: [
          new CardObject(url: 'assets/az_istenek_sohaja.jpg',
              isRotated: false,
              name: 'Az istenek sóhaja'),
          new CardObject(url: 'assets/az_istenek_sohaja.jpg',
              isRotated: false,
              name: 'Az istenek sóhaja'),
          new CardObject(url: 'assets/az_istenek_sohaja.jpg',
              isRotated: false,
              name: 'Az istenek sóhaja'),
          new CardObject(url: 'assets/az_istenek_sohaja.jpg',
              isRotated: false,
              name: 'Az istenek sóhaja'),
          new CardObject(url: 'assets/az_istenek_sohaja.jpg',
              isRotated: false,
              name: 'Az istenek sóhaja'),
          new CardObject(url: 'assets/az_istenek_sohaja.jpg',
              isRotated: false,
              name: 'Az istenek sóhaja'),
          new CardObject(url: 'assets/az_istenek_sohaja.jpg',
              isRotated: false,
              name: 'Az istenek sóhaja'),
          new CardObject(url: 'assets/az_istenek_sohaja.jpg',
              isRotated: false,
              name: 'Az istenek sóhaja'),
          new CardObject(url: 'assets/az_istenek_sohaja.jpg',
              isRotated: false,
              name: 'Az istenek sóhaja'),
          new CardObject(url: 'assets/az_istenek_sohaja.jpg',
              isRotated: false,
              name: 'Az istenek sóhaja'),
          new CardObject(url: 'assets/az_istenek_sohaja.jpg',
              isRotated: false,
              name: 'Az istenek sóhaja'),
          new CardObject(url: 'assets/az_istenek_sohaja.jpg',
              isRotated: false,
              name: 'Az istenek sóhaja'),
          new CardObject(url: 'assets/az_istenek_sohaja.jpg',
              isRotated: false,
              name: 'Az istenek sóhaja'),
          new CardObject(url: 'assets/az_istenek_sohaja.jpg',
              isRotated: false,
              name: 'Az istenek sóhaja'),
        ],
        enemyReserve: [
          new CardObject(url: 'assets/kezratetel.jpg',
              isRotated: false,
              name: 'Kézrátétel'),
          new CardObject(url: 'assets/kezratetel.jpg',
              isRotated: false,
              name: 'Kézrátétel'),
          new CardObject(url: 'assets/kezratetel.jpg',
              isRotated: false,
              name: 'Kézrátétel'),
          new CardObject(url: 'assets/kezratetel.jpg',
              isRotated: false,
              name: 'Kézrátétel'),
          new CardObject(url: 'assets/kezratetel.jpg',
              isRotated: false,
              name: 'Kézrátétel'),
          new CardObject(url: 'assets/kezratetel.jpg',
              isRotated: false,
              name: 'Kézrátétel'),
          new CardObject(url: 'assets/kezratetel.jpg',
              isRotated: false,
              name: 'Kézrátétel'),
          new CardObject(url: 'assets/kezratetel.jpg',
              isRotated: false,
              name: 'Kézrátétel'),
          new CardObject(url: 'assets/kezratetel.jpg',
              isRotated: false,
              name: 'Kézrátétel'),
          new CardObject(url: 'assets/kezratetel.jpg',
              isRotated: false,
              name: 'Kézrátétel'),
          new CardObject(url: 'assets/kezratetel.jpg',
              isRotated: false,
              name: 'Kézrátétel'),
          new CardObject(url: 'assets/kezratetel.jpg',
              isRotated: false,
              name: 'Kézrátétel'),
        ],
        enemyGuardianPost: [
          new CardObject(url: 'assets/raia_kovetoje.jpg',
              isRotated: false,
              name: 'Raia követője'),
          new CardObject(url: 'assets/raia_kovetoje.jpg',
              isRotated: false,
              name: 'Raia követője'),
          new CardObject(url: 'assets/raia_kovetoje.jpg',
              isRotated: false,
              name: 'Raia követője'),
          new CardObject(url: 'assets/raia_kovetoje.jpg',
              isRotated: false,
              name: 'Raia követője'),
          new CardObject(url: 'assets/raia_kovetoje.jpg',
              isRotated: false,
              name: 'Raia követője'),
          new CardObject(url: 'assets/raia_kovetoje.jpg',
              isRotated: false,
              name: 'Raia követője'),
          new CardObject(url: 'assets/raia_kovetoje.jpg',
              isRotated: false,
              name: 'Raia követője'),
          new CardObject(url: 'assets/raia_kovetoje.jpg',
              isRotated: false,
              name: 'Raia követője'),
          new CardObject(url: 'assets/raia_kovetoje.jpg',
              isRotated: false,
              name: 'Raia követője'),
          new CardObject(url: 'assets/raia_kovetoje.jpg',
              isRotated: false,
              name: 'Raia követője'),
        ],
        enemyRuleCard: [
          new CardObject(url: 'assets/sportszeruseg.jpg',
              isRotated: false,
              name: 'Sportszerűség'),
          new CardObject(url: 'assets/sportszeruseg.jpg',
              isRotated: false,
              name: 'Sportszerűség'),
          new CardObject(url: 'assets/sportszeruseg.jpg',
              isRotated: false,
              name: 'Sportszerűség'),
        ],
        enemyFollower: [
          new CardObject(url: 'assets/timera_makacskodasa.jpg',
              isRotated: false,
              name: 'Timéra makacskodása'),
          new CardObject(url: 'assets/timera_makacskodasa.jpg',
              isRotated: false,
              name: 'Timéra makacskodása'),
          new CardObject(url: 'assets/timera_makacskodasa.jpg',
              isRotated: false,
              name: 'Timéra makacskodása'),
        ],

        ownHand: [
          new CardObject(url: 'assets/baltazar_a_behemot.jpg',
              isRotated: false,
              name: 'Baltazár a behemót'),
          new CardObject(url: 'assets/baltazar_a_behemot.jpg',
              isRotated: false,
              name: 'Baltazár a behemót'),
          new CardObject(url: 'assets/baltazar_a_behemot.jpg',
              isRotated: false,
              name: 'Baltazár a behemót'),
          new CardObject(url: 'assets/baltazar_a_behemot.jpg',
              isRotated: false,
              name: 'Baltazár a behemót'),
          new CardObject(url: 'assets/baltazar_a_behemot.jpg',
              isRotated: false,
              name: 'Baltazár a behemót'),
          new CardObject(url: 'assets/baltazar_a_behemot.jpg',
              isRotated: false,
              name: 'Baltazár a behemót'),
          new CardObject(url: 'assets/baltazar_a_behemot.jpg',
              isRotated: false,
              name: 'Baltazár a behemót'),
          new CardObject(url: 'assets/baltazar_a_behemot.jpg',
              isRotated: false,
              name: 'Baltazár a behemót'),
          new CardObject(url: 'assets/baltazar_a_behemot.jpg',
              isRotated: false,
              name: 'Baltazár a behemót'),
          new CardObject(url: 'assets/baltazar_a_behemot.jpg',
              isRotated: false,
              name: 'Baltazár a behemót'),
          new CardObject(url: 'assets/baltazar_a_behemot.jpg',
              isRotated: false,
              name: 'Baltazár a behemót'),
          new CardObject(url: 'assets/baltazar_a_behemot.jpg',
              isRotated: false,
              name: 'Baltazár a behemót'),
          new CardObject(url: 'assets/baltazar_a_behemot.jpg',
              isRotated: false,
              name: 'Baltazár a behemót'),
          new CardObject(url: 'assets/baltazar_a_behemot.jpg',
              isRotated: false,
              name: 'Baltazár a behemót'),
        ],
        ownDeck: [
          new CardObject(url: 'assets/ezustsereg.jpg',
              isRotated: false,
              name: 'Ezüst sereg'),
          new CardObject(url: 'assets/ezustsereg.jpg',
              isRotated: false,
              name: 'Ezüst sereg'),
          new CardObject(url: 'assets/ezustsereg.jpg',
              isRotated: false,
              name: 'Ezüst sereg'),
          new CardObject(url: 'assets/ezustsereg.jpg',
              isRotated: false,
              name: 'Ezüst sereg'),
          new CardObject(url: 'assets/ezustsereg.jpg',
              isRotated: false,
              name: 'Ezüst sereg'),
          new CardObject(url: 'assets/ezustsereg.jpg',
              isRotated: false,
              name: 'Ezüst sereg'),
          new CardObject(url: 'assets/ezustsereg.jpg',
              isRotated: false,
              name: 'Ezüst sereg'),
          new CardObject(url: 'assets/ezustsereg.jpg',
              isRotated: false,
              name: 'Ezüst sereg'),
          new CardObject(url: 'assets/ezustsereg.jpg',
              isRotated: false,
              name: 'Ezüst sereg'),
          new CardObject(url: 'assets/ezustsereg.jpg',
              isRotated: false,
              name: 'Ezüst sereg'),
          new CardObject(url: 'assets/ezustsereg.jpg',
              isRotated: false,
              name: 'Ezüst sereg'),
          new CardObject(url: 'assets/ezustsereg.jpg',
              isRotated: false,
              name: 'Ezüst sereg'),
          new CardObject(url: 'assets/ezustsereg.jpg',
              isRotated: false,
              name: 'Ezüst sereg'),
          new CardObject(url: 'assets/ezustsereg.jpg',
              isRotated: false,
              name: 'Ezüst sereg'),
          new CardObject(url: 'assets/ezustsereg.jpg',
              isRotated: false,
              name: 'Ezüst sereg'),
          new CardObject(url: 'assets/ezustsereg.jpg',
              isRotated: false,
              name: 'Ezüst sereg'),
        ],
        ownCollector: [
          new CardObject(url: 'assets/hendiala_cselszovese.jpg',
              isRotated: false,
              name: 'Hendiala cselszövése'),
          new CardObject(url: 'assets/hendiala_cselszovese.jpg',
              isRotated: false,
              name: 'Hendiala cselszövése'),
          new CardObject(url: 'assets/hendiala_cselszovese.jpg',
              isRotated: false,
              name: 'Hendiala cselszövése'),
          new CardObject(url: 'assets/hendiala_cselszovese.jpg',
              isRotated: false,
              name: 'Hendiala cselszövése'),
          new CardObject(url: 'assets/hendiala_cselszovese.jpg',
              isRotated: false,
              name: 'Hendiala cselszövése'),
          new CardObject(url: 'assets/hendiala_cselszovese.jpg',
              isRotated: false,
              name: 'Hendiala cselszövése'),
          new CardObject(url: 'assets/hendiala_cselszovese.jpg',
              isRotated: false,
              name: 'Hendiala cselszövése'),
          new CardObject(url: 'assets/hendiala_cselszovese.jpg',
              isRotated: false,
              name: 'Hendiala cselszövése'),
          new CardObject(url: 'assets/hendiala_cselszovese.jpg',
              isRotated: false,
              name: 'Hendiala cselszövése'),
          new CardObject(url: 'assets/hendiala_cselszovese.jpg',
              isRotated: false,
              name: 'Hendiala cselszövése'),
          new CardObject(url: 'assets/hendiala_cselszovese.jpg',
              isRotated: false,
              name: 'Hendiala cselszövése'),
          new CardObject(url: 'assets/hendiala_cselszovese.jpg',
              isRotated: false,
              name: 'Hendiala cselszövése'),
          new CardObject(url: 'assets/hendiala_cselszovese.jpg',
              isRotated: false,
              name: 'Hendiala cselszövése'),
          new CardObject(url: 'assets/hendiala_cselszovese.jpg',
              isRotated: false,
              name: 'Hendiala cselszövése'),
          new CardObject(url: 'assets/hendiala_cselszovese.jpg',
              isRotated: false,
              name: 'Hendiala cselszövése'),
          new CardObject(url: 'assets/hendiala_cselszovese.jpg',
              isRotated: false,
              name: 'Hendiala cselszövése'),
          new CardObject(url: 'assets/hendiala_cselszovese.jpg',
              isRotated: false,
              name: 'Hendiala cselszövése'),
        ],
        ownNothingness: [
          new CardObject(
              url: 'assets/hogriff.jpg', isRotated: false, name: 'Hógriff'),
          new CardObject(
              url: 'assets/hogriff.jpg', isRotated: false, name: 'Hógriff'),
          new CardObject(
              url: 'assets/hogriff.jpg', isRotated: false, name: 'Hógriff'),
          new CardObject(
              url: 'assets/hogriff.jpg', isRotated: false, name: 'Hógriff'),
          new CardObject(
              url: 'assets/hogriff.jpg', isRotated: false, name: 'Hógriff'),
          new CardObject(
              url: 'assets/hogriff.jpg', isRotated: false, name: 'Hógriff'),
          new CardObject(
              url: 'assets/hogriff.jpg', isRotated: false, name: 'Hógriff'),
          new CardObject(
              url: 'assets/hogriff.jpg', isRotated: false, name: 'Hógriff'),
          new CardObject(
              url: 'assets/hogriff.jpg', isRotated: false, name: 'Hógriff'),
          new CardObject(
              url: 'assets/hogriff.jpg', isRotated: false, name: 'Hógriff'),
          new CardObject(
              url: 'assets/hogriff.jpg', isRotated: false, name: 'Hógriff'),
          new CardObject(
              url: 'assets/hogriff.jpg', isRotated: false, name: 'Hógriff'),
          new CardObject(
              url: 'assets/hogriff.jpg', isRotated: false, name: 'Hógriff'),
          new CardObject(
              url: 'assets/hogriff.jpg', isRotated: false, name: 'Hógriff'),
          new CardObject(
              url: 'assets/hogriff.jpg', isRotated: false, name: 'Hógriff'),
          new CardObject(
              url: 'assets/hogriff.jpg', isRotated: false, name: 'Hógriff'),
        ],
        ownOther: [
          new CardObject(
              url: 'assets/hoparduc.jpg', isRotated: false, name: 'Hópárduc'),
          new CardObject(
              url: 'assets/hoparduc.jpg', isRotated: false, name: 'Hópárduc'),
          new CardObject(
              url: 'assets/hoparduc.jpg', isRotated: false, name: 'Hópárduc'),
          new CardObject(
              url: 'assets/hoparduc.jpg', isRotated: false, name: 'Hópárduc'),
          new CardObject(
              url: 'assets/hoparduc.jpg', isRotated: false, name: 'Hópárduc'),
          new CardObject(
              url: 'assets/hoparduc.jpg', isRotated: false, name: 'Hópárduc'),
          new CardObject(
              url: 'assets/hoparduc.jpg', isRotated: false, name: 'Hópárduc'),
          new CardObject(
              url: 'assets/hoparduc.jpg', isRotated: false, name: 'Hópárduc'),
          new CardObject(
              url: 'assets/hoparduc.jpg', isRotated: false, name: 'Hópárduc'),
          new CardObject(
              url: 'assets/hoparduc.jpg', isRotated: false, name: 'Hópárduc'),
          new CardObject(
              url: 'assets/hoparduc.jpg', isRotated: false, name: 'Hópárduc'),
          new CardObject(
              url: 'assets/hoparduc.jpg', isRotated: false, name: 'Hópárduc'),
          new CardObject(
              url: 'assets/hoparduc.jpg', isRotated: false, name: 'Hópárduc'),
        ],
        ownReserve: [
          new CardObject(url: 'assets/kisebb_angyal.jpg',
              isRotated: false,
              name: 'Kisebb angyal'),
          new CardObject(url: 'assets/kisebb_angyal.jpg',
              isRotated: false,
              name: 'Kisebb angyal'),
          new CardObject(url: 'assets/kisebb_angyal.jpg',
              isRotated: false,
              name: 'Kisebb angyal'),
          new CardObject(url: 'assets/kisebb_angyal.jpg',
              isRotated: false,
              name: 'Kisebb angyal'),
          new CardObject(url: 'assets/kisebb_angyal.jpg',
              isRotated: false,
              name: 'Kisebb angyal'),
          new CardObject(url: 'assets/kisebb_angyal.jpg',
              isRotated: false,
              name: 'Kisebb angyal'),
          new CardObject(url: 'assets/kisebb_angyal.jpg',
              isRotated: false,
              name: 'Kisebb angyal'),
          new CardObject(url: 'assets/kisebb_angyal.jpg',
              isRotated: false,
              name: 'Kisebb angyal'),
          new CardObject(url: 'assets/kisebb_angyal.jpg',
              isRotated: false,
              name: 'Kisebb angyal'),
          new CardObject(url: 'assets/kisebb_angyal.jpg',
              isRotated: false,
              name: 'Kisebb angyal'),
          new CardObject(url: 'assets/kisebb_angyal.jpg',
              isRotated: false,
              name: 'Kisebb angyal'),
          new CardObject(url: 'assets/kisebb_angyal.jpg',
              isRotated: false,
              name: 'Kisebb angyal'),
        ],
        ownGuardianPost: [
          new CardObject(
              url: 'assets/osi_runa.jpg', isRotated: false, name: 'Ősi rúna'),
          new CardObject(
              url: 'assets/osi_runa.jpg', isRotated: false, name: 'Ősi rúna'),
          new CardObject(
              url: 'assets/osi_runa.jpg', isRotated: false, name: 'Ősi rúna'),
          new CardObject(
              url: 'assets/osi_runa.jpg', isRotated: false, name: 'Ősi rúna'),
          new CardObject(
              url: 'assets/osi_runa.jpg', isRotated: false, name: 'Ősi rúna'),
          new CardObject(
              url: 'assets/osi_runa.jpg', isRotated: false, name: 'Ősi rúna'),
          new CardObject(
              url: 'assets/osi_runa.jpg', isRotated: false, name: 'Ősi rúna'),
          new CardObject(
              url: 'assets/osi_runa.jpg', isRotated: false, name: 'Ősi rúna'),
          new CardObject(
              url: 'assets/osi_runa.jpg', isRotated: false, name: 'Ősi rúna'),
        ],
        ownRuleCard: [
          new CardObject(url: 'assets/tharr_kovetoje.jpg',
              isRotated: false,
              name: 'Tharr követője'),
          new CardObject(url: 'assets/tharr_kovetoje.jpg',
              isRotated: false,
              name: 'Tharr követője'),
          new CardObject(url: 'assets/tharr_kovetoje.jpg',
              isRotated: false,
              name: 'Tharr követője'),
        ],
        ownFollower: [
          new CardObject(url: 'assets/tundoklo_griff.jpg',
              isRotated: false,
              name: 'Tündöklő griff'),
        ],
        enemyHP: 20,
        enemyMaxHP: 20,
        enemyMana: 0,
        enemyMaxMana: 20,
        enemyName: 'Béla bá',
        enemyInDangerZone: false,

        ownHP: 20,
        ownMaxHP: 20,
        ownMana: 0,
        ownMaxMana: 20,
        ownName: 'Istenkirálycsászár',
        ownInDangerZone: false
    );
  }
}
