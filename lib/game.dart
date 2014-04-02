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
  Site currentSite;
  Role currentRole;
  Weapon currentItem;
  int currentItemIndex = -1;
  int currentWeaponIndex = -1;
}
//top level array
final List<Role> roles = [];
final List<Item> inventoryItems = [];
final List<Model> entities = [];
final List<Monster> monsters = [];
final List<Site> sites = [];


//views
final View root = new View();
final View menuPanel = new View();
final View contentPanel = new View();

final View battlePanel = new View();
final SitePanel sitePanel = new SitePanel();
final View siteInfoPanel = new View();
final View toolTipPanel = new View();
final ItemPanel itemPanel = new ItemPanel();
final LayerPanel mainPanel = new LayerPanel();
final BattleRolePanel battleRolePanel = new BattleRolePanel();
final BattleMonsterPanel battleMonsterPanel = new BattleMonsterPanel();
final TeamPanel teamPanel = new TeamPanel();
final GameInfoPanel infoPanel = new GameInfoPanel();
final WeaponSelectPanel weaponSelectPanel = new WeaponSelectPanel();

//const String ROLE = 'role';
//const String ITEM = 'item';
//const String ADD_ROLE = 'addRole';
//const String REMOVE_ROLE = 'removeRole';
//const String ADD_MONSTER = 'addMonster';
//const String REMOVE_MONSTER = 'removeMonster';
//const String ADD_INVENTORY_ITEM = 'addInventoryItem';
//const String REMOVE_INVENTORY_ITEM = 'removeInventoryItem';
//const String ADD_ROLE_ACTION = 'addRoleAction';
//const String REMOVE_ROLE_ACTION = 'removeRoleAction';
//const String ADD_SITE = 'addSite';
//const String REMOVE_SITE = 'removeSite';
//const String ADD_ROLE_WEAPON = 'addRoleWeapon';
//const String REMOVE_ROLE_WEAPON = 'removeRoleWeapon';

const String EQUIP = 'equip';

void addRole(Role role) {
  roles.add(role);
  //  root.sendMsg(ADD_ROLE, role);

  //  role.bindedActions.forEach((ActionCreator<Role> a) {
  //    addRoleAction(a(role), role);
  //  });

}

void removeRole(Role role) {
  roles.remove(role);
  //  root.sendMsg(REMOVE_ROLE, role);
}

//void addRoleAction(Action action, Role role) {
//  role.actions.add(action);
//  setRoleAction(action,role);
//  //root.sendMsg(ADD_ROLE_ACTION, [action, role]);
//}

void addRoleAction(Action action, Role role) {
  role.actions.add(action);
  //  root.sendMsg(ADD_ROLE_ACTION, [action, role]);
}

void removeRoleAction(Action action, Role role) {
  role.actions.remove(action);
  //  root.sendMsg(REMOVE_ROLE_ACTION, [action, role]);
}

void addMonster(Monster monster) {
  monsters.add(monster);
  //  root.sendMsg(ADD_MONSTER, monster);
}

void removeMonster(Monster monster) {
  monsters.remove(monster);
  //  root.sendMsg(REMOVE_MONSTER, monster);
}

void addRoleWeapon(Weapon weapon, Role role, [int index=-1]) {
  if (index == -1) index = role.weapons.length;
  //  print(index);
  weapon.equip(role);
  role.weapons.insert(index, weapon);
  //  root.sendMsg(ADD_ROLE_WEAPON, [weapon, role]);
}

void removeRoleWeapon(Weapon weapon, Role role) {
  weapon.unequip(role);
  role.weapons.remove(weapon);
  //  root.sendMsg(REMOVE_ROLE_WEAPON, [weapon, role]);
}

void addSite(Site site) {
  sites.add(site);
  //  root.sendMsg(ADD_SITE, site);
}

void removeSite(Site site) {
  sites.remove(site);
  //  root.sendMsg(REMOVE_SITE, site);
}

void addInventoryItem(Item item) {
  //  if (index == -1) index = inventoryItems.length;
  //  print(index);
  inventoryItems.add(item);
  //  root.sendMsg(ADD_INVENTORY_ITEM, item);
}

void removeInventoryItem(Item item) {
  inventoryItems.remove(item);
  //  root.sendMsg(REMOVE_INVENTORY_ITEM, item);
}

String slotName = '空格';

void equip(Weapon weapon, Role role) {
  //print(game.currentWeaponIndex);
  if (weapon.name == slotName) {
    addRoleWeapon(Slot(), role, game.currentWeaponIndex);
  } else if (weapon.name != slotName) {
    addRoleWeapon(weapon, role, game.currentWeaponIndex);
    removeInventoryItem(weapon);
  }
}

void unEquip(Weapon weapon, Role role) {
  removeRoleWeapon(weapon, role);
  if (weapon.name != slotName) {
    addInventoryItem(weapon);
  }
}

void showWeapons() {
  weaponSelectPanel.visible = true;
}

void hideWeapons() {
  weaponSelectPanel.visible = false;
}

void setToolTip(View tip) {
  toolTipPanel.removeAll();
  toolTipPanel.add(tip);
}

void setSite(Site site) {
  siteInfoPanel.removeAll();

  siteInfoPanel.add(new SiteView(site));

  game.currentSite = site;
}


//bindBodyPanel(View panel) {
//  panel.watchSize(mainPanel);
//  mainPanel.add(panel);
//}

init() {
  root.width = 960;
  root.height = 540;
  root.backgroundColorH = 0;
  root.backgroundColorL = 10;
  root.backgroundColorS = 10;

  mainPanel.bindField('width', root, 'width', transform:(s) => s - 200);
  mainPanel.bindField('height', contentPanel, 'height');

  mainPanel.addPanel(battlePanel);
  mainPanel.addPanel(sitePanel);
  mainPanel.addPanel(teamPanel);
  mainPanel.addPanel(itemPanel);
  mainPanel.cellPadding = 15;

  //  teamPanel.init();


  battlePanel.vertical = false;
  battlePanel.add(battleRolePanel);
  battlePanel.add(battleMonsterPanel);

  battleRolePanel.width = 200;
  battleRolePanel.bindField('height', battlePanel, 'height');

  battleMonsterPanel.bindField('height', battlePanel, 'height');
  battleMonsterPanel.bindField('width', battlePanel, 'width', transform:(s) => s - battleRolePanel.width);


  menuPanel.height = 70;
  menuPanel.bindField('width', root, 'width');
  menuPanel.cellMargin = 15;
  menuPanel.cellPadding = 15;
  menuPanel.vertical = false;


  infoPanel.bindField('height', contentPanel, 'height');
  infoPanel.width = 200;
  siteInfoPanel.height = 120;
  siteInfoPanel.bindField('width', infoPanel, 'width');


  contentPanel.bindField('height', root, 'height', transform:(s) => s - 70);
  contentPanel.bindField('width', root, 'width');
  contentPanel.vertical = false;

  //infoPanel.vertical = false;

  root.add(menuPanel);
  root.add(contentPanel);

  contentPanel.add(mainPanel);
  contentPanel.add(infoPanel);
  infoPanel.add(siteInfoPanel);
  infoPanel.add(toolTipPanel);

  toolTipPanel.width = 200;
  toolTipPanel.height = 270;

  showPanel(battlePanel);

  //    setSite(StartLand());
  //    var moneyLabel = ;


  //  sites.forEach((Site s) {
  //    //s.init();
  //    SiteButton siteButton = new SiteButton(s);
  //
  //    siteButton.init();
  //    //    sitePanel.add(siteButton);
  //  });
  addSite(StartLand());
  addSite(StartLand2());

  //siteInfoPanel.add(new SiteView(sites[0]));

  setSite(sites[0]);
  //sitePanel.add()

  root.add(weaponSelectPanel);
  //add(RedPotion());
  //add(RedPotion());

  _resetWindowSize();
  window.onResize.listen((e) {
    _resetWindowSize();
  });
}


_resetWindowSize() {
  //  root.height = window.innerHeight;
  //  root.width = window.innerWidth;
  //document.body.style.height = '${height}';
  //    document.body.style.maxHeight = '${width}';
}

//void sendMsg(String msg, data) {
//  root.sendMsg(msg, data);
//}

void start([Duration dt = const Duration(milliseconds: DELTA_TIME)]) {

  init();

  document.body.children.add(root.element);

  //  _dt = dt.inMilliseconds;
  Timer timer = new Timer.periodic(dt, _update);

  game.currentSite.setLevel(1);


}

void _update(Timer timer) {
  if (monsters.length == 0) {
    var max = rand.nextInt(game.currentSite.maxMonster);
    for (int i = 0;i < max;i++) {
      addMonster(createMonster());
    }
    game.currentSite.progress();
  }

  roles.forEach((Role r) {
    r.actions.forEach((Action a) {
      a.update();
    });
  });

  root.updateView();
}

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

Monster createMonster() {
  return game.currentSite.createMonster();
}
