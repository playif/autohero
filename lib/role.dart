part of game;

class BattleRolePanel extends View {

  BattleRolePanel() {
    cellMargin = 15;
    bindList(roles, RoleView);
  }

//  @override
//  void handleMsg(String msg, data) {
//    if (msg == ADD_ROLE) {
//      RoleView view = new RoleView(data);
//      add(view);
//
//    }
//
//  }


}

class RoleView extends View {
  //  final Role role;

  //final Role role;
  //  final View actionPanel = new View();


  Bar expBar = new Bar();
  Label levelLabel = new Label();
  Label damageLabel = new Label();

  RoleView(this.role);

  //  @override
  //  void handleMsg(String msg, data) {
  //    if (msg == ADD_ROLE_ACTION) {
  //      ActionView view = new ActionView(data[0]);
  //      actionPanel.add(view);
  //    }
  //
  //  }

  final Role role;
  final View weaponPanel = new View();
  final View actionPanel = new View();

  Map<Item, View> views = {
  };

  //  @override
  //  void handleMsg(String msg, data) {
  //    //    Role role = data[1];
  //    //    Weapon weapon = data[0];
  //    if (msg == ADD_ROLE_WEAPON && data[1] == role) {
  //      WeaponView view = new WeaponView(data[0]);
  //      weaponPanel.insert(role.weapons.indexOf(data[0]), view);
  //      views[data[0]] = view;
  //    } else if (msg == REMOVE_ROLE_WEAPON && data[1] == role) {
  //      //WeaponView view = new WeaponView(data[0]);
  //      weaponPanel.remove(views[data[0]]);
  //      views.remove(data[0]);
  //    } else if (msg == ADD_ROLE_ACTION && data[1] == role) {
  //      ActionView view = new ActionView(data[0]);
  //      actionPanel.add(view);
  //    }
  //
  //  }

  void init() {

    width = 180;
    height = 90;

    onClick.listen((e) {
      var idx = roles.indexOf(role);
      mainPanel.showPanel(teamPanel);
      teamPanel.showPanelID(idx);
    });

    actionPanel.height = 20;
    actionPanel.bindField('width', this, 'width');
    actionPanel.style.overflow = 'hidden';
    actionPanel.vertical = false;

    weaponPanel.vertical = false;
    weaponPanel.bindField('width', this, 'width');
    weaponPanel.height = 52;
    weaponPanel.cellMargin = 15;
    weaponPanel.cellSize(50, 50);

    add(new Label()
      ..text = role.name);

    //    levelLabel = new Label()
    //      ..name = "等級: "
    //      ..classes.add("small-text");

    //    levelLabel.bindField('text', role, 'level');

    //    add(levelLabel);

    add(damageLabel
      ..name = "傷害: "
      ..classes.add("small-text"));
    damageLabel.bindField('text', role, 'damage');

    add(actionPanel);
    //add(weaponPanel);


    add(expBar);
    expBar.width = 188;
    expBar.height = 5;
    expBar.color = 0;
    expBar.bindField('max', role, 'MXP');
    expBar.bindField('min', role, 'XP');

    //    classes.add('box');
    //    classes.add('vbox');
    //    classes.add('border');
    //    classes.add('small-margin');

    border = 1;
    borderColorH = 0;


    actionPanel.bindList(role.actions, ActionView);
    //weaponPanel.bindList(role.weapons,WeaponView);
  }
}

class Role extends Model {

  final List<Action> actions = [];
  final List<Weapon> weapons = [];
  final List<Upgrade> upgrades = [];

  //List<ActionCreator<Role>> bindedActions = [];

  num level = 1;

  String name = "role";
  num damage = 1;

  num MXP = 20;

  num XP = 0;

  int UP = 0;


  @override
  void update() {


  }

  void check() {

    if (XP >= MXP) {
      XP = 0;
      level += 1;
      UP += 1;
      //      levelLabel
      //        ..text = "等級:${level}";
      MXP += level * level * 2;
      damage += 1;
      //      damageLabel
      //        ..text = "傷害:${damage}";
    }

    //    expBar.max = MXP;
    //    expBar.min = XP;

  }

//  @override
//  add(Entity child) {
//    Entity.add(child);
//    super.add(child);
//    if (child is State) {
//      _attachState(this,child);
//    }
//  }
//
//  @override
//  remove(Entity child) {
//    super.remove(child);
//    if (child is State) {
//      _detachState(this,child);
//    }
//  }

}

Role Worrier() {
  Role role = new Role();
  role
    ..name = "戰士"
    ..damage = 4
    ..actions.add(Attack(role));

  return role;
}

Role Mage() {
  Role role = new Role();
  role
    ..name = "法師"
    ..damage = 2

  //  addRoleAction(AttackAll());
    ..actions.add(AttackAll(role));

  return role;
}