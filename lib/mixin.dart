import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'kelime_listesi.dart';

mixin Ses<T extends StatefulWidget> on State<T> {
  final flutterTts = FlutterTts();
  double value = 0.4;

  @override
  void initState() {
    super.initState();
    // İsteğe bağlı: Başlangıçta dil gibi ayarları yapın
    initializeTts();
  }

  Future<void> initializeTts() async {
    // İngilizce telaffuz için dili ayarlayın (Örn: ABD İngilizcesi)
    // Cihazda mevcut olan dilleri kontrol etmek için flutterTts.getLanguages kullanabilirsiniz.
    await flutterTts.setLanguage("en-US");

    // İsteğe bağlı: Ses perdesini ayarlayın (0.5 - 2.0 arası, varsayılan 1.0)
    await flutterTts.setPitch(1.0);

    // İsteğe bağlı: Ses seviyesini ayarlayın (0.0 - 1.0 arası)
    await flutterTts.setVolume(1.0);
    volumeSpeed(value);
  }

  // Ses hızını ayarlayan fonksiyon
  Future<void> volumeSpeed(double volume) async {
    await flutterTts.setSpeechRate(volume);
  }

  //  Metni telaffuz ettiren fonksiyon
  Future<void> speak(String text) async {
    if (text.isNotEmpty) {
      await flutterTts.speak(text);
    }
  }

  Future<void> harfHecele(String text) async {
    if (text.isNotEmpty) {
      for (String harf in text.split('')) {
        await flutterTts.speak(harf);
        await Future.delayed(
          const Duration(milliseconds: 600),
        ); // Her harf arasında 500ms bekle
      }
    }
  }
Future<String> restgeleKelime() async {
    // Rastgele bir kelime seçin
    final kelimeler = WordList.words.keys.toList();
    final rastgeleKelime = (kelimeler..shuffle()).first;
    // Rastgele kelimeyi telaffuz edin
    await speak(rastgeleKelime);

    return rastgeleKelime;
  }

  @override
  void dispose() {
    // Widget kaldırıldığında TTS kaynaklarını serbest bırakın
    flutterTts.stop();
    super.dispose();
  }

}