part of model;

class GameInfoPanel extends View {


  init() {
    border = 0;

    add(new Label()
      ..text = '資訊版面');
    //infoPanel.breakLine();
    add(new Label()
      ..name = "金幣: "
      ..watch('text', game, 'money', transform:(m) {
      return "<b>$m</b>";
    }));

  }
}

class TeamPanel extends TabPanel {
  List<Role> roles = [];

  init() {
    super.init();
    tabs.cellMargin = 5;
    //    addPanel(new Label()
    //      ..text = "t1", new Label()
    //      ..text = "t2");
    //    addPanel(new Label()
    //      ..text = "t3", new Label()
    //      ..text = "t4");

    //setPanelID(0);
  }

  addRole(Role role) {
    roles.add(role);
    RoleDetailPanel rdp = new RoleDetailPanel(role);
    rdp.init();
    rdp.watchSize(panels);
    addPanel(new Label()
      ..text = role.name
      ..border = 1, rdp);
  }

  removeRole(Role role) {
    roles.remove(role);

    //TODO
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

    levelLabel = new Label()
      ..name = '等級: '
      ..watch('text', role, 'level')
      ..classes.add("small-text");
    add(levelLabel);

    add(damageLabel
      ..name = '傷害: '
      ..watch('text', role, 'damage')
      ..classes.add("small-text"));


    add(actionPanel);
    add(itemPanel);


    //setPanelID(0);
  }
}