part of model;

//const Sym_HP = const Symbol('HP');

class MonsterView extends View {

  final Monster monster;

  final Bar HPBar = new Bar();
  final Label HPLabel = new Label();
  final View actionPanel = new View();
  final View statePanel = new View();


  MonsterView(this.monster);


  void init() {
    width = 200;
    height = 100;

    monster.MHP *= monster.level;
    monster.XP *= monster.level;
    monster._HP = monster.MHP;
    add(new Label()
      ..text = monster.name);

    breakLine();

    add(new Label()
      ..text = "等級:${monster.level}"
      ..classes.add("small-text"));

    breakLine();

    HPLabel.classes.add("small-text");
    HPLabel.name = "生命: ";

    //bf(this,HP,HPLabel,HPLabel.text);
    binding(this, 'HP', HPLabel, 'text');
    add(HPLabel);


    HPBar.width = 200;
    HPBar.height = 5;
    HPBar.color = 0;
    HPBar.max = monster.MHP;
    binding(this, 'HP', HPBar, 'min');
    add(HPBar);


    add(statePanel);
    add(actionPanel);

    border = 1;

    onClick.listen((e) {
      monster.HP -= 100;
    });


    //HPLabel.text = "生命:$_HP";
    //HPBar.min = _HP;
    //    this.height=200;
  }
}

class Monster extends Model {
  String name = "monster";
  num _HP = 10;

  num get HP => _HP;

  num set HP(num val) {
    _HP = val;
    check();
  }

  num MHP = 10;
  num XP = 10;
  num money = 1;

  int level = 1;

  final List<State> states = [];

  Dict<Creator<Item>> loot;



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

      obtainExp(XP);
      obtainMoney(money);
      obtainLoot(loot.pick()());

      leave();
    }
    if (_HP > MHP) {
      _HP = MHP;
    }
    //HPBar.min = _HP;
    //HPLabel.text = "生命:$_HP";
  }

//  @override
//  remove(Entity child) {
//    if (child is State) {
//      _removeState(child);
//    }
//  }


}


Map<Creator<Item>, int> ItemProb = {
    //    up1:10
};

Dict<Creator<Item>> ItemDict = new Dict<Creator<Item>>(ItemProb, [RedPotion, Dagger]);


Monster Mouse() {
  Monster monster = new Monster();
  monster
    ..name = "老鼠"
    ..MHP = 5
    ..XP = 3
    ..money = 1
    ..loot = new Dict(ItemProb, [RedPotion, Dagger]);
  return monster;
}

Monster Worm() {
  Monster monster = new Monster();
  monster
    ..name = "蟲"
    ..MHP = 7
    ..XP = 4
    ..money = 2
    ..loot = new Dict(ItemProb, [RedPotion, Dagger, ShortSword]);
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