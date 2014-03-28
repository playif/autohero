import 'dart:html';
import 'dart:math';
import 'dart:async';

import 'package:htmlib/htmlib.dart';
import 'package:htmlib/game.dart';
//import 'ui.dart';



class MyGame extends Game {
  MyGame() {


  }

  @override
  init() {

    //print(window.innerHeight);
    //document.body.style.height = '${window.screen.height}';
    //document.body.style.maxHeight = '${window.screen.height}';

    //this.height = window.screen.height;

    var root = new GameEntity();
    root.classes.add('box');
    root.classes.add('vbox');
    //root.height = window.screen.height;

    addChild(root);
    //panel.add(new Entity());
    var header = new GameEntity();

    header.height = 70;
    var l = new Button();
    l.text = "中文";
    header.addChild(l);

    var l2 = new Button();
    l2.text = "中文2";
    header.addChild(l2);

    var body = new GameEntity();
    //body.height = window.screen.height;
    body.classes.add('box');
    body.classes.add('hbox');

    root.addChild(header);
    root.addChild(body);


    var rolePanel = new GameEntity();
    rolePanel.width = 200;
    //    rolePanel.classes.add('box');
    //    rolePanel.classes.add('vbox');

    var monsterPanel = new GameEntity();


    //panel.addChild(panel3);


    for (int i = 0;i < 100;i++) {
      var mon = createMonster();

      var state = Generation();
      //state.effect=10;
      //    state.attach(mon);
      mon.add(state);
      mon.add(Generation());
      mon.add(Generation2());
      mon.add(Generation());
      monsterPanel.add(mon);
    }

    //createMonster(panel2,mon);

    var r = Worrier();

    var action = Attack();

    r.add(action);

    rolePanel.add(r);

    var r2 = Worrier();

    var action2 = Attack();

    r2.add(action2);
    r2.add(Attack());

    rolePanel.add(r2);

    body.addChild(rolePanel);
    body.addChild(monsterPanel);


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
  game = new MyGame();
  game.start(document.body);
}
