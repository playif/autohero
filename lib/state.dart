part of dungeon;


//typedef void RoleState(Role role, num value);
//
//RoleState HP = (Role role, num value) {
//  role.damage += value;
//};

typedef void StateActive<T> (T target, num value);

StateActive<Monster> HPAdd = (Monster monster, num value) {
  monster.HP += value;
  print("active:${monster.HP}");
};

typedef void StateAttach<T> (T target, num value, int inv);

StateAttach<Monster> PowerUp = (Monster monster, num value, int inv) {
  monster.HP += value * inv;
  print("attach:$inv");
};


//class StateCreator{
//  final List<Creator<State>> state = [];
//}

class StateHost {
  final List<State> states = [];

  _addState(Entity target, State state) {
    var oldState = states.firstWhere((s) => s.name == state.name, orElse:() => null);
    if (oldState != null) {
      if (oldState.reflashOnStack) {
        oldState.currentCount = 0;
        oldState.activeTimer = 0;
        oldState.timer = 0;
      }
      if (!oldState.single && oldState.maxStack > oldState.stack) {
        oldState.stack += 1;
      }
      print("here");
    } else {
      state.attach(this);
      states.add(state);
      target.addChild(state);
    }
  }

  _removeState(Entity target, State state) {
    states.remove(state);
    target.removeChild(state);
  }


}

class State extends Entity with Updatable, TimeWatcher {
  String name = "";
  num effect = 1;
  StateHost _target;

  //  num time = 10000;
  //  num timer = 0;
  num activeTime = 1000;
  num activeTimer = 0;
  int maxCount = 4;
  int currentCount = 0;

  int maxStack = 10;
  int stack = 1;

  bool single = false;

  bool reflashOnStack = true;


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

  void attach(StateHost target) {
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
    ..maxTime = 3000
    ..effect = 5
    ..attaches[PowerUp] = () {
    return state.effect;
  }
    ..actives[HPAdd] = () {
    return state.effect * state.stack;
  };
  //state.attach(target);
  return state;
}