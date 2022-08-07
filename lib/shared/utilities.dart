// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js' as js;

playSound(String assetName) {
  js.context.callMethod('playAudio', [assetName]);
}
