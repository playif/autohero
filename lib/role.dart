part of dungeon;

class Upgrade extends Entity {
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


class Role extends GameEntity with StateHost, ActionHost {


  List<Item> items = [];

  List<Upgrade> upgrades = [];

  num level = 0;

  String name = "role";
  num damage = 0;


  void init() {
    add(new Label()
      ..text = this.name);
    add(new Label()
      ..text = "等級:${level}"
      ..classes.add("small-text"));

    add(actionPanel);
  }

  @override
  void update() {
    //    actions.forEach((s) {
    //      s.update();
    //    });
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

Role role1() {
  Role role = new Role();


  return role;
}

