library main;

import 'dart:html';
import '../lib/model/model.dart';
import '../lib/icon.dart';
import '../lib/window.dart';
import 'package:polymer/polymer.dart';

export 'package:polymer/init.dart';

@initMethod
void _init() {
  ButtonElement createWindowButton = querySelector("#create-window-button");
  createWindowButton.onClick.listen(createWindow);
}

void createWindow(MouseEvent e) {
  WindowComponent window = new WindowComponent(
      new WindowElementImpl(100, 100, 640, 480)
  );
  window.style.position = "absolute";
  window.style.top = "0";
  window.style.left = "0";

  IconComponent icon = new IconComponent(
      new IconElementImpl("Prueba", "http://www.erlantzoniga.com/images/folder.png", width: 100)
  );
  window.append(icon);
  document.body.append(window);
}