library model;

import 'dart:html';
import 'dart:async';
import 'dart:math';

import 'view.dart';
import 'model.dart';

part 'panel.dart';
part 'action.dart';
part 'item.dart';
part 'monster.dart';
part 'team.dart';
part 'role.dart';
part 'upgrade.dart';

part 'site.dart';
part 'state.dart';
part 'dict.dart';


const DELTA_TIME = 100;

//game model
final GameModel game = new GameModel();

class GameModel extends Model {
  int money = 0;
  Site _currentSite = StartLand();
}
//top level array
final List<Role> roles = [];
final List<Item> inventoryItems = [];
final List<Model> entities = [];
final List<Monster> monsters = [];
final List<Site> sites = [StartLand(), StartLand2()];


//views
final View root = new View();
final View menuPanel = new View();
final View contentPanel = new View();

final View battlePanel = new View();
final View sitePanel = new View();
final View siteInfoPanel = new View();
final ItemPanel itemPanel = new ItemPanel();
final LayerPanel mainPanel = new LayerPanel();
final BattleRolePanel battleRolePanel = new BattleRolePanel();
final BattleMonsterPanel battleMonsterPanel = new BattleMonsterPanel();
final TeamPanel teamPanel = new TeamPanel();
final GameInfoPanel infoPanel = new GameInfoPanel();


const String ROLE = 'role';
const String ITEM = 'item';
const String ADD_ROLE = 'addRole';
const String REMOVE_ROLE = 'removeRole';
const String ADD_MONSTER = 'addMonster';
const String REMOVE_MONSTER = 'removeMonster';
const String ADD_INVENTORY_ITEM = 'addInventoryItem';
const String ADD_ROLE_ACTION = 'addRoleAction';
const String REMOVE_ROLE_ACTION = 'removeRoleAction';
const String EQUIP = 'equip';

void addRole(Role role) {
  roles.add(role);
  root.sendMsg(ADD_ROLE, role);

  role.bindedActions.forEach((ActionCreator<Role> a) {
    addRoleAction(a(role), role);
  });

}

void removeRole(Role role) {
  roles.remove(role);
  root.sendMsg(REMOVE_ROLE, role);
}

//void addRoleAction(Action action, Role role) {
//  role.actions.add(action);
//  setRoleAction(action,role);
//  //root.sendMsg(ADD_ROLE_ACTION, [action, role]);
//}

void addRoleAction(Action action, Role role) {

  role.actions.add(action);
  //  action.role=role;
  root.sendMsg(ADD_ROLE_ACTION, [action, role]);
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

  game._currentSite = site;

  //site.init();
  //sites.add(site);
  //sitePanel.addChild(role);
}


//bindBodyPanel(View panel) {
//  panel.watchSize(mainPanel);
//  mainPanel.add(panel);
//}

init() {


  mainPanel.watch('width', root, 'width', transform:(s) => s - 200);
  mainPanel.watch('height', contentPanel, 'height');

  mainPanel.addPanel(battlePanel);
  //
  mainPanel.addPanel(sitePanel);
  mainPanel.addPanel(teamPanel);

  mainPanel.addPanel(itemPanel);
  //  teamPanel.init();

  itemPanel.vertical = false;
  itemPanel.wrap = true;

  battlePanel.vertical = false;
  battlePanel.add(battleRolePanel);
  battlePanel.add(battleMonsterPanel);

  battleRolePanel.width = 200;
  battleRolePanel.watch('height', mainPanel, 'height');

  battleMonsterPanel.watch('height', mainPanel, 'height');
  battleMonsterPanel.watch('width', mainPanel, 'width', transform:(s) => s - battleRolePanel.width);
  battleMonsterPanel.cellMargin = 5;
  battleMonsterPanel.vertical = false;
  battleMonsterPanel.wrap = true;

  menuPanel.height = 70;
  menuPanel.watch('width', root, 'width');
  menuPanel.cellMargin = 15;
  menuPanel.vertical = false;


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


  sites.forEach((Site s) {
    //s.init();
    SiteButton siteButton = new SiteButton(s);

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

void start([Duration dt = const Duration(milliseconds: DELTA_TIME)]) {
  init();
  document.body.children.add(root.element);
  //  _dt = dt.inMilliseconds;
  Timer timer = new Timer.periodic(dt, _update);

  game._currentSite.setLevel(1);
}

void _update(Timer timer) {
  if (monsters.length == 0) {
    var max = rand.nextInt(game._currentSite.maxMonster);
    for (int i = 0;i < max;i++) {
      addMonster(createMonster());
      //print("m");
    }
    game._currentSite.progress();
  }

  //entities.remove((Model e) => e.die);
  //entities.forEach((Model e) => e.update());

  roles.forEach((Role r) {
    r.actions.forEach((Action a) {
      a.update();
    });
  });


  checkBindings();
  root.updateView();
  //_updateEntities(this);
}


//class ItemHost {


//_addItem(Item item) {
//  //  item.init();
//  //    items.add(item);
//  //    itemPanel.addChild(item);
//}
//
//_removeItem(Item item) {
//  //    items.remove(item);
//  //    itemPanel.removeChild(item);
//  //owner.removeChild(action);
//}
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
//num _dt;


//Map<String, int> _items = new Map<String, int>();

//  Map<String, int> get items => _items;


//int money = 0;

//int get money => _money;
//int _research = 0;

//int get research => _research;


//  Entity itemPanel = new Entity();
//View root = new View();


//Game() {
//  game = this;
//}


//  updateView() {
//
//
//
//    super.updateView();
//  }


void showPanel(View panel) {
  mainPanel.showPanel(panel);
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
    return monsters.where((m) => !m.die).toList();
  } else return null;
}

//void _addMonster(Monster monster) {
//  //  monster.init();
//  monsters.add(monster);
//  //  monsterPanel.addChild(monster);
//}
//
//void _removeMonster(Monster monster) {
//  monsters.remove(monster);
//  //  monsterPanel.removeChild(monster);
//}


void obtainExp(num xp) {
  var n = roles.length;
  num rxp = xp / n;

  for (int i = 0;i < roles.length;i++) {
    roles[i].XP += rxp;
    roles[i].check();
  }
}

void obtainMoney(num money) {
  game.money += money;
}

//void obtainLoot(Item item) {
//  add(item);
//}

Monster createMonster() {
  return game._currentSite.createMonster();
}


//}
