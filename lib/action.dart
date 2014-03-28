/*
分成被動和靈氣
被動在特殊情況會發動，例如進攻時。

行為本身有等級之分，
*/

part of dungeon;

class Component extends GameEntity {
  GameEntity host;
}

class ActionHost {
  List<Action> actions = [];
  final Entity actionPanel = new Entity();

  _addAction(Action action) {
    action.init(this);
    actionPanel.addChild(action);
  }

  _removeAction(Action action) {
    actionPanel.removeChild(action);
    //owner.removeChild(action);
  }
}


class TimeWatcher {
  Clock timerClock = new Clock();
  num maxTime = 0;
  num timer = 0;
  num activeTime = 1000;
  num activeTimer = 0;


  void update() {
    timerClock.max = activeTime;
    timer += game.deltaTime;
    activeTimer += game.deltaTime;
    if (activeTimer >= activeTime) {
      activeTimer = 0;
      active();
    }

    if (maxTime != 0 && timer >= maxTime) {
      timeUp();
    }
    timerClock.min = activeTimer;
  }

  void active() {
  }

  void timeUp() {
  }
}

class Action extends GameEntity with Updatable, TimeWatcher {
  int level = 1;
  num effect = 1;
  String name = "action";
  final Map<ActionActive, Fomula> actives = {
  };
  ActionHost _owner = null;

  Action() {

  }

  init(ActionHost owner) {
    _owner = owner;

    add(timerClock);

    timerClock.add(new Label()
      ..text = this.name);

  }

  @override
  void active() {
    for (var a in actives.keys) {
      a(_owner, actives[a]());
    }
  }
}

typedef void ActionActive<T> (T caster, num value);

void AttackFirstMonster(Role caster, num value) {
  var monster = game.getFirstMonster();
  if (monster == null)return;

  monster.HP -= value * caster.damage;
  //print("attack!${monster.HP}");
}

void AttackAllMonster(Role caster, num value) {
  var monsters = game.getAllMonster();
  if (monsters == null)return;

  monsters.forEach((m) {
    m.HP -= value * caster.damage;
    //print("attack!${monster.HP}");
  });

}

Action Attack() {
  Action attack = new Action();
  attack
    ..name = "普通攻擊"
  //    ..maxTime = 3000
  //    ..effect = 5
    ..actives[AttackFirstMonster] = () {
    return attack.effect * attack.level;
  };
  //state.attach(target);
  return attack;
}


Action AttackAll() {
  Action attack = new Action();
  attack
    ..name = "全部攻擊"
    ..activeTime = 2000
  //    ..maxTime = 3000
  //    ..effect = 5
    ..actives[AttackAllMonster] = () {
    return attack.effect * attack.level;
  };
  //state.attach(target);
  return attack;
}

