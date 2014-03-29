import 'dart:mirrors';
import 'htmlib.dart';

class _Binding {
  Entity source;
  Symbol sourceField;
  Entity target;
  Symbol targetField;
  dynamic currentValue;
  bool twoWay = false;

  static final List<_Binding> bindings = [];

  _Binding(this.source, this.sourceField, this.target, this.targetField, this.twoWay, this.currentValue);

}

void binding(Entity source, Symbol sourceField, Entity target, [Symbol targetField, bool twoWay=false]) {
  if (targetField == null)targetField = sourceField;
  var cv = reflect(source).getField(sourceField).reflectee;
  _Binding binding = new _Binding(source, sourceField, target, targetField, twoWay, cv);
  _Binding.bindings.add(binding);
}

void checkBindings() {
  _Binding.bindings.removeWhere((s) => s.source.die || s.target.die);
  _Binding.bindings.forEach((s) {
    var cv = reflect(s.source).getField(s.sourceField).reflectee;
    if (s.currentValue != cv) {
      reflect(s.target).setField(s.targetField, cv);
      s.currentValue = cv;
    }
  });
}