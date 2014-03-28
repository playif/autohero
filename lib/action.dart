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

  void update(Game game) {
    timer += game.deltaTime;
    if (maxTime != 0 && timer >= maxTime) {
      timeUp();
    }
  }

  void timeUp() {
  }
}

class Action extends Entity with Updatable, TimeWatcher {
  int level = 1;
  ActionHost _owner = null;


}


class Attack extends Action{
  
}







