import 'dart:html';
import 'dart:math';
import 'dart:async';

import 'package:autohero/view.dart';
import 'package:autohero/game.dart';
//import 'ui.dart';



class MyGame extends Game {

  Button createMenuButton(String name, View show) {
    var l = new Button();
    l.text = name;
    l.width = 120;
    l.size = 40;
    menuPanel.addChild(l);
    l.onClick.listen((e) {
      showPanel(show);
    });

  }

  MyGame() {


  }

  @override
  init() {

    //print(window.innerHeight);
    //document.body.style.height = '${window.screen.height}';
    //document.body.style.maxHeight = '${window.screen.height}';

    //this.height = window.screen.height;


    //panel.add(new Entity());

    createMenuButton("戰鬥",battlePanel);
    createMenuButton("隊伍", sitePanel);
    createMenuButton("地圖", sitePanel);
    createMenuButton("道具", itemPanel);
    createMenuButton("研究", itemPanel);
    createMenuButton("日記", itemPanel);
    createMenuButton("系統", itemPanel);
    //    var l2 = new Button();
    //    l2.text = "中文2";
    //    l2.width=100;
    //    menuPanel.addChild(l2);
    //    l2.onClick.listen((e) {
    //      showPanel(itemPanel);
    //    });

    //
    //
    //
    //    var rolePanel = new Entity();
    //
    //    //    rolePanel.classes.add('box');
    //    //    rolePanel.classes.add('vbox');
    //
    //    var monsterPanel = new Entity();


    //panel.addChild(panel3);


    //    for (int i = 0;i < 100;i++) {
    //      var mon = createMonster();
    //
    //      var state = Generation();
    //      //state.effect=10;
    //      //    state.attach(mon);
    //      mon.add(state);
    //      mon.add(Generation());
    //      mon.add(Generation2());
    //      mon.add(Generation());
    //      add(mon);
    //    }

    //createMonster(panel2,mon);

    var r = Worrier();

    var action = Attack();

    r.add(action);

    add(r);

    var r2 = Worrier();

    var action2 = Attack();

    //r2.add(action2);
    //r2.add(AttackAll());

    add(r2);


    //    for (int i = 0; i < 100000; i ++) {
    //      var item = new Weapon();
    //      QualityBuff.pick()(item);
    //      if (item.quality >= 12) {
    //
    //        var label = new Label();
    //        label.text = "中文，${item.name}";
    //        //label.add(new Label("l2"));
    //        //label.style.position = 'absolute';
    //        body.add(label);
    //        print(item.name);
    //      }
    //
    //      //print(item.name);
    //    }
  }
}


void main() {
  //initView();
  game = new MyGame();
  game.start();
}
