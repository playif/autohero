/*
分成被動和靈氣
被動在特殊情況會發動，例如進攻時。

行為本身有等級之分，
*/

part of dungeon;

class ActionHost {
  List<Action> actions = [];

  _addAction(Entity owner, Action action) {
    owner.addChild(action);
  }

  _removeAction(Entity owner, Action action) {
    owner.removeChild(action);
  }
}

class TimeWatcher {
  num maxTime = 0;
  num timer = 0;
  num activeTime = 1000;
  num activeTimer = 0;

  void update() {
    timer += game.deltaTime;
    activeTimer += game.deltaTime;
    if (activeTimer >= activeTime) {
      activeTimer = 0;
      active();
    }

    if (maxTime != 0 && timer >= maxTime) {
      timeUp();
    }
  }

  void active() {
  }

  void timeUp() {
  }
}

class Action extends Entity with Updatable, TimeWatcher {
  int level = 1;
  num effect = 1;
  String name = "action";
  final Map<ActionActive, Fomula> actives = {
  };
  ActionHost _owner = null;

  Action() {

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

  monster.HP -= value;
  print("attack!${monster.HP}");
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



