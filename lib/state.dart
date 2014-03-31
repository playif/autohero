part of model;


//typedef void RoleState(Role role, num value);
//
//RoleState HP = (Role role, num value) {
//  role.damage += value;
//};

typedef void StateActive<T> (T target, num value);

HPAdd(Monster monster, num value) {
  monster.HP += value;
  //print("active:${monster.HP}");
}

typedef void StateAttach<T> (T target, num value, int inv);

PowerUp(Monster monster, num value, int inv) {
  monster.HP += value * inv;
  //print("attach:$inv");
}


//class StateCreator{
//  final List<Creator<State>> state = [];
//}

class StateHost {
  final List<State> states = [];
  final View statePanel = new View();

  _addState(State state) {
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
      //print("here");
    } else {
      state.attach(this);
      states.add(state);
      statePanel.add(state);
    }
  }

  _removeState(State state) {
    states.remove(state);
    statePanel.remove(state);
  }


}

class StateView extends View {
  final State state;

  StateView(this.state);

  init() {
    //    timerClock.width = 50;
    //    timerClock.height = 50;

    add(state.timerClock);

    timerClock.add(new Label()
      ..text = this.name);


  }
}

class State extends Model with TimeWatcher {
  String name = "";
  num effect = 1;
  StateHost _target;

  //  num time = 10000;
  //  num timer = 0;

  int maxCount = 0;
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
  timeUp() {
    detach();
  }

  @override
  void active() {
    for (var a in actives.keys) {
      a(_target, actives[a]());
    }
    currentCount++;
    if (maxCount != 0 && currentCount >= maxCount) {
      detach();
    }
  }

  void attach(StateHost target) {
    _target = target;
    for (var a in attaches.keys) {
      a(target, attaches[a](), 1);
    }
    init();
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
    ..name = "生命回復"
    ..maxTime = 3000
    ..effect = 5
    ..actives[HPAdd] = () {
    return state.effect * state.stack;
  };
  //state.attach(target);
  return state;
}

State Generation2() {
  State state = new State();
  state
    ..name = "生命回復2"
    ..maxTime = 30000000
    ..activeTime = 10000
    ..effect = 5
    ..actives[HPAdd] = () {
    return state.effect * state.stack;
  };
  //state.attach(target);
  return state;
}