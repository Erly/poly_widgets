library main;

import 'dart:html';
import '../lib/icon/icon.dart';
import '../lib/window/window.dart';
import 'package:polymer/polymer.dart';

export 'package:polymer/init.dart';

@initMethod
void _init() {
  ButtonElement createWindowButton = querySelector("#create-window-button");
  createWindowButton.onClick.listen(createWindow);
}

void createWindow(MouseEvent e) {
  WindowComponent w = new WindowComponent("Window", 100, 100, 640, 480, minWidth: 320, minHeight: 240);
  w.onClose.listen((_) => w.remove());

  for (int i = 0; i < 10; i++) {
    IconComponent icon = new IconComponent("Prueba $i", "http://www.erlantzoniga.com/images/folder.png", 100, 100)
      ..onDoubleClick.listen((e) => window.alert("You double clicked the icon Prueba $i"))
      ..onContextMenu.listen((e) {
          e.stopPropagation();
          e.preventDefault();
          window.alert("You right clicked the icon Prueba $i");
      });
    w.append(icon);
  }
  IconComponent icon = new IconComponent("This icon clears the window and has a reaaaaly long text",
          "http://www.erlantzoniga.com/images/folder.png", 100, 100)
    ..onDoubleClick.listen((e) => w.children.clear());
  w.append(icon);
  document.body.append(w);
}