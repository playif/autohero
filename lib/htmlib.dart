library htmlib;

import 'dart:html';
import 'dart:async';
import 'dart:math';

//import 'dart:mirrors';


class Entity<Child extends Entity> {
  Entity _parent = null;

  Entity get parent => _parent;

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
    _children.add(entity);
    entity._parent = this;
    _element.children.add(entity._element);
  }

  void addChild(Child entity) {
    _children.add(entity);
    entity._parent = this;
    _element.children.add(entity._element);
  }

  void remove(Child entity) {
    _children.remove(entity);
    entity._parent = null;
    _element.children.remove(entity._element);
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
    _element.classes.add('hbox');
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
    _element.text = _text;
  }

  Label() {
    element.onClick.listen((e) {
      leave();
    });
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
