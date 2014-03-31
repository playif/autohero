part of model;

class Upgrade extends View {
  String name;
  String desc;
}

Map<Creator<Upgrade>, int> upgradeProb = {
    up1:10
};
Dict<Upgrade> UpgradeDict = new Dict<Upgrade>(upgradeProb, [up1, up2]);

Upgrade up1() {
  Upgrade up = new Upgrade()
    ..name = "H1";

  return up;
}

Upgrade up2() {
  Upgrade up = new Upgrade()
    ..name = "H2";

  return up;
}


class RoleView extends View {
  final Role role;


  final View actionPanel = new View();
  Bar expBar = new Bar();
  Label levelLabel = new Label();
  Label damageLabel = new Label();

  RoleView(this.role);

  void init() {
    width = 200;
    height = 150;
    actionPanel.height = 20;
    actionPanel.watch('width', this, 'width');
    actionPanel.style.overflow = 'hidden';
    add(new Label()
      ..text = role.name);

    levelLabel = new Label()
      ..text = "等級:${role.level}"
      ..classes.add("small-text");
    add(levelLabel);

    add(damageLabel
      ..text = "傷害:${role.damage}"
      ..classes.add("small-text"));


    add(actionPanel);
    add(itemPanel);


    add(expBar);
    expBar.width = 188;
    expBar.height = 5;
    expBar.color = 0;
    expBar.max = role.MXP;
    expBar.min = role.XP;

    width = 190;
    //    classes.add('box');
    //    classes.add('vbox');
    //    classes.add('border');
    //    classes.add('small-margin');

    border = 1;
    borderColorH = 0;
  }
}

class Role extends GameEntity {

  final List<Action> actions = [];
  final List<Item> items = [];

  List<Upgrade> upgrades = [];

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
    ..actions.add(Attack());

  return role;
}

Role Mage() {
  Role role = new Role();
  role
    ..name = "法師"
    ..damage = 2

  //  addRoleAction(AttackAll());
    ..actions.add(AttackAll());

  return role;
}