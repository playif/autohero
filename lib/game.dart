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

abstract class Updatable {
  void update(Game game);
}

class Game extends Entity {
  num _dt;

  num get time => _dt;

  //  Team team=new Team();
  List<Role> _roles = new List<Role>();

  List<Role> get roles => _roles;

  Map<String, int> _items = new Map<String, int>();

  Map<String, int> get items => _items;

  List<Monster> _encumbrance = new List<Monster>();

  List<Monster> get encumbrance => _encumbrance;

  Site _currentSite = new Site();

  Site get currentSite => _currentSite;

  int _money = 0;

  int get money => _money;

  int _research = 0;

  int get research => _research;


  Game() {
    classes.add('box');

    //Upgrade up = UpgradeDict.pick();



    //    Upgrade up = creator();
//    print(up.name);
    //    var r=creator();
    //var a=Upgrade;

    //print("test3");

    //var ty=reflect (list[0]);
    //print(ty.type.metadata[0].getField(const Symbol("prob")));

  }


  void start(Element root, [Duration dt = const Duration(milliseconds: 100)]) {
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
        e.update(this);
      }
      _updateEntities(e);
    }
  }
}
