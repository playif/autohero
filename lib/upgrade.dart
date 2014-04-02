part of model;


class UpgradeView extends View {
  Upgrade upgrade;

  UpgradeView(this.upgrade) {
    width = 100;
    height = 100;
    border = 1;

    add(text(upgrade.name));

    onClick.listen((e) {
      
    });
  }
}

class Upgrade {
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