class RuleSetService {
  bool canISeeEnemyHand;
  bool canISeeOwnHand;
  bool canISeeEnemyDeck;
  bool canISeeOwnDeck;
  bool canISeeEnemyCollector;
  bool canISeeOwnCollector;
  bool canISeeEnemyNothingness;
  bool canISeeOwnNothingness;
  bool canISeeEnemyOther;
  bool canISeeOwnOther;
  bool canISeeOwnReserve;
  bool canISeeEnemyReserve;
  bool canISeeEnemyGuardianPost;
  bool canISeeOwnGuardianPost;
  bool canISeeEnemyRuleCard;
  bool canISeeOwnRuleCard;
  bool canISeeOwnFollower;
  bool canISeeEnemyFollower;

  RuleSetService(
      {this.canISeeEnemyHand,
      this.canISeeEnemyDeck,
      this.canISeeEnemyCollector,
      this.canISeeEnemyNothingness,
      this.canISeeOwnDeck,
      this.canISeeOwnOther,
      this.canISeeEnemyOther,
      this.canISeeOwnNothingness,
      this.canISeeOwnCollector,
      this.canISeeOwnHand,
      this.canISeeEnemyReserve,
      this.canISeeOwnReserve,
      this.canISeeEnemyGuardianPost,
      this.canISeeOwnGuardianPost,
      this.canISeeEnemyRuleCard,
      this.canISeeOwnRuleCard,
      this.canISeeEnemyFollower,
      this.canISeeOwnFollower});
}
