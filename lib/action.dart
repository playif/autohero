/*
分成被動和靈氣
被動在特殊情況會發動，例如進攻時。

行為本身有等級之分，
*/

part of game;

class Component extends Model {
  Model host;
}

class ActionHost {


  //  _addAction(Action action) {
  //    action.init(this);
  //    actionPanel.addChild(action);
  //  }
  //
  //  _removeAction(Action action) {
  //    actionPanel.removeChild(action);
  //    //owner.removeChild(action);
  //  }
}


class TimeWatcher {

  num maxTime = 0;
  num timer = 0;
  num activeTime = 1000;
  num activeTimer = 0;


  void update() {

    timer += DELTA_TIME;
    activeTimer += DELTA_TIME;
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


class ActionView extends View {

  final Action action;
  Clock timerClock = new Clock();

  ActionView(this.action) {
    timerClock.max = action.activeTime;
  }

  init() {
    style.overflow = 'hidden';
    width = 20;
    height = 20;

    timerClock.width = 20;
    add(timerClock);

    timerClock.add(new Label()
      ..text = action.name
      ..style.overflow = 'hidden');

    timerClock.bindField('min', action, 'activeTimer');
  }
}

class Action extends Model with TimeWatcher {
  int level = 1;
  num effect = 1;
  String name = "action";
  final Map<ActionActive, Formula> actives = {
  };

  //Role role;

  //ActionHost _owner = null;

  Action() {

  }


  @override
  void active() {
    for (var a in actives.keys) {
      a(actives[a]());
    }
  }
}

typedef void ActionActive (num value);

typedef Action ActionCreator<T> (T value);

void AttackFirstMonster(num value) {
  var monster = getFirstMonster();
  if (monster == null)return;

  monster.HP -= value;
  //print("attack!${monster.HP}");
}

void AttackAllMonster(num value) {
  var monsters = getAllMonster();
  if (monsters == null)return;

  monsters.forEach((m) {
    m.HP -= value;
    //print("attack!${monster.HP}");
  });

}

Action Attack(Role role) {
  Action attack = new Action();
  attack
    ..name = "普通攻擊"
  //    ..maxTime = 3000
  //    ..effect = 5
    ..actives[AttackFirstMonster] = () {
    return attack.effect * attack.level * role.damage;
  };
  //state.attach(target);
  return attack;
}


Action AttackAll(Role role) {
  Action attack = new Action();
  attack
    ..name = "全部攻擊"
    ..activeTime = 2000
  //    ..maxTime = 3000
  //    ..effect = 5
    ..actives[AttackAllMonster] = () {
    return attack.effect * attack.level * role.damage;
  };
  //state.attach(target);
  return attack;
}

