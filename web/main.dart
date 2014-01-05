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
  WindowComponent wnd = new WindowComponent(
      new WindowElementImpl("Window", 100, 100, 640, 480, minWidth: 320, minHeight: 240)
  );
  wnd.style.position = "absolute";
  wnd.style.top = "0";
  wnd.style.left = "0";

  for (int i = 0; i < 10; i++) {
    IconComponent icon = new IconComponent(
        new IconElementImpl("Prueba $i", "http://www.erlantzoniga.com/images/folder.png", width: 100)
        ..onDoubleClick.stream.listen((e) => window.alert("You double clicked the icon Prueba $i"))
        ..onRightClick.stream.listen((e) {
          e.stopPropagation();
          e.preventDefault();
          window.alert("You right clicked the icon Prueba $i");
        })
    );
    wnd.append(icon);
  }
  document.body.append(wnd);
}