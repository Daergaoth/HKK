class GameTableData {
  int enemyHP;
  int enemyMaxHP;
  int enemyMana;
  int enemyMaxMana;
  String enemyName;
  List<String> enemyHand;

  GameTableData(
      {this.enemyHand,
      this.enemyHP,
      this.enemyMana,
      this.enemyMaxHP,
      this.enemyMaxMana,
      this.enemyName});
}
