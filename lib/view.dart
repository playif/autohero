library view;


@MirrorsUsed(targets: const ['view', 'model'])
import 'dart:mirrors';

import 'dart:html';
import 'dart:async';
import 'dart:math';

part 'binging.dart';

//import 'dart:mirrors';
abstract class Updatable {
  void update();
}

View _root = new View();

initView() {
  _resetWindowSize();
  window.onResize.listen((e) {
    _resetWindowSize();
    //    updateView();
  });

  document.body.children.add(_root.element);
  //  document.body.style.height=windowHeight;
}

num _windowHeight = window.innerHeight;

num get windowHeight => _windowHeight;

num _windowWidth = window.innerHeight;

num get windowWidth => _windowWidth;

_resetWindowSize() {
  _windowHeight = window.innerHeight;
  _windowWidth = window.innerHeight;
  document.body.style.height = '${_windowHeight}';
  document.body.style.maxHeight = '${_windowWidth}';
}


updateView() {
  
}


class View<Child extends View> {
  View _parent = null;

  View get parent => _parent;

  View get entityParent => _parent;

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

  View() {
    _element.classes.add("view-node");
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

  void join(View parent) {
    parent.add(this);
  }

  void watch(String field, View source, String sourceField, {bool twoWay:false, bindingTransformFunc transform}) {
    binding(source, sourceField, this, field, twoWay:twoWay, transform:transform);
  }

  CssStyleDeclaration get style => _element.style;

  CssClassSet get classes => _element.classes;
}


class VBox extends View {
  VBox() {
    classes.add('box');
  }
}

class FlowBox extends View {
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


Label text(String text, [String name]) {
  var label = new Label()
    ..text = text;
  if (name != null) {
    label.name = name;
  }
  return label;
}

class Label extends View {
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
    _element.innerHtml = "$_name$_text";
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

class Block extends View {

}

class Bar extends View {
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
  View minBar = new View();

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

class Clock extends View {
  num max = 10;
  num _min = 10;

  num color;
  View minBar = new View();

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


class Scene extends View with Updatable {
  Scene();
}