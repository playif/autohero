library htmlib;

import 'dart:html';
import 'dart:async';
import 'dart:math';

//import 'dart:mirrors';
abstract class Updatable {
  void update();
}

class Entity<Child extends Entity> {
  Entity _parent = null;

  Entity get parent => _parent;

  Entity get entityParent => _parent;

  final Element _element = new DivElement();

  Element get element => _element;


  bool _die = false;

  bool get die => _die;

  ElementStream<MouseEvent> get onClick => _element.onClick;


  final List<Child> _children = [];

  List<Child> get children => _children ;

  num _width;

  num _height;

  num get width => _width;

  num get height => _height;

  void set width(num value) {
    _width = value;
    _element.style.width = '${_width}px';
    _element.style.minWidth = '${_width}px';
    _element.style.maxWidth = '${_width}px';
  }

  void set height(num value) {
    _height = value;
    _element.style.height = '${_height}px';
    _element.style.minHeight = '${_height}px';
    _element.style.maxHeight = '${_height}px';
  }

  Entity() {
    _element.classes.add("entity");
  }

  void add(Child entity) {
    addChild(entity);
  }

  void addChild(Child entity) {
    _children.add(entity);
    entity._parent = this;
    _element.children.add(entity._element);
  }

  void remove(Child entity) {
    removeChild(entity);
  }

  void removeChild(Child entity) {
    _children.remove(entity);
    entity._parent = null;
    _element.children.remove(entity._element);
  }

  //  void _leave() {
  //    if (parent == null) {
  //      throw new Exception('No parent!');
  //    } else {
  //      parent.remove(this);
  //    }
  //  }

  void leave() {
    _die = true;
  }

  void join(Entity parent) {
    parent.add(this);
  }

  CssStyleDeclaration get style => _element.style;

  CssClassSet get classes => _element.classes;
}


class VBox extends Entity {
  VBox() {
    classes.add('box');
  }
}

class FlowBox extends Entity {
  FlowBox() {
    //classes.add('box');
  }
}


//class VBox extends Box{
//  VBox(){
//
//  }
//}

class HBox extends VBox {
  HBox() {
    classes.add('hbox');
  }
}

class Ser {
  final String text;

  const Ser(this.text);
}

class Label extends Entity {
  String _text = "";

  String get text => _text;

  void set text(String value) {
    _text = value;
    _reflash();
  }

  String _name = "";

  String get name => _name;

  void set name(String value) {
    _name = value;
    _reflash();
  }

  void _reflash() {
    _element.text = "$_name$_text";
  }

  Label() {
    //    element.onClick.listen((e) {
    //      leave();
    //    });
    //_element.text=_text;
  }

//  @override
//  void update(Game game){
//    //game.time
//    _element.text='@'+_element.text;
//  }
}

//class B

class Block extends Entity {

}

class Bar extends Entity {
  num max = 10;
  num _min = 10;

  set min(num val) {
    _min = val;
    if (_min > max) _min = max;
    if (_min < 0) _min = 0;
    minBar.width = _min / max * width;
    element.title = "(${_min.ceil()}/$max)";
  }

  num color;
  Entity minBar = new Entity();

  Bar() {
    width = 10;
    classes.add('border');
    minBar.style.backgroundColor = 'red';

    addChild(minBar);
  }

  @override
  void set height(num value) {
    super.height = value;
    minBar.height = value;
  }

//  @override
//  void update() {
//
//  }
}

class Clock extends Entity {
  num max = 10;
  num _min = 10;

  num color;
  Entity minBar = new Entity();

  set min(num val) {
    _min = val;
    if (_min > max) _min = max;
    if (_min < 0) _min = 0;
    minBar.height = (1 - _min / max) * height;
  }

  //  @override
  //  add(Entity child){
  //    minBar.add(child);
  //  }


  Clock() {
    width = 20;
    height = 20;
    classes.add('border');
    style.overflow = 'hidden';
    minBar.style.backgroundColor = 'rgba(200,200,200,0.6)';
    minBar.style.position = 'absolute';
    minBar.width = 20;
    minBar.style.bottom = '0px';
    minBar.style.zIndex = "1000";
    addChild(minBar);
  }

  @override
  void set height(num value) {
    super.height = value;
    minBar.height = value;
  }

//  @override
//  void update() {
//
//  }
}

class Button extends Label {

  Button() {
    //    name = new Label();
    //    name.text = "XD!";

    //    onClick.listen((e) {
    //      print('Hi');
    //      //leave();
    //    });

    //    add(name);
    classes.add('btn');
  }

//  @override
//  void update() {
//    count += rand.nextInt(5);
//    name.text = '${count}s';
//    if (count >= 100) leave();
//    bar.min = count;
//  }
}


class Scene extends Entity with Updatable {
  Scene();
}