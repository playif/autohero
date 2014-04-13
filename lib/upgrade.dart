part of game;


class UpgradeView extends View {
  final Upgrade upgrade;
  final Label levelLabel = new Label();

  UpgradeView(this.upgrade) {
    width = 100;
    height = 100;
    border = 1;

    add(text(upgrade.name));

    onClick.listen((e) {
      setToolTip(new Label()
        ..text = upgrade.name
        ..bindField('opacity', upgrade, 'enable', transform:(s) {
        if (s)return 1; else return 0.5;
      })
        ..onClick.listen((e) {
        if (upgrade.enable) {
          upgrade.modify(upgrade.role);
          upgrade.level += 1;
          upgrade.role.UP -= upgrade.cost;
        }
      }));


    });

    levelLabel
      ..name = '等級: '
      ..bindField('text', upgrade, 'level');
    add(levelLabel);

    bindField('opacity', upgrade, 'enable', transform:(s) {
      if (s)return 1; else return 0.5;
    });

  }
}

class Upgrade extends ModifierModel {
  String name;

  //String desc;
  int cost = 1;
  int minRoleLevel = 0;
  int maxLevel = 0;
  int level = 0;

  final Role role;

  Upgrade(this.role) {

  }

  bool get enable {
    return role.UP >= cost;
  }

  String getDesc() {

  }


}

Map<Creator<Upgrade>, int> upgradeProb = {
    up1:10
};
Dict<Upgrade> UpgradeDict = new Dict<Upgrade>(upgradeProb, [up1, up2]);

Upgrade up1(target) {
  Upgrade up = new Upgrade(target);
  up
    ..name = "戰鬥訓練"

    ..addModifier('damage', [1, 1, 1, 1, 1, 2, 2, 2, 2, 3]);
  return up;
}

Upgrade up2() {
  Upgrade up = new Upgrade()
    ..name = "H2";

  return up;
}