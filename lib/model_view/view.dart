library view;

@MirrorsUsed(targets: const ['view', 'game'])
import 'dart:mirrors';
import 'dart:html';
import 'dart:async';
import 'dart:math';

part 'binging.dart';

typedef List FilterFunc(List list);

typedef BindingTransformFunc(s);

typedef OPRequest(i);

class _Binding {
  Object source;
  Symbol sourceField;
  Symbol targetField;
  dynamic currentValue;
  BindingTransformFunc func;

  _Binding(this.source, this.sourceField, this.targetField, this.currentValue, this.func);
}

class _ListBinding {
  List source;
  List currentList = [];

  //OPRequest insert;
  //OPRequest remove;
  FilterFunc filter;
  Type childType;

  _ListBinding(this.source, this.childType, this.filter) {
    //    currentList = new List.from(source);
  }

  createChild(arg) {
    var child = reflectClass(childType).newInstance(const Symbol(''), [arg]);
    return child.reflectee;
  }
}

class View {
  final List<_Binding> _fieldBindings = [];
  _ListBinding _listBinding;
  final Map<dynamic, View> _views = {
  };

  void bindList(List list, Type childType, [FilterFunc filter]) {
    _listBinding = new _ListBinding(list, childType, filter);
  }

  void unbindList() {
    _listBinding = null;
  }

  void bindField(String field, source, String sourceField, { BindingTransformFunc transform}) {
    _Binding binding = new _Binding(source, new Symbol(sourceField), new Symbol(field), null, transform);
    _fieldBindings.add(binding);
  }

  void checkListBinding([bool force=false]) {
    if (!_visible && !force)return;
    if (_listBinding != null) {
      List tList;
      if (_listBinding.filter != null) {
        tList = _listBinding.filter(_listBinding.source);
      } else {
        tList = _listBinding.source;
      }
      List cList = _listBinding.currentList;

      void insertOP(int i) {
        var view = _listBinding.createChild(tList[i]);
        insert(i, view);
        _views[tList[i]] = view;
        cList.insert(i, tList[i]);
      }
      for (int i = 0;i < tList.length;i++) {
        if (i >= cList.length) {
          for (int j = i;j < tList.length;j++) {
            insertOP(j);
          }
          break;
        }
        if (tList[i] != cList[i]) {
          var idx = cList.indexOf(tList[i]);
          if (idx == -1) {
            insertOP(i);
          } else {
            move(idx, i);
            var tmp = cList[idx];
            cList.removeAt(idx);
            cList.insert(i, tmp);
          }
        }
      }
      for (int i = tList.length;i < cList.length;i++) {
        remove(_views[cList[i]]);
        _views.remove(cList[i]);
      }
      cList.removeRange(tList.length, cList.length);
    }
    children.forEach((View c) => c.checkListBinding(force));
  }

  void checkFieldBindings([bool force=false]) {
    if (!_visible && !force)return;
    children.forEach((View c) => c.checkFieldBindings(force));
    _fieldBindings.forEach((binding) {
      var cv = reflect(binding.source).getField(binding.sourceField).reflectee;
      if (binding.currentValue != cv) {
        if (binding.func == null) {
          reflect(this).setField(binding.targetField, cv);
        } else {
          reflect(this).setField(binding.targetField, binding.func(cv));
        }
        binding.currentValue = cv;
      }
    });
  }

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

  num _opacity = 1;

  num get opacity => _opacity;

  set opacity(num value) {
    _opacity = value;
    style.opacity = "$_opacity";
  }

  num _cellMargin = 0;

  num get cellMargin => _cellMargin;

  set cellMargin(num value) {
    _cellMargin = value;
  }

  num _cellPadding = 0;

  num get cellPadding => _cellPadding;

  set cellPadding(num value) {
    _cellPadding = value;
  }

  bool _visible = true;

  bool get visible => _visible;

  set visible(bool value) {
    if (!_visible && value) {
      updateView(true);
      updateView(true); //dirty code
      onShow();
    }
    _visible = value;
    if (value) {
      style.display = 'block';
    } else {
      style.display = 'none';
    }
  }


  View() {
    _element.classes.add("view-node");
  }

  void onShow() {

  }


  bool layoutCell = true;
  bool layout = true;

  bool vertical = true;
  bool wrap = false;
  num cellWidth = 0;
  num cellHeight = 0;

  void cellSize(num width, num height) {
    cellWidth = width;
    cellHeight = height;
  }

  void reArrange([bool force=false]) {
    if (!_visible && !force)return;
    children.forEach((View c) => c.reArrange(force));
    if (layoutCell) {
      num cx = cellPadding;
      num cy = cellPadding;
      if (vertical) {

        children.forEach((View v) {
          if (!v.visible || !v.layout)return;
          if (cellWidth != 0) v.width = cellWidth;
          if (cellHeight != 0) v.height = cellHeight;
          if (wrap && cy + v.height + v.border * 2 + cellMargin + cellPadding >= height) {
            cy = cellPadding;
            cx += v.width + v.border * 2 + cellMargin;
          }
          v.left = cx;
          v.top = cy;
          cy += v.height + v.border * 2 + cellMargin;
        });
      } else {
        children.forEach((View v) {
          if (!v.visible || !v.layout)return;
          if (cellWidth != 0) v.width = cellWidth;
          if (cellHeight != 0) v.height = cellHeight;
          if (wrap && cx + v.width + v.border * 2 + cellMargin + cellPadding >= width) {
            cx = cellPadding;
            cy += v.height + v.border * 2 + cellMargin;
          }
          v.left = cx;
          v.top = cy;
          cx += v.width + v.border * 2 + cellMargin;
        });

      }
    }

  }

  void updateView([bool force=false]) {
    checkListBinding(force);
    checkFieldBindings(force);
    reArrange(force);
  }

  void init() {

  }

  void add(View entity) {
    insert(children.length, entity);
  }

  void insert(int index, View entity) {
    _children.insert(index, entity);
    _element.children.insert(index, entity._element);
    entity._parent = this;
    entity.init();
    entity.updateView();
  }

  void move(int from, int to) {
    View v = _children[from];
    _children.removeAt(from);
    _children.insert(to, v);
    _element.children.insert(to, v._element);
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

  //  void breakLine() {
  //    element.children.add(new DivElement()
  //      ..style.clear = "both");
  //    //add(new LineBreaker());
  //  }

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


  void watchSize(View panel) {
    bindField('width', panel, 'width');
    bindField('height', panel, 'height');
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
    style.overflowY = 'hidden';
    //width=100;
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
    layoutCell = false;
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
    //panel.watchSize(this);
    panel.bindField('height', this, 'height', transform:(s) => s - cellPadding * 2);
    panel.bindField('width', this, 'width', transform:(s) => s - cellPadding * 2);
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
  //  final List<View> _panelID = [];
  //  final Map<View, View> _panels = {
  //  };

  final View tabs = new View();
  final View panels = new View();

  int tabWidth = 150;

  void init() {
    vertical = false;
    add(tabs);
    add(panels);

    tabs.width = tabWidth;
    tabs.bindField('height', this, 'height', transform:(s) => s - cellMargin - cellPadding * 2);
    panels.bindField('width', this, 'width', transform:(s) => s - tabWidth - cellMargin - cellPadding * 2);
    panels.bindField('height', this, 'height', transform:(s) => s - cellMargin - cellPadding * 2);
  }

  //  void addPanel(View tab, View panel) {
  //
  //    _panels[tab] = panel;
  //    _panelID.add(panel);
  //
  //    //    tab.onClick.listen()
  //    tab.onClick.listen((e) {
  //      showPanel(panel);
  //    });
  //
  //    tabs.add(tab);
  //    panels.add(panel);
  //
  //    showPanel(panel);
  //  }

  void removePanel(View tab) {

  }

  showPanel(View panel) {
    panels.children.forEach((p) {
      p.visible = false;
    });
    panel.visible = true;
  }

  showPanelID(int id) {
    showPanel(panels.children[id]);
  }

  showPanelTab(View tab) {
    showPanelID(tabs.children.indexOf(tab));
  }

}

class Scene extends View {
  Scene();
}