part of model;


class TeamPanel extends TabPanel {
  List<Role> roles = [];

  TeamPanel() {
    tabs.cellMargin = 20;
  }

  @override
  void handleMsg(String msg, data) {
    if (msg == ADD_ROLE) {
      roles.add(data);
      RoleDetailPanel rdp = new RoleDetailPanel(data);
      rdp.cellPadding = 20;
      rdp.watchSize(panels);
      addPanel(new Label()
        ..text = data.name
        ..size = 34
        ..border = 1, rdp);
    }

  }

  //  addRole(Role role) {
  //
  //  }
  //
  //  removeRole(Role role) {
  //    roles.remove(role);
  //
  //  }

  onShow() {
    showPanelID(0);
  }

}

class ActionPanelHost {
  final Role role;


}

//class WeaponView view

class WeaponPanelHost {


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

    //super.init();
    add(new Label()
      ..text = role.name);
    print(role.name);
    levelLabel
      ..name = '等級: '
      ..bindField('text', role, 'level')
      ..size = 25;
    add(levelLabel);

    add(damageLabel
      ..name = '傷害: '
      ..bindField('text', role, 'damage')
      ..classes.add("small-text"));

    actionPanel.vertical = false;
    actionPanel.width = 200;
    actionPanel.height = 20;
    add(actionPanel);

    weaponPanel.vertical = false;
    weaponPanel.width = 200;
    weaponPanel.height = 200;
    add(weaponPanel);
    //add(itemPanel);


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