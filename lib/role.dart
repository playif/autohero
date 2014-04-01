part of model;

class BattleRolePanel extends View {

  BattleRolePanel() {
    cellMargin = 15;
  }

  @override
  void handleMsg(String msg, data) {
    if (msg == ADD_ROLE) {
      RoleView view = new RoleView(data);
      add(view);

    }

  }

}

class RoleView extends View {
  final Role role;


  final View actionPanel = new View();
  final View weaponPanel = new View();

  Bar expBar = new Bar();
  Label levelLabel = new Label();
  Label damageLabel = new Label();

  RoleView(this.role);

  @override
  void handleMsg(String msg, data) {
    if (msg == ADD_ROLE_ACTION) {
      ActionView view = new ActionView(data[0]);
      actionPanel.add(view);
    }

  }

  void init() {
    width = 180;
    height = 150;
    actionPanel.height = 20;
    actionPanel.watch('width', this, 'width');
    actionPanel.style.overflow = 'hidden';
    add(new Label()
      ..text = role.name);

    levelLabel = new Label()
      ..name = "等級: "
      ..classes.add("small-text");

    levelLabel.watch('text', role, 'level');

    add(levelLabel);

    add(damageLabel
      ..name = "傷害: "
      ..classes.add("small-text"));
    damageLabel.watch('text', role, 'damage');

    add(actionPanel);
    add(weaponPanel);


    add(expBar);
    expBar.width = 188;
    expBar.height = 5;
    expBar.color = 0;
    expBar.watch('max', role, 'MXP');
    expBar.watch('min', role, 'XP');

    //    classes.add('box');
    //    classes.add('vbox');
    //    classes.add('border');
    //    classes.add('small-margin');

    border = 1;
    borderColorH = 0;
  }
}

class Role extends Model {

  final List<Action> actions = [];
  final List<Weapon> weapons = [];

  List<Upgrade> upgrades = [];

  List<ActionCreator<Role>> bindedActions = [];

  num level = 1;

  String name = "role";
  num damage = 1;

  num MXP = 20;

  num XP = 0;


  @override
  void update() {


  }

  void check() {

    if (XP >= MXP) {
      XP = 0;
      level += 1;
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
    ..bindedActions.add(Attack);

  return role;
}

Role Mage() {
  Role role = new Role();
  role
    ..name = "法師"
    ..damage = 2

  //  addRoleAction(AttackAll());
    ..bindedActions.add(AttackAll);

  return role;
}