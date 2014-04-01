library view;


@MirrorsUsed(targets: const ['view', 'model'])
import 'dart:mirrors';

import 'dart:html';
import 'dart:async';
import 'dart:math';

//import 'model.dart';

part 'binging.dart';
//
////import 'dart:mirrors';
//abstract class Updatable {
//  void update();
//}
//
//View _root = new View();
//
//initView() {
//  _resetWindowSize();
//  window.onResize.listen((e) {
//    _resetWindowSize();
//    //    updateView();
//  });
//
//  //document.body.children.add(_root.element);
//  //  document.body.style.height=windowHeight;
//}
//
//class _ViewPort {
//  num _windowHeight = window.innerHeight;
//
//  num get windowHeight => _windowHeight;
//
//  num _windowWidth = window.innerHeight;
//
//  num get windowWidth => _windowWidth;
//}
//
//View viewPort = new View();
//
//_resetWindowSize() {
//  viewPort.height = window.innerHeight;
//  viewPort.width = window.innerWidth;
//  document.body.style.height = '${viewPort.height}';
//  document.body.style.maxHeight = '${viewPort.width}';
//}
//
//
////updateView() {
////  _update(_root);
////}
//
//_update(View view) {
//  view.children.removeWhere((c) => c.die);
//
//  //view.updateView();
//
//  view.children.forEach((c) => _update(c));
//}
//
//class GameView extends View {
//  init() {
//
//  }
//
//
//  List<View> getViews() {
//    return [new View()];
//  }
//
//  updateView() {
//    var views = getViews();
//    views.forEach((v) {
//      if (!children.contains(v)) {
//        children.add(v);
//      }
//    });
//
//  }
//}

class View {
  dynamic observable;

  View _parent = null;

  View get parent => _parent;

  View get entityParent => _parent;

  final Element _element = new DivElement();

  Element get element => _element;


  bool _die = false;

  bool get die => _die;

  ElementStream get onClick {
    //return _element.onTouchStart;
    return _element.onClick;
  }


  final List<View> _children = new List<View>();

  List<View> get children => _children ;

  num _width = 0;

  num _height = 0;

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

  num _top = 0;

  num get top => _top;

  set top(num value) {
    _top = value;
    _element.style.top = '${_top}px';
  }

  num _left = 0;

  num get left => _left;

  set left(num value) {
    _left = value;
    _element.style.left = '${_left}px';
  }

  num _border = 0;

  num get border => _border;

  set border(num value) {
    _border = value;
    _element.style.borderWidth = '${_border}px';
  }

  num _borderColorH = 0;

  num get borderColorH => _borderColorH;

  set borderColorH(num value) {
    _borderColorH = value;
    _resetBorderColor();
  }

  num _borderColorS = 100;

  num get borderColorS => _borderColorS;

  set borderColorS(num value) {
    _borderColorS = value;
    _resetBorderColor();
  }

  num _borderColorL = 50;

  num get borderColorL => _borderColorL;

  set borderColorL(num value) {
    _borderColorL = value;
    _resetBorderColor();
  }

  num _borderColorA = 1;

  num get borderColorA => _borderColorA;

  set borderColorA(num value) {
    _borderColorA = value;
    _resetBorderColor();
  }

  void _resetBorderColor() {
    _element.style.borderColor = 'hsla(${_borderColorH},${_borderColorS}%,${_borderColorL}%,${_borderColorA})';
    //print('hsla(${_borderColorH},${_borderColorS}%,${_borderColorL}%,${_borderColorA})');
  }

  num _backgroundColorH = 0;

  num get backgroundColorH => _backgroundColorH;

  set backgroundColorH(num value) {
    _backgroundColorH = value;
    _resetBackgroundColor();
  }

  num _backgroundColorS = 100;

  num get backgroundColorS => _backgroundColorS;

  set backgroundColorS(num value) {
    _backgroundColorS = value;
    _resetBackgroundColor();
  }

  num _backgroundColorL = 50;

  num get backgroundColorL => _backgroundColorL;

  set backgroundColorL(num value) {
    _backgroundColorL = value;
    _resetBackgroundColor();
  }

  num _backgroundColorA = 1;

  num get backgroundColorA => _backgroundColorA;

  set backgroundColorA(num value) {
    _backgroundColorA = value;
    _resetBackgroundColor();
  }

  void _resetBackgroundColor() {
    _element.style.backgroundColor = 'hsla(${_backgroundColorH},${_backgroundColorS}%,${_backgroundColorL}%,${_backgroundColorA})';
    //print('hsla(${_borderColorH},${_borderColorS}%,${_borderColorL}%,${_borderColorA})');
  }

  num _cellMargin = 0;

  num get cellMargin => _cellMargin;

  set cellMargin(num value) {
    _cellMargin = value;
  }

  bool _visible = true;

  bool get visible => _visible;

  set visible(bool value) {
    _visible = value;
    if (value) {
      style.display = 'block';
    } else {
      style.display = 'none';
    }
  }


  View() {
    _element.classes.add("view-node");
    visible = true;
    //top=0;
    //left=0;
  }

  void sendMsg(String msg, data) {
    handleMsg(msg, data);
    children.forEach((View c) => c.sendMsg(msg, data));

  }

  void handleMsg(String msg, data) {
    //print("here");
  }

  //  void expandWidth(){
  //    watch('width',entityParent,'width');
  //  }

  bool layout = true;
  bool vertical = true;
  bool wrap = false;
  num cellWidth = 100;
  num cellHeight = 100;


  void updateView() {
    /*
    num ch = 0;
    children.forEach((View v) {
      v.top = ch;
      //v.width = width-v.border*2;
      //      if(v.height == null){
      //        print("Hi");
      //      }
      ch += v.height+v.border*2+v.margin;
    });

    //num ch = 0;
    children.forEach((View v) {
      v.left = ch;
      //v.height = height-v.border*2;
      //      if(v.height == null){
      //        print("Hi");
      //      }
      ch += v.width+v.border*2+v.margin;
    });
*/

    if (layout) {
      num cx = cellMargin;
      num cy = cellMargin;
      if (vertical) {

        children.forEach((View v) {
          //var rect=v.element.getComputedStyle();

          //          if (v.height == 0) {
          //
          //            //var rect=v.element.getComputedStyle();
          //
          //            //v.height = rect.height;
          //            print(v.element.getClientRects()[0]);
          //          }
          //print(rect.height);
          if (!v.visible)return;
          if (wrap && cy + v.height >= height) {
            cy = cellMargin;
            cx += cellWidth + v.border * 2 + cellMargin;
          }
          v.left = cx;
          v.top = cy;
          cy += v.height + v.border * 2 + cellMargin;
        });
      } else {
        children.forEach((View v) {
          if (!v.visible)return;
          if (wrap && cx + v.width >= width) {
            cx = cellMargin;
            cy += cellHeight + v.border * 2 + cellMargin;
          }
          v.left = cx;
          v.top = cy;
          cx += v.width + v.border * 2 + cellMargin;
        });

      }
    }


    children.forEach((c) => c.updateView());
  }

  void init() {

  }

  void add(View entity) {
    entity.init();
    entity.updateView();
    _children.add(entity);
    entity._parent = this;
    _element.children.add(entity._element);
  }

  //  void addChild(View entity) {
  //
  //  }

  void remove(View entity) {
    _children.remove(entity);
    entity._parent = null;
    _element.children.remove(entity._element);
  }

  void removeAll() {
    _children.toList().forEach((c) {
      remove(c);
    });
  }

  //  void removeChild(View entity) {
  //
  //  }

  void breakLine() {
    element.children.add(new DivElement()
      ..style.clear = "both");
    //add(new LineBreaker());
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

  void watch(String field, source, String sourceField, {bool twoWay:false, bindingTransformFunc transform}) {
    binding(source, sourceField, this, field, twoWay:twoWay, transform:transform);
  }

  void watchSize(View panel) {
    watch('width', panel, 'width');
    watch('height', panel, 'height');
  }

  CssStyleDeclaration get style => _element.style;

  CssClassSet get classes => _element.classes;
}

/*
class VBox extends View {


  updateView() {


    super.updateView();
  }

//  addChild(View entity){
////    entity.style.position="ab"
//    //entity.width=this.width;
//  }
}

class FlowBox extends View {
  num cellWidth=200;
  num cellHeight=100;
  FlowBox() {

    //classes.add('box');
  }

  updateView() {


    super.updateView();
  }
}


//class VBox extends Box{
//  VBox(){
//
//  }
//}

class HBox extends View {
  HBox() {
    //classes.add('hbox');
  }

  updateView() {


    super.updateView();
  }
}

class Ser {
  final String text;

  const Ser(this.text);
}
*/

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

  int _size = 0;

  int get size => _size;

  set size(int val) {
    _size = val;
    style.fontSize = '${_size}px';
    height = _size + 10;
  }


  void _reflash() {
    _element.innerHtml = "$_name$_text";
  }

  Label() {
    size = 20;
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

  num get min => _min;

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
    //width = 10;
    border = 1;
    //classes.add('border');
    minBar.style.backgroundColor = 'red';

    add(minBar);
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
    //print("here");
  }

  //  @override
  //  add(Entity child){
  //    minBar.add(child);
  //  }


  Clock() {
    layout = false;
    width = 20;
    height = 20;
    classes.add('border');
    style.overflow = 'hidden';
    minBar.style.backgroundColor = 'rgba(200,200,200,0.6)';
    minBar.style.position = 'absolute';
    minBar.width = 20;
    minBar.style.bottom = '0px';
    minBar.style.zIndex = "1000";
    minBar.style.overflow = 'hidden';
    add(minBar);
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
    //classes.add('btn');
    style.borderStyle = 'solid';
    border = 2;
    borderColorH = 100;

    classes.add('btn act-green');
  }

//  @override
//  void update() {
//    count += rand.nextInt(5);
//    name.text = '${count}s';
//    if (count >= 100) leave();
//    bar.min = count;
//  }
}

class Select extends View {
  SelectElement select = new SelectElement();
  List<OptionElement> options = new List<OptionElement>();

  ElementStream<Event> get onChange => select.onChange;

  Select() {
    element.children.add(select);
    select.classes.add('small-text');
    //    OptionElement opt = new OptionElement();
    //    opt.text = "test1";
    //    opt.value = "hi";
    //    select.children.add(opt);
    //    OptionElement opt2 = new OptionElement();
    //    opt2.text = "test2";
    //    opt2.value = "hi";
    //    select.onChange.listen((s) {
    //      level += 1;
    //
    //      //..classes.add("small-text");
    //      //game._setSite(StartLand2());
    //      game.removeAllMonsters();
    //      //print("hi");
    //      for (int i = 0;i < 1;i++) {
    //        var mon = createMonster();
    //
    //        var state = Generation();
    //        //state.effect=10;
    //        //    state.attach(mon);
    //        mon.add(state);
    //        mon.add(Generation());
    //        mon.add(Generation2());
    //        mon.add(Generation());
    //        game.add(mon);
    //      }
    //    });

    //select.children.add(opt2);
  }

  void createOption(String text, String value) {
    OptionElement opt = new OptionElement();
    opt.text = text;
    opt.value = value;
    select.children.add(opt);
    options.add(opt);
  }

  String currentSelectValue() {
    return select.options[select.selectedIndex].value;
  }

  String currentSelectText() {
    return select.options[select.selectedIndex].text;
  }

  int get selectedIndex => select.selectedIndex;

  void set selectedIndex(int index) {
    select.selectedIndex = index;
  }

}

//class LineBreaker extends View {
//  LineBreaker() {
//    element.children.add(new DivElement()
//      ..style.clear = "both");
//  }
//}

class LayerPanel extends View {
  final List<View> _panels = [];

  void addPanel(View panel) {
    _panels.add(panel);
    panel.watchSize(this);
    add(panel);
    //print(panel);
  }

  showPanel(View panel) {
    _panels.forEach((p) {
      p.visible = false;
    });
    panel.visible = true;
  }

  showPanelID(int id) {
    showPanel(_panels[id]);
  }
}

class TabPanel extends View {
  final List<View> _panelID = [];
  final Map<View, View> _panels = {
  };

  View tabs = new View();
  View panels = new View();

  int tabWidth = 150;

  void init() {
    vertical = false;
    add(tabs);
    add(panels);

    tabs.width = tabWidth;
    tabs.watch('height', this, 'height');
    panels.watch('width', this, 'width', transform:(s) => s - tabWidth);
    panels.watch('height', this, 'height');
  }

  void addPanel(View tab, View panel) {

    _panels[tab] = panel;
    _panelID.add(panel);

    //    tab.onClick.listen()
    tab.onClick.listen((e) {
      showPanel(panel);
    });

    tabs.add(tab);
    panels.add(panel);

    showPanel(panel);
  }

  showPanel(View panel) {
    _panelID.forEach((p) {
      p.visible = false;
    });
    panel.visible = true;
  }

  showPanelID(int id) {
    showPanel(_panelID[id]);
  }

}

class Scene extends View {
  Scene();
}