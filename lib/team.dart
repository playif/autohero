part of game;


class TeamPanel extends TabPanel {
  //List<Role> roles = [];

  TeamPanel() {
    tabs.cellMargin = 45;
    tabWidth = 170;
    cellMargin = 15;
    //print(roles);
    tabs.bindList(roles, RoleTabView);
    panels.bindList(roles, RoleDetailPanel);
  }

  //  @override
  //  void handleMsg(String msg, data) {
  //    if (msg == ADD_ROLE) {
  //      roles.add(data);
  //      RoleDetailPanel rdp = new RoleDetailPanel(data);
  //      rdp.cellPadding = 20;
  //      rdp.watchSize(panels);
  //      addPanel(new Label()
  //        ..text = data.name
  //        ..size = 34
  //        ..border = 1, rdp);
  //    }
  //
  //  }

  //  addRole(Role role) {
  //
  //  }
  //
  //  removeRole(Role role) {
  //    roles.remove(role);
  //
  //  }

  onShow() {
    //print("here");
    showPanelID(0);
  }

}

//class ActionPanelHost {
//  final Role role;
//
//
//}
//
////class WeaponView view
//
//class WeaponPanelHost {
//
//
//}
class RoleTabView extends Label {
  RoleTabView(Role role) {
    this.text = role.name;
    size = 34;
    border = 1;
  }

  init() {
    onClick.listen((s) {
      var tp = parent.parent as TabPanel;
      tp.showPanelTab(this);
    });
  }
}

class RoleDetailPanel extends RoleView {


  final Label levelLabel = new Label();
  final Label damageLabel = new Label();
  final View upgradePanel = new View();


  RoleDetailPanel(Role role) :super(role) {

  }

  onShow() {
    game.currentRole = role;
  }


  init() {
    watchSize(parent);
    //super.init();
    add(new Label()
      ..text = role.name
      ..size = 25);
    print(role.name);
    levelLabel
      ..name = '等級: '
      ..bindField('text', role, 'level');
    add(levelLabel);

    add(damageLabel
      ..name = '傷害: '
      ..bindField('text', role, 'damage')
      ..classes.add("small-text"));

    add(new Label()
      ..text = '裝備: '
      ..size = 25);
    //    actionPanel.vertical = false;
    //    actionPanel.bindField('width',this,'width');
    //    actionPanel.height = 20;
    //    add(actionPanel);

    weaponPanel.vertical = false;
    weaponPanel.bindField('width', this, 'width');
    weaponPanel.height = 102;
    weaponPanel.cellMargin = 15;
    add(weaponPanel);
    //add(itemPanel);

    add(new Label()
      ..text = '升級: '
      ..size = 25);

    //actionPanel.bindList(role.actions,ActionView);
    weaponPanel.bindList(role.weapons, WeaponView);

    upgradePanel.vertical = false;
    upgradePanel.bindField('width', this, 'width');
    upgradePanel.height = 102;
    upgradePanel.cellMargin = 15;
    add(upgradePanel);

    upgradePanel.bindList(role.upgrades, UpgradeView);
    //setPanelID(0);
  }
}

//
//class Team extends View {
//  int money = 0;
//  int research = 0;
//
//
//}