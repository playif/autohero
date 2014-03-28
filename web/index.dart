import 'dart:html';
import 'dart:math';
import 'dart:async';

import 'package:htmlib/htmlib.dart';
import 'package:htmlib/game.dart';
//import 'ui.dart';

class MonsterPanel extends GameEntity {

}

class MyGame extends Game {
  MyGame() {


  }

  @override
  init() {

    //print(window.innerHeight);
    document.body.style.height = '${window.screen.height}';
    document.body.style.maxHeight = '${window.screen.height}';

    this.height = window.screen.height;

    HBox panel = new HBox();
    panel.height = window.screen.height;

    addChild(panel);
    //panel.add(new Entity());
    var panel1 = new FlowBox();

    panel1.height = 100;
    var l = new Label();
    l.text = "中文，";
    panel1.addChild(l);

    var panel2 = new MonsterPanel();
    panel2.height = window.screen.height - 100;

    panel.addChild(panel1);
    panel.addChild(panel2);
    //Entity<Box> boxes=new Entity<Box>();
    //boxes.add(new Entity());

    Random rand = new Random();

    for (int i = 0; i < 10; i++) {
      var label = new Label();
      label.text = "中文，${window.screen.height}";
      //label.add(new Label("l2"));
      //label.style.position = 'absolute';
      panel2.add(label);


      //label.width = 50;
      //label.height = 50;
      //label.classes.add('border');
      //    label.width=rand.nextInt(100);
      //    label.height=rand.nextInt(100);
    }

    var mon = createMonster();

    var state = Generation();
    //state.effect=10;
    //    state.attach(mon);
    mon.add(state);
    mon.add(Generation());
    mon.add(Generation());
    mon.add(Generation());
    panel2.add(mon);
    //createMonster(panel2,mon);

    var r = new Role();

    var action = Attack();
    r.add(action);

    panel2.add(r);

    for (int i = 0;i < 100000;i++) {
      var item = new Weapon();
      QualityBuff.pick()(item);
      if (item.quality >= 12) {

        var label = new Label();
        label.text = "中文，${item.name}";
        //label.add(new Label("l2"));
        //label.style.position = 'absolute';
        panel2.add(label);
        print(item.name);
      }

      //print(item.name);
    }
  }
}


void main() {
  game = new MyGame();
  game.start(document.body);
}
