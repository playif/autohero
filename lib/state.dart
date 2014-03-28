part of dungeon;


//typedef void RoleState(Role role, num value);
//
//RoleState HP = (Role role, num value) {
//  role.damage += value;
//};

typedef void StateActive<T> (T, num);

StateActive<Monster> HPAdd = (Monster monster, num value) {
  monster.HP -= value;
};

typedef void StateAttach<T> (T, num, int);

StateActive<Monster> PowerUp = (Monster monster, num value, int inv) {
  monster.HP += value * inv;
};

class State<T> extends Entity with Updatable {
  String name = "";
  num effect = 1;
  T target;
  num time = 10;
  num timer = 0;
  num activeTime = 1;
  num activeTimer = 0;

  bool isTemp = true;

  //List<Action> actions=[];
  final Map<StateActive<T>, Fomula> actives = {
  };

  final Map<StateAttach<T>, Fomula> attaches = {
  };

  @override
  void update(Game game) {
    num dt = game.time;
    if (isTemp) {
      timer += dt;
      if (timer > time) {
        //TODO finished
      }
    }
    
  }

  void active() {
    for (var a in actives.keys) {
      a(target, actives[a]());
    }
    //onEquip(role);
  }

  void attach() {
    for (var a in attaches.keys) {
      a(target, attaches[a](), 1);
    }
    //onEquip(role);
  }

  void detach() {
    for (var a in attaches.keys) {
      a(target, attaches[a](), -1);
    }
    //onEquip(role);
  }

}

Monster Generation(num effect, Monster target) {
  State<Monster> state = new State<Monster>();
  state
    ..name = "匕首"
    ..effect = effect
    ..target = target
    ..fomulas[HPAdd] = () {
    return state.effect;
  };
  return state;
}