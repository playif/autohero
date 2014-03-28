part of dungeon;



//typedef void RoleState(Role role, num value);
//
//RoleState HP = (Role role, num value) {
//  role.damage += value;
//};

typedef void StateAtt<T> (T role, num value);

StateAtt<Monster> HPAdd = (Monster monster, num value) {
  monster.HP -= value;
};

class State<T> extends Entity with Updatable{
  String name="";
  num effect=1;
  T target;


  //List<Action> actions=[];
  final Map<StateAtt<T>, Fomula> fomulas = {};

  @override
  void update(Game game){
    
  }

  void active() {
    for (var a in fomulas.keys) {
      a(target, fomulas[a](), 1);
    }
    //onEquip(role);
  }
}

Monster Generation(num effect, Monster target) {
  State<Monster> state = new State<Monster>();
  state
    ..name = "匕首"
    ..effect=effect
    ..target=target
    ..fomulas[HPAdd] = () {
    return state.effect;
  };
  return state;
}