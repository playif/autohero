library model;
import 'dart:html';
import 'dart:async';
import 'dart:math';

import 'view.dart';

part 'panel.dart';
part 'action.dart';
part 'item.dart';
part 'monster.dart';
part 'team.dart';
part 'role.dart';


part 'site.dart';
part 'state.dart';
part 'dict.dart';

//Game game;


final List<Role> roles = [];
final List<Item> inventoryItems = [];
final List<GameEntity> entities = [];
final List<Monster> monsters = [];
final List<Site> sites = [StartLand(), StartLand2()];
//final List<Item> items = [];
Site currentSite = StartLand();

//int get siteLevel => currentSite.level;


const String ROLE = 'role';
const String ITEM = 'item';

const String ADD_ROLE = 'addRole';


const String REMOVE_ROLE = 'removeRole';

const String ADD_MONSTER = 'addMonster';
const String REMOVE_MONSTER = 'removeMonster';

const String ADD_INVENTORY_ITEM = 'addInventoryItem';

const String EQUIP = 'equip';

void addRole(Role role) {
  roles.add(role);
  root.sendMsg(ADD_ROLE, role);
}

void removeRole(Role role) {
  roles.remove(role);
  root.sendMsg(REMOVE_ROLE, role);
}

void addMonster(Monster monster) {
  monsters.add(monster);
  root.sendMsg(ADD_MONSTER, monster);
}

void removeMonster(Monster monster) {
  monsters.remove(monster);
  root.sendMsg(REMOVE_MONSTER, monster);
}

void addInventoryItem(Item item) {
  inventoryItems.add(item);
  root.sendMsg(ADD_INVENTORY_ITEM, item);
}

void removeInventoryItem(Item item) {

}

void equip(Weapon weapon, Role role) {
  weapon.equip(role);

  root.sendMsg(EQUIP, [weapon, role]);
}

void unequipItem(Item item, Role role) {


}

void setSite(Site site) {
  //  siteInfoPanel.remove(currentSite);
  //    site.updateView();
  //  siteInfoPanel.add(site);
  //    checkBindings();
  //siteInfoPanel.updateView();
  //_currentSite

  currentSite = site;

  //site.init();
  //sites.add(site);
  //sitePanel.addChild(role);
}


//views
final View root = new View();
final View menuPanel = new View();
final View contentPanel = new View();
final View monsterPanel = new View();
final View battlePanel = new View();
final View sitePanel = new View();
final View siteInfoPanel = new View();
final View itemPanel = new View();
final LayerPanel mainPanel = new LayerPanel();

final View rolePanel = new View();
final TeamPanel teamPanel = new TeamPanel();

//bindBodyPanel(View panel) {
//  panel.watchSize(mainPanel);
//  mainPanel.add(panel);
//}

init() {


  mainPanel.watch('width', root, 'width', transform:(s) => s - 200);
  mainPanel.watch('height', contentPanel, 'height');

  mainPanel.addPanel(battlePanel);
  mainPanel.addPanel(itemPanel);
  mainPanel.addPanel(sitePanel);
  mainPanel.addPanel(teamPanel);
  teamPanel.init();

  itemPanel.vertical = false;
  itemPanel.wrap = true;

  battlePanel.vertical = false;
  battlePanel.add(rolePanel);
  battlePanel.add(monsterPanel);

  rolePanel.width = 200;
  rolePanel.watch('height', mainPanel, 'height');

  monsterPanel.watch('height', mainPanel, 'height');
  monsterPanel.watch('width', mainPanel, 'width', transform:(s) => s - rolePanel.width);
  monsterPanel.cellMargin = 5;
  monsterPanel.vertical = false;
  monsterPanel.wrap = true;

  menuPanel.height = 70;
  menuPanel.watch('width', root, 'width');
  menuPanel.cellMargin = 15;
  menuPanel.vertical = false;

  infoPanel.init();
  infoPanel.watch('height', contentPanel, 'height');
  infoPanel.width = 200;
  siteInfoPanel.height = 200;
  siteInfoPanel.watch('width', infoPanel, 'width');
  infoPanel.add(siteInfoPanel);

  contentPanel.watch('height', root, 'height', transform:(s) => s - 70);
  contentPanel.watch('width', root, 'width');
  contentPanel.vertical = false;

  //infoPanel.vertical = false;

  root.add(menuPanel);
  root.add(contentPanel);
  contentPanel.add(infoPanel);
  contentPanel.add(mainPanel);


  showPanel(battlePanel);

  //    setSite(StartLand());
  //    var moneyLabel = ;


  sites.forEach((s) {
    s.init();
    SiteButton siteButton = new SiteButton();
    siteButton.site = s;
    siteButton.init();
    //    sitePanel.add(siteButton);
  });

  setSite(sites[0]);
  //sitePanel.add()


  //add(RedPotion());
  //add(RedPotion());

  _resetWindowSize();
  window.onResize.listen((e) {
    _resetWindowSize();
  });
}

_resetWindowSize() {
  root.height = window.innerHeight;
  root.width = window.innerWidth;
  //document.body.style.height = '${height}';
  //    document.body.style.maxHeight = '${width}';
}

void sendMsg(String msg, data) {
  root.sendMsg(msg, data);
}

void start([Duration dt = const Duration(milliseconds: 100)]) {
  init();
  document.body.children.add(root.element);
  _dt = dt.inMilliseconds;
  Timer timer = new Timer.periodic(dt, _update);
}

void _update(Timer timer) {


  if (monsters.length == 0) {
    var max = rand.nextInt(currentSite.maxMonster);
    for (int i = 0;i < max;i++) {
      addMonster(createMonster());
    }
    currentSite.progress();
  }

  entities.remove((e) => e.die);

  entities.forEach((e) => e.update());

  checkBindings();
  //_updateEntities(this);
}


//class ItemHost {


_addItem(Item item) {
  item.init();
  //    items.add(item);
  //    itemPanel.addChild(item);
}

_removeItem(Item item) {
  //    items.remove(item);
  //    itemPanel.removeChild(item);
  //owner.removeChild(action);
}
//}
//
//void _updateEntities(View entity) {
//  for (int i = 0; i < entity.children.length; i++) {
//    var e = entity.children[i];
//    if (e.die) {
//      if (e.parent == null) {
//        throw new Exception('No parent!');
//      } else {
//        e.parent.remove(e);
//      }
//      i--;
//      continue;
//    }
//    if (e is Updatable) {
//      e.update();
//    }
//    _updateEntities(e);
//  }
//  entity.updateView();
//}

class GameEntity {
  bool _die;

  bool get die => _die;


  void update() {
  }

//
//  @override
//  add(View child) {
//    if (child is State) {
//      var me = this as StateHost;
//      me._addState(child);
//    } else if (child is Action) {
//      var me = this as ActionHost;
//      me._addAction(child);
//    } else if (child is Monster) {
//      var me = this as Game;
//      me._addMonster(child);
//    } else if (child is Role) {
//      var me = this as RoleHost;
//      me._addRole(child);
//      me.teamPanel.addRole(child);
//    } else if (child is Item) {
//      var me = this as ItemHost;
//      me._addItem(child);
//    } else {
//      super.addChild(child);
//    }
//  }
//
//
//  @override
//  remove(View child) {
//
//    if (child is State) {
//      var me = this as StateHost;
//      me._removeState(child);
//    } else if (child is Action) {
//      var me = this as ActionHost;
//      me._removeAction(child);
//    } else if (child is Monster) {
//      var me = this as Game;
//      me._removeMonster(child);
//    } else if (child is Role) {
//      var me = this as RoleHost;
//      me._removeRole(child);
//      me.teamPanel.removeRole(child);
//    } else if (child is Item) {
//      var me = this as ItemHost;
//      me._removeItem(child);
//    } else {
//      super.removeChild(child);
//    }
//  }

//  @override
//  GameEntity get parent => getGameParent(this);

//  GameEntity getGameParent(View entity) {
//    if (entity.entityParent is GameEntity) return entity.entityParent;
//    return getGameParent(entity.entityParent);
//  }
}

//class RoleHost {


//void _addRole(Role role) {
//  role.init();
//  roles.add(role);
////  rolePanel.addChild(role);
//}
//
//void _removeRole(Role role) {
//  roles.remove(role);
////  rolePanel.removeChild(role);
//}


//}

//class SiteHost {


//set siteLevel(int level) {
//  _currentSite.level = level;
//}


//  void _removeSite(Site site) {
//    //roles.remove(role);
//    //rolePanel.removeChild(role);
//  }
//}


//class Game extends GameEntity with RoleHost, SiteHost, ItemHost {
num _dt;

num get deltaTime => _dt;

Map<String, int> _items = new Map<String, int>();

//  Map<String, int> get items => _items;


int money = 0;

//int get money => _money;
int _research = 0;

int get research => _research;


View currentPanel;


//  Entity itemPanel = new Entity();
//View root = new View();


//Game() {
//  game = this;
//}

final GameInfoPanel infoPanel = new GameInfoPanel();


//  updateView() {
//
//
//
//    super.updateView();
//  }


void showPanel(View panel) {
  mainPanel.children.forEach((p) {
    p.visible = false;
  });

  panel.visible = true;
  //    panel.height = height - 140;
  currentPanel = panel;
  //  updateView();
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
  //  monsterPanel.addChild(monster);
}

void _removeMonster(Monster monster) {
  monsters.remove(monster);
  //  monsterPanel.removeChild(monster);
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
  money += money;
}

//void obtainLoot(Item item) {
//  add(item);
//}

Monster createMonster() {
  return currentSite.createMonster();
}


//}
