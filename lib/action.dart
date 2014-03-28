/*
分成被動和靈氣
被動在特殊情況會發動，例如進攻時。

行為本身有等級之分，
*/

part of dungeon;

class Actor {
  List<Action> actions = [];

  attachAction(Actor state) {
    state.Attach(this);
    states.add(state);
    //    add(state);
  }

  detachAction(Actor state) {
    state.attach(this);
    states.remove(state);
    //    remove(state);
  }
}

class TimeWatcher {
  num time = 10000;
  num timer = 0;

  void update(Game game) {
    timer += game.deltaTime;
    if (time != 0 && timer >= time) {
      timeUp();
    }
  }

  void timeUp() {

  }
}

class Action extends Entity with Updatable, TimeWatcher {
  int level = 1;
  Actor _owner = null;


}


class Attack extends Action{
  
}







