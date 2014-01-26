library image_viewer;

import 'dart:html';
import 'image.dart';
import 'package:polymer/polymer.dart';

@CustomTag('x-image-viewer')
class ImageViewerComponent extends DivElement with Polymer, Observable {
  @published List<Image> images;
  @published int position, maxWidth, maxHeight;

  factory ImageViewerComponent(List<Image> images, int position, int maxWidth, int maxHeight) {
    ImageViewerComponent iv = new Element.tag('div', 'x-image-viewer');
    iv.images = images;
    iv.position = position;
    iv.maxWidth = maxWidth;
    iv.maxHeight = maxHeight;
    iv.onKeyPress.listen((key) {
      if (key.keyCode == KeyCode.LEFT) {
        previous();
      } else if (key.keyCode == KeyCode.RIGHT) {
        next();
      } else if (key.keyCode == KeyCode.SPACE) {
        fullscreen();
      }
    });
    return iv;
  }

  ImageViewerComponent.created() : super.created();

  previousClick(MouseEvent e, var detail, Node target) {
    previous();
  }

  nextClick(MouseEvent e, var detail, Node target) {
    next();
  }

  previous() {
    if (position > 0) position--;
  }

  next() {
    if (position < images.length - 1) position++;
  }

  fullscreen() {
  }

}