part of dungeon;


class Monster extends GameEntity with StateHost, ActionHost {
  String name = "monster";
  num _HP = 10;

  num get HP => _HP;

  num set HP(num val) {
    _HP = val;
    check();
  }

  num MHP = 10;
  num XP = 10;

  int level = 1;

  Bar HPBar = new Bar();
  Label HPLabel = new Label();

  void init() {
    MHP *= level;
    XP *= level;
    _HP = MHP;
    add(new Label()
      ..text = this.name);
    add(new Label()
      ..text = "等級:${level}"
      ..classes.add("small-text"));

    HPLabel.classes.add("small-text");
    HPLabel.text = "生命:$_HP";
    add(HPLabel);

    add(HPBar);
    HPBar.width = 100;
    HPBar.height = 5;
    HPBar.color = 0;
    HPBar.max = MHP;
    HPBar.min = _HP;

    add(statePanel);
    add(actionPanel);

    classes.add('box');
    classes.add('vbox');
    classes.add('border');
    classes.add('small-margin');

    onClick.listen((e) {
      HP -= 1;
    });


    //    this.height=200;
  }

  //  @override
  //  void update() {
  //    HPBar.min = _HP;
  //  }


  //  @override
  //  add(Entity child) {
  //    if (child is State) {
  //      _attachState(this,child);
  //    }
  //    else if (child is Action){
  //
  //    }
  //  }

  //  heal(num value) {
  //    HP += value;
  //    check();
  //  }
  //
  //  damage(num value) {
  //    HP -= value;
  //    check();
  //  }

  check() {
    if (_HP <= 0) {
      _HP = 0;

      game.obtainExp(XP);

      leave();
    }
    if (_HP > MHP) {
      _HP = MHP;
    }
    HPBar.min = _HP;
    HPLabel.text = "生命:$_HP";
  }

//  @override
//  remove(Entity child) {
//    if (child is State) {
//      _removeState(child);
//    }
//  }


}


Map<Creator<Monster>, int> MonsterProb = {
};


Monster Mouse() {
  Monster monster = new Monster();
  monster
    ..name = "老鼠"
    ..MHP = 5
    ..XP = 3;
  return monster;
}

Monster Worm() {
  Monster monster = new Monster();
  monster
    ..name = "蟲"
    ..MHP = 7
    ..XP = 4;
  return monster;
}

////rock door etc.
//class Natural extends Monster{
//
//}
//
//class Chest extends Monster{
//
//}