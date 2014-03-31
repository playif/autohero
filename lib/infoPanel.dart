part of model;

class InfoPanel extends View {
  InfoPanel() {
    border = 0;

    add(new Label()
      ..text = '資訊版面');
    //infoPanel.breakLine();
    add(new Label()
      ..name = "金幣: "
      ..watch('text', this, 'money', transform:(m) {
      return "<b>$m</b>";
    }));
    //infoPanel.breakLine();

  }
}
