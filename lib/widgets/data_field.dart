import 'package:flutter/material.dart';

class DataField extends StatefulWidget {
  int HP;
  int Mana;
  int MaxHP;
  int MaxMana;
  bool isInDangerZone;
  bool amIEnemyField;

  DataField(
      {this.MaxMana,
      this.Mana,
      this.MaxHP,
      this.HP,
      this.isInDangerZone,
      this.amIEnemyField});

  @override
  _DataFieldState createState() => _DataFieldState(
      isInDangerZone: isInDangerZone,
      HP: HP,
      Mana: Mana,
      MaxHP: MaxHP,
      MaxMana: MaxMana,
      amIEnemyField: amIEnemyField);
}

class _DataFieldState extends State<DataField> {
  int HP;
  int Mana;
  int MaxHP;
  int MaxMana;
  bool isInDangerZone;
  bool amIEnemyField;

  _DataFieldState(
      {this.MaxMana,
      this.Mana,
      this.MaxHP,
      this.HP,
      this.isInDangerZone,
      this.amIEnemyField});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.15,
          height: MediaQuery.of(context).size.height * 0.025,
          decoration: BoxDecoration(
            border: Border.all(
              color: isInDangerZone ? Colors.red : Colors.green,
            ),
          ),
          child: Center(
            child: Text('ÉP: $HP',
                style: TextStyle(
                  color: isInDangerZone ? Colors.red : Colors.green,
                  fontSize: MediaQuery.of(context).size.height * 0.01,
                )),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.15,
          height: MediaQuery.of(context).size.height * 0.025,
          decoration: BoxDecoration(
            border: Border.all(
              color: isInDangerZone ? Colors.red : Colors.green,
            ),
          ),
          child: Center(
            child: Text('Max ÉP: $MaxHP',
                style: TextStyle(
                  color: isInDangerZone ? Colors.red : Colors.green,
                  fontSize: MediaQuery.of(context).size.height * 0.01,
                )),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.15,
          height: MediaQuery.of(context).size.height * 0.025,
          decoration: BoxDecoration(
            border: Border.all(
              color: isInDangerZone ? Colors.red : Colors.green,
            ),
          ),
          child: Center(
            child: Text('Mana: $Mana',
                style: TextStyle(
                  color: isInDangerZone ? Colors.red : Colors.green,
                  fontSize: MediaQuery.of(context).size.height * 0.01,
                )),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.15,
          height: MediaQuery.of(context).size.height * 0.025,
          decoration: BoxDecoration(
            border: Border.all(
              color: isInDangerZone ? Colors.red : Colors.green,
            ),
          ),
          child: Center(
            child: Text('Max Mana: $MaxMana',
                style: TextStyle(
                  color: isInDangerZone ? Colors.red : Colors.green,
                  fontSize: MediaQuery.of(context).size.height * 0.01,
                )),
          ),
        )
        // ),
      ],
    );
  }
}
