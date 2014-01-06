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
  WindowElement wnd = new WindowElementImpl("Window", 100, 100, 640, 480, minWidth: 320, minHeight: 240);
  WindowComponent w = new WindowComponent(wnd);
  w.style.position = "absolute";
  w.style.top = "0";
  w.style.left = "0";

  for (int i = 0; i < 10; i++) {
    IconComponent icon = new IconComponent(
        new IconElementImpl("Prueba $i", "http://www.erlantzoniga.com/images/folder.png", 120, height: 100)
        ..onDoubleClick.stream.listen((e) => window.alert("You double clicked the icon Prueba $i"))
        ..onRightClick.stream.listen((e) {
          e.stopPropagation();
          e.preventDefault();
          window.alert("You right clicked the icon Prueba $i");
        })
    );
    wnd.addContent(icon);
  }
  IconComponent icon = new IconComponent(
      new IconElementImpl("This icon clears the window and has a reaaaaly long text",
          "http://www.erlantzoniga.com/images/folder.png", 120, height: 100)
        ..onDoubleClick.stream.listen((e) => w.windowElement.clear())
    );
    wnd.addContent(icon);
  document.body.append(w);
}