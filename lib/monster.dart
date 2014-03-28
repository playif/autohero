part of dungeon;


class Monster extends GameEntity with StateHost {
  String name = "monster";
  num _HP = 10;

  num get HP => _HP;

  num set HP(num val) {
    _HP = val;
    check();
  }

  num MHP = 10;


  int level = 1;


  void init() {
    _HP = MHP;
    addChild(new Label()
      ..text = this.name);
  }

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
      leave();
    }
    if (_HP > MHP) {
      _HP = MHP;
    }
  }

  @override
  remove(Entity child) {
    if (child is State) {
      _removeState(this, child);
    }
  }


}


Map<Creator<Monster>, int> MonsterProb = {
};


Monster Mouse() {
  Monster monster = new Monster();
  monster
    ..name = "老鼠"
    ..MHP = 10;
  return monster;
}

Monster Worm() {
  Monster monster = new Monster();
  monster
    ..name = "蟲"
    ..MHP = 20;
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