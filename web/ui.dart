import 'package:htmlib/htmlib.dart';
import 'package:htmlib/game.dart';
import 'dart:math';


class Bar extends Entity with Updatable {
  num max = 10;
  num min = 10;
  num color;
  Entity minBar = new Entity();

  Bar() {
    width = 10;
    classes.add('border');
    minBar.style.backgroundColor = 'red';

    add(minBar);
  }

  @override
  void set height(num value) {
    super.height = value;
    minBar.height = value;
  }

  @override
  void update() {
    if (min > max) min = max;
    minBar.width = min / max * width;
  }
}


class Item extends Label with Updatable {
  Label name;
  int count = 0;
  Random rand = new Random();

  Bar bar = new Bar();

  Item() {
    name = new Label();
    name.text = "XD!";

    onClick.listen((e) {
      print('Hi');
      leave();
    });

    add(name);


    bar
        ..width = 20
        ..height = 5
        ..max = 100
        ..min = 0
        ..join(this);
  }

  @override
  void update() {
    count += rand.nextInt(5);
    name.text = '${count}s';
    if (count >= 100) leave();
    bar.min = count;
  }
}



class Scene extends Entity with Updatable {
  Scene();
}