part of dungeon;

class Upgrade extends Entity {
  String name;
  String desc;
}

Map<Creator<Upgrade>, int> upgradeProb = {up1:10};
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


class Role extends Entity with Updatable {
  List<Action> actions = [];

  List<Item> items = [];

  List<Upgrade> upgrades = [];

  num level = 0;

  String name = "role";
  num damage=0;

  @override
  void update(Game game) {
    actions.forEach((s) {
      s.update(game);
    });
  }


}

Role role1() {
  Role role = new Role();


  return role;
}

