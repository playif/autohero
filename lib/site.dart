part of model;

//Map<String, Site> SiteMap = {
//  "a": new Site(),
//};


Map<int, int> MonsterBuffNumber = {
    0:100, 1:20, 2:5
};
Dict<int> monsterBuffNumber = new Dict<int>(MonsterBuffNumber, [0, 1, 2]);

typedef num ProgressFunc();


class SiteButton extends GameEntity {
  Site site;

  void init() {
    width = 100;
    height = 100;
    border = 1;

    add(new Label()
      ..text = site.name);

    onClick.listen((s) {
      game.setSite(site);
    });
  }

}

class Site extends GameEntity {
  int level = 1;

  //  int get level => _level;
  //
  //  void set level(int lv) {
  //    _level = lv;
  //    levelLabel
  //      ..text = "等級:${_level}";
  //  }

  Label levelLabel = new Label();
  int maxLevel = 3;
  int currentMaxLevel = 1;
  ProgressFunc levelFunc;
  int monsterLevel = 1;

  String name = "Site";

  ProgressFunc progressFunc;
  num maxProgress;
  num currentProgress = 0;

  Dict<Creator<Monster>> monsters;
  Dict<MonsterBuff> monsterBuffs;

  num maxMonster = 3;

  View panel = new View();

  Select select = new Select();

  Bar progressBar = new Bar();

  void init() {
    width = 200;
    height = 200;
    //panel.vertical = false;
    panel.width = 200;
    panel.height = 200;
    add(panel);

    panel.add(new Label()
      ..name = '場地: '
      ..text = this.name);

    levelLabel
      ..size = 20;
    levelLabel.name = '等級: ';
    levelLabel.watch('text', this, 'level');
    panel.add(levelLabel);

    setLevel(1);


    select.createOption("level $level", "$level");
    //select.width=200;
    //    select.createOption("level 1", "1");
    //    select.createOption("level 2", "2");

    panel.add(select);

    select.onChange.listen((s) {
      game.removeAllMonsters();

      setLevel(select.selectedIndex + 1);
    });
    select.height = 40;

    progressBar.width = 180;
    progressBar.height = 10;
    //progressBar.borderColorH=50;
    progressBar.watch('max', this, 'maxProgress');
    progressBar.watch('min', this, 'currentProgress');
    panel.add(progressBar);
    //    SelectElement se = new SelectElement();
    //    OptionElement opt = new OptionElement();
    //    opt.text = "test1";
    //    opt.value = "hi";
    //    se.children.add(opt);
    //    OptionElement opt2 = new OptionElement();
    //    opt2.text = "test2";
    //    opt2.value = "hi";
    //    se.onChange.listen((s) {
    //      level += 1;
    //
    //      //..classes.add("small-text");
    //      //game._setSite(StartLand2());
    //      game.removeAllMonsters();
    //      //print("hi");
    //      for (int i = 0;i < 1;i++) {
    //        var mon = createMonster();
    //
    //        var state = Generation();
    //        //state.effect=10;
    //        //    state.attach(mon);
    //        mon.add(state);
    //        mon.add(Generation());
    //        mon.add(Generation2());
    //        mon.add(Generation());
    //        game.add(mon);
    //      }
    //    });
    //    se.children.add(opt2);
    //
    ////    se.classes.add('small-text');
    //    panel.element.children.add(se);


  }

  Monster createMonster() {
    Monster monster = monsters.pick()();
    var bn = monsterBuffNumber.pick();

    monster.level = monsterLevel + levelFunc();

    monsterBuffs.pickNUnique(bn).forEach((b) => b(monster));


    return monster;
  }

  void progress() {
    currentProgress += 10;
    if (currentProgress >= maxProgress) {
      levelUP();
    }
  }

  void setLevel(int lv) {
    //    if (level >= maxLevel)return;
    level = lv;
    select.selectedIndex = level - 1;
    currentProgress = 0;
    maxProgress = progressFunc();
  }

  void levelUP() {
    if (level >= maxLevel)return;
    level += 1;

    if (currentMaxLevel < level) {
      select.createOption("level $level", "$level");
      currentMaxLevel = level;
    }
    setLevel(level);
  }
}

Map<MonsterBuff, int> MonsterBuffProb = {
};

Map<Creator<Monster>, int> MonsterProb = {
};

Site StartLand() {
  Site site = new Site();

  site
    ..name = "試煉之地"
    ..monsters = new Dict<Creator<Monster>>(MonsterProb, [Mouse, Worm])
    ..monsterBuffs = new Dict<MonsterBuff>(MonsterBuffProb, [BigMonster, BigMonster3])
    ..progressFunc = () {
    return site.level * 50;
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
    return site.level * 50;
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