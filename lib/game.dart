library dungeon;
import 'dart:html';
import 'dart:async';
import 'dart:math';

import 'htmlib.dart';

part 'action.dart';
part 'item.dart';
part 'monster.dart';
part 'team.dart';
part 'role.dart';

part 'site.dart';
part 'state.dart';
part 'dict.dart';

Game game;

class GameEntity extends Entity {

  @override
  add(Entity child) {
    if (child is State) {
      var me = this as StateHost;
      me._addState(child);
    } else if (child is Action) {
      var me = this as ActionHost;
      me._addAction(child);
    } else if (child is Monster) {
      game._addMonster(this, child);
    } else if (child is Role) {
      game._addRole(this, child);
    } else {
      super.addChild(child);
    }
  }


  @override
  remove(Entity child) {

    if (child is State) {
      var me = this.parent as StateHost;
      me._removeState(child);
    } else if (child is Action) {
      var me = this.parent as ActionHost;
      me._removeAction(child);
    } else if (child is Monster) {
      game._removeMonster(this, child);
    } else if (child is Role) {
      game._removeRole(this, child);
    } else {
      super.removeChild(child);
    }
  }
}


abstract class Game extends Entity {
  num _dt;

  num get deltaTime => _dt;

  //  Team team=new Team();
  List<Role> _roles = new List<Role>();

  List<Role> get roles => _roles;

  Map<String, int> _items = new Map<String, int>();

  Map<String, int> get items => _items;

  List<Monster> _monsters = new List<Monster>();

  List<Monster> get monsters => _monsters;

  Site _currentSite = StartLand();

  Site get currentSite => _currentSite;

  int _money = 0;

  int get money => _money;

  int _research = 0;

  int get research => _research;


  Game() {
    classes.add('box');
  }

  Monster getFirstMonster() {
    if (monsters.length > 0) {
      return monsters.first;
    } else return null;
  }

  void _addMonster(Entity location, Monster monster) {
    monster.init();
    monsters.add(monster);
    location.addChild(monster);
  }

  void _removeMonster(Entity location, Monster monster) {
    monsters.remove(monster);
    location.removeChild(monster);
  }

  void _addRole(Entity location, Role role) {
    role.init();
    roles.add(role);
    location.addChild(role);
  }

  void _removeRole(Entity location, Role role) {
    roles.remove(role);
    location.removeChild(role);
  }

  void obtainExp(num xp) {
    var n = roles.length;
    num rxp = xp / n;

    for (int i = 0;i < roles.length;i++) {
      roles[i].XP += rxp;
      roles[i].check();
    }
  }

  Monster createMonster() {
    return currentSite.createMonster();
  }

  void init();

  void start(Element root, [Duration dt = const Duration(milliseconds: 100)]) {
    init();
    root.children.add(element);
    this._dt = dt.inMilliseconds;
    Timer timer = new Timer.periodic(dt, _update);
  }

  void _update(Timer timer) {
    _updateEntities(this);
  }

  void _updateEntities(Entity entity) {
    for (int i = 0; i < entity.children.length; i++) {
      var e = entity.children[i];
      if (e.die) {
        if (e.parent == null) {
          throw new Exception('No parent!');
        } else {
          e.parent.remove(e);
        }
        i--;
        continue;
      }
      if (e is Updatable) {
        e.update();
      }
      _updateEntities(e);
    }
  }
}
