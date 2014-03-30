part of model;

//Map<String, Site> SiteMap = {
//  "a": new Site(),
//};


Map<int, int> MonsterBuffNumber = {
    0:100, 1:20, 2:5
};
Dict<int> monsterBuffNumber = new Dict<int>(MonsterBuffNumber, [0, 1, 2]);

typedef num ProgressFunc();


class LevelMixin {
  int _level = 1;

  int get level => _level;

  void set level(int lv) {
    _level = lv;
    levelLabel
      ..text = "等級:${_level}";
  }

  Label levelLabel = new Label();
}

class Site extends GameEntity with LevelMixin {
  int maxLevel = 3;
  ProgressFunc levelFunc;
  int monsterLevel = 1;

  String name = "Site";

  ProgressFunc progressFunc;
  num maxProgress;
  num currentProgress = 0;

  Dict<Creator<Monster>> monsters;
  Dict<MonsterBuff> monsterBuffs;

  num maxMonster = 10;


  void init() {
    add(new Label()
      ..text = this.name);

    levelLabel
      ..text = "等級:${level}"
      ..classes.add("small-text");
    add(levelLabel);

    SelectElement se = new SelectElement();
    OptionElement opt = new OptionElement();
    opt.text = "test1";
    opt.value = "hi";
    se.children.add(opt);
    OptionElement opt2 = new OptionElement();
    opt2.text = "test2";
    opt2.value = "hi";
    se.onChange.listen((s) {
      level += 1;

      //..classes.add("small-text");
      //game._setSite(StartLand2());
      game.removeAllMonsters();
      //print("hi");
      for (int i = 0;i < 1;i++) {
        var mon = createMonster();

        var state = Generation();
        //state.effect=10;
        //    state.attach(mon);
        mon.add(state);
        mon.add(Generation());
        mon.add(Generation2());
        mon.add(Generation());
        game.add(mon);
      }
    });
    se.children.add(opt2);

    se.classes.add('small-text');
    element.children.add(se);

  }

  Monster createMonster() {
    Monster monster = monsters.pick()();
    var bn = monsterBuffNumber.pick();
    //    for (int i = 0;i < bn;i++) {
    //      MonsterBuff buff = monsterBuffs.pick();
    //      buff(monster);
    //    }
    monster.level = monsterLevel + levelFunc();

    monsterBuffs.pickNUnique(bn).forEach((b) => b(monster));


    return monster;
  }

  void progress() {
    currentProgress += 1;
    if (currentProgress >= maxProgress) {
      setLevel(level + 1);
    }
  }

  void setLevel(int lv) {
    if (level == maxLevel)return;
    level = lv;
    currentProgress = 0;
    maxProgress = progressFunc();
  }
}

Map<MonsterBuff, int> MonsterBuffProb = {
};

Site StartLand() {
  Site site = new Site();

  site
    ..monsters = new Dict<Creator<Monster>>(MonsterProb, [Mouse, Worm])
    ..monsterBuffs = new Dict<MonsterBuff>(MonsterBuffProb, [BigMonster, BigMonster3])
    ..progressFunc = () {
    return site.level * 50 + 100;
  }
    ..levelFunc = () {
    return site.level * 1 + rand.nextInt(2);
  };

  return site;
}

Site StartLand2() {
  Site site = new Site();

  site
    ..monsters = new Dict<Creator<Monster>>(MonsterProb, [Mouse])
    ..monsterBuffs = new Dict<MonsterBuff>(MonsterBuffProb, [BigMonster, BigMonster2, BigMonster3])
    ..progressFunc = () {
    return site.level * 50 + 100;
  }
    ..levelFunc = () {
    return site.level * 1 + rand.nextInt(3);
  };

  return site;
}


typedef void MonsterBuff(Monster monster);

//NormalMonster(Monster monster) {
//  monster
//    ..HP *= 2
//    ..XP *= 2;
//}

BigMonster(Monster monster) {
  monster
    ..name += "(巨大)"
    ..MHP *= 2
    ..XP *= 2;
}

BigMonster2(Monster monster) {
  monster
    ..name += "(巨大2)"
    ..MHP *= 2
    ..XP *= 2;
}

BigMonster3(Monster monster) {
  monster
    ..name += "(巨大3)"
    ..MHP *= 2
    ..XP *= 2;
}