import 'package:hkk/dto/card.dart';

class GameTableData {
  int enemyHP;
  int enemyMaxHP;
  int enemyMana;
  int enemyMaxMana;
  String enemyName;
  bool enemyInDangerZone;
  List<CardObject> enemyHand;
  List<CardObject> enemyDeck;
  List<CardObject> enemyCollector;
  List<CardObject> enemyNothingness;
  List<CardObject> enemyOther;
  List<CardObject> enemyReserve;
  List<CardObject> enemyGuardianPost;
  List<CardObject> enemyRuleCard;
  List<CardObject> enemyFollower;

  int ownHP;
  int ownMaxHP;
  int ownMana;
  int ownMaxMana;
  String ownName;
  bool ownInDangerZone;
  List<CardObject> ownHand;
  List<CardObject> ownDeck;
  List<CardObject> ownCollector;
  List<CardObject> ownNothingness;
  List<CardObject> ownOther;
  List<CardObject> ownReserve;
  List<CardObject> ownGuardianPost;
  List<CardObject> ownRuleCard;
  List<CardObject> ownFollower;

  GameTableData(
      {this.enemyHand,
      this.enemyDeck,
      this.enemyHP,
      this.enemyMana,
      this.enemyNothingness,
      this.enemyMaxHP,
      this.enemyMaxMana,
      this.enemyCollector,
      this.enemyName,
      this.enemyInDangerZone,
      this.ownCollector,
      this.ownDeck,
      this.ownHand,
      this.ownNothingness,
      this.ownName,
      this.enemyOther,
      this.ownOther,
      this.enemyReserve,
      this.ownReserve,
      this.enemyGuardianPost,
      this.ownGuardianPost,
      this.enemyRuleCard,
      this.ownRuleCard,
      this.enemyFollower,
      this.ownFollower,
      this.ownHP,
      this.ownInDangerZone,
      this.ownMana,
      this.ownMaxHP,
      this.ownMaxMana});
}
