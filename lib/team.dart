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
      rdp.watchSize(panels);
      addPanel(new Label()
        ..text = data.name
        ..size = 34
        ..border = 1, rdp);
    }

  }

  addRole(Role role) {

  }

  removeRole(Role role) {
    roles.remove(role);

  }

}

class RoleDetailPanel extends View {


  final Role role;
  final View actionPanel = new View();
  final Label levelLabel = new Label();
  final Label damageLabel = new Label();

  RoleDetailPanel(this.role) {

  }

  init() {

    //super.init();
    add(new Label()
      ..text = role.name);
    print(role.name);
    levelLabel
      ..name = '等級: '
      ..watch('text', role, 'level')
      ..classes.add("small-text");
    add(levelLabel);

    add(damageLabel
      ..name = '傷害: '
      ..watch('text', role, 'damage')
      ..classes.add("small-text"));


    add(actionPanel);
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