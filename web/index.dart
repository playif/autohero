import 'dart:html';
import 'dart:math';
import 'dart:async';

import 'package:autohero/view.dart';
import 'package:autohero/game.dart';


Button createMenuButton(String name, View panel) {
  var l = new Button();
  l.text = name;
  l.width = 116;
  l.size = 26;
  menuPanel.add(l);
  l.onClick.listen((e) {
    showPanel(panel);
  });

}

void main() {

  //    var l2 = new Button();


  createMenuButton("戰場", battlePanel);
  createMenuButton("隊伍", teamPanel);
  createMenuButton("地圖", sitePanel);
  createMenuButton("道具", itemPanel);
  createMenuButton("研究", itemPanel);
  createMenuButton("日記", itemPanel);
  createMenuButton("系統", itemPanel);

  Role r = Worrier();
  addRole(r);
  r.upgrades.add(up1(r));
  addRoleWeapon(Slot(), r);
  addRoleWeapon(Slot(), r);
  addRole(Mage());
  addRole(Mage());
  addRole(Mage());
  start();
  //root.updateView();
}
