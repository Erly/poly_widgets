library main;

import 'dart:html';
import '../lib/icon/icon.dart';
import '../lib/image_viewer/image_viewer.dart';
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

  Photo img1 = new Photo("Image 1", "http://cdn.theatlantic.com/static/infocus/ngpc112812/s_n01_nursingm.jpg", 991, 678);
  Photo img2 = new Photo("Image 2", "http://images5.fanpop.com/image/photos/31400000/Animals-animals-31477008-1280-1024.jpg", 1280, 1024);
  Photo img3 = new Photo("Image 3", "http://www.personal.psu.edu/afr3/blogs/siowfa13/Tigers-animals-20238015-2493-1983.jpg", 2493, 1983);
  Photo img4 = new Photo("Image 4", "http://nexus.tripsit.me/file/pic/user/758.jpg", 1600, 1200);
  Photo img5 = new Photo("Image 5", "http://jattyouth.com/photobyusers/data/Animals/50f583ce7c43d.jpg", 1920, 1200);

  List<Photo> photos = [img1, img2, img3, img4, img5];
  for (int i = 0; i < photos.length; i++) {
    IconComponent icon = new IconComponent(photos[i].name, photos[i].src, 100, 100)
      ..onDoubleClick.listen((e) => _showImageViewer(photos, i));
    w.append(icon);
  }

  w.append(icon);
  document.body.append(w);
}

_showImageViewer(List<Image> images, position) {
  ImageViewerComponent iv = new ImageViewerComponent(images, position, 1024, 800);
  document.body.append(iv);
}

class Photo implements Image {
  String name, src;
  int width, height;

  Photo(this.name, this.src, this.width, this.height);
}