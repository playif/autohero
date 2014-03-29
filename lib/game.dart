library dungeon;
import 'dart:html';
import 'dart:async';
import 'dart:math';

import 'htmlib.dart';

import 'binging.dart';

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
      var me = this as Game;
      me._addMonster(child);
    } else if (child is Role) {
      var me = this as Game;
      me._addRole(child);
    } else {
      super.addChild(child);
    }
  }


  @override
  remove(Entity child) {

    if (child is State) {
      var me = this as StateHost;
      me._removeState(child);
    } else if (child is Action) {
      var me = this as ActionHost;
      me._removeAction(child);
    } else if (child is Monster) {
      var me = this as Game;
      me._removeMonster(child);
    } else if (child is Role) {
      var me = this as Game;
      me._removeRole(child);
    } else {
      super.removeChild(child);
    }
  }

  @override
  GameEntity get parent => getGameParent(this);

  GameEntity getGameParent(Entity entity) {
    if (entity.entityParent is GameEntity) return entity.entityParent;
    return getGameParent(entity.entityParent);
  }
}

class RoleHost {
  final List<Role> roles = [];
  final Entity rolePanel = new Entity();

  void _addRole(Role role) {
    role.init();
    roles.add(role);
    rolePanel.addChild(role);
  }

  void _removeRole(Role role) {
    roles.remove(role);
    rolePanel.removeChild(role);
  }
}

class SiteHost {
  final Entity sitePanel = new Entity();
  Site _currentSite = StartLand();

  Site get currentSite => _currentSite;

  int get siteLevel => _currentSite.level;

  set siteLevel(int level) {
    _currentSite.level = level;
  }

  void _setSite(Site site) {
    sitePanel.remove(_currentSite);
    sitePanel.add(site);
    //_currentSite
    site.init();
    _currentSite = site;

    //site.init();
    //sites.add(site);
    //sitePanel.addChild(role);
  }


//  void _removeSite(Site site) {
//    //roles.remove(role);
//    //rolePanel.removeChild(role);
//  }
}

abstract class Game extends GameEntity with RoleHost, SiteHost {
  num _dt;

  num get deltaTime => _dt;

  Map<String, int> _items = new Map<String, int>();

  Map<String, int> get items => _items;

  List<Monster> _monsters = new List<Monster>();

  List<Monster> get monsters => _monsters;


  int _money = 0;

  int get money => _money;

  int _research = 0;

  int get research => _research;

  Entity header = new Entity();
  Entity monsterPanel = new Entity();

  Game() {
    classes.add('box');

    var root = new Entity();
    var body = new Entity();

    root.classes.add('box');
    root.classes.add('vbox');
    root.addChild(header);
    root.add(sitePanel);
    root.addChild(body);
    addChild(root);


    body.classes.add('box');
    body.classes.add('hbox');
    body.addChild(rolePanel);
    body.addChild(monsterPanel);

    rolePanel.width = 200;
    sitePanel.height = 70;
    header.height = 70;


    _setSite(StartLand());
    //    ProgressElement progress=new ProgressElement();
    //    progress.value=22;
    //    progress.max=100;
    //    header.element.children.add(progress);
  }

  void removeAllMonsters() {
    monsters.forEach((m) => m.leave());
  }

  Monster getFirstMonster() {
    if (monsters.length > 0) {
      return monsters.firstWhere((m) => !m.die);
    } else return null;
  }

  List<Monster> getAllMonster() {
    if (monsters.length > 0) {
      return monsters.where((m) => !m.die);
    } else return null;
  }

  void _addMonster(Monster monster) {
    monster.init();
    monsters.add(monster);
    monsterPanel.addChild(monster);
  }

  void _removeMonster(Monster monster) {
    monsters.remove(monster);
    monsterPanel.removeChild(monster);
  }


  void obtainExp(num xp) {
    var n = roles.length;
    num rxp = xp / n;

    for (int i = 0;i < roles.length;i++) {
      roles[i].XP += rxp;
      roles[i].check();
    }
  }

  void obtainMoney(num money) {
    //this.money+=money;
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

    if (monsters.length <= currentSite.maxMonster + siteLevel * 3) {
      add(createMonster());
    }

    checkBindings();
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
