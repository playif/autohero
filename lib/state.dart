part of dungeon;


//typedef void RoleState(Role role, num value);
//
//RoleState HP = (Role role, num value) {
//  role.damage += value;
//};

typedef void StateActive<T> (T target, num value);

StateActive<Monster> HPAdd = (Monster monster, num value) {
  monster.HP -= value;
  print("active:${monster.HP}");
};

typedef void StateAttach<T> (T target, num value, int inv);

StateAttach<Monster> PowerUp = (Monster monster, num value, int inv) {
  monster.HP += value * inv;
  print("attach:$inv");
};


class StateTarget {
  final List<State> states = [];

  _attachState(State state) {
    state.attach(this);
    states.add(state);
    //    add(state);
  }

  _detachState(State state) {
    states.remove(state);
    //    remove(state);
  }


}

class State extends Entity with Updatable, TimeWatcher {
  String name = "";
  num effect = 1;
  StateTarget _target;

  //  num time = 10000;
  //  num timer = 0;
  num activeTime = 2000;
  num activeTimer = 0;
  int maxCount = 2;
  int currentCount = 0;
  int stack = 1;
  int maxStack = 0;

  State() {

  }

  //bool isTemp = true;

  //List<Action> actions=[];
  final Map<StateActive, Fomula> actives = {
  };

  final Map<StateAttach, Fomula> attaches = {
  };

  @override
  void update(Game game) {

    num dt = game.deltaTime;

    activeTimer += dt;
    if (activeTimer >= activeTime) {
      activeTimer = 0;
      active();
      currentCount++;
      if (maxCount != 0 && currentCount >= maxCount) {
        detach();
        return;
      }
    }

    super.update(game);
  }

  @override
  timeUp() {
    detach();
  }

  void active() {
    for (var a in actives.keys) {
      a(_target, actives[a]());
    }
    //onEquip(role);
  }

  void attach(StateTarget target) {
    _target = target;
    for (var a in attaches.keys) {
      a(target, attaches[a](), 1);
    }
    //_target
    //onEquip(role);
  }

  void detach() {
    for (var a in attaches.keys) {
      a(_target, attaches[a](), -1);
    }
    _target = null;
    leave();
  }

}

State Generation() {
  State state = new State();
  state
    ..name = "匕首"
    ..effect = 5
    ..attaches[PowerUp] = () {
    return state.effect;
  }
    ..actives[HPAdd] = () {
    return state.effect;
  };
  //state.attach(target);
  return state;
}