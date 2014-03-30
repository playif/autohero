part of view;

class _Binding {
  View source;
  Symbol sourceField;
  View target;
  Symbol targetField;
  dynamic currentValue;
  bool twoWay = false;
  bindingTransformFunc func;

  static final List<_Binding> bindings = [];

  _Binding(this.source, this.sourceField, this.target, this.targetField, this.twoWay, this.currentValue, this.func);

}

typedef bindingTransformFunc(s);

void binding(View source, String sourceField, View target, String targetField, {bool twoWay:false, bindingTransformFunc transform}) {
  //if (targetField == null)targetField = sourceField;
  //reflect(sourceField).type.owner.
  var cv = reflect(source).getField(new Symbol(sourceField)).reflectee;
  _Binding binding = new _Binding(source, new Symbol(sourceField), target, new Symbol(targetField), twoWay, cv, transform);
  _bind(binding, cv);
  _Binding.bindings.add(binding);
}

void checkBindings() {
  _Binding.bindings.removeWhere((s) => s.source.die || s.target.die);
  _Binding.bindings.forEach((binding) {
    var cv = reflect(binding.source).getField(binding.sourceField).reflectee;
    if (binding.currentValue != cv) {
      _bind(binding, cv);
    }
  });
}

void _bind(_Binding binding, cv) {
  if (binding.func == null) {
    reflect(binding.target).setField(binding.targetField, cv);
  } else {
    reflect(binding.target).setField(binding.targetField, binding.func(cv));
  }
  binding.currentValue = cv;
}

void bingList() {

}

void bindMap() {

}