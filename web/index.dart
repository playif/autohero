import 'dart:html';
import 'dart:math';
import 'dart:async';

import 'package:htmlib/htmlib.dart';
import 'package:htmlib/game.dart';
//import 'ui.dart';



class MyGame extends Game {
  MyGame() {
    //print(window.innerHeight);
    document.body.style.height = '${window.screen.height}';
    document.body.style.maxHeight = '${window.screen.height}';

    this.height = window.screen.height;

    HBox panel = new HBox();
    panel.height = window.screen.height;

    add(panel);
    //panel.add(new Entity());
    var panel1 = new FlowBox();

    panel1.height = 100;
    var l = new Label();
    l.text = "中文，";
    panel1.add(l);

    var panel2 = new FlowBox();
    panel2.height = window.screen.height - 100;

    panel.add(panel1);
    panel.add(panel2);
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

    var mon = Mouse();

    var state = Generation();
    //state.effect=10;
    //    state.attach(mon);
    mon.attachState(state);

    panel2.add(mon);

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
  Game game = new MyGame();
  game.start(document.body);
}
