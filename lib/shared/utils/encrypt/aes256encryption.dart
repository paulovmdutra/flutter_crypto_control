import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter_crypto_control/shared/utils/encrypt/iencrypty.dart';

class AES256Encryption implements IEncryptionStrategy {
  final enc.Key key;
  final enc.IV iv;
  String keyString;

  AES256Encryption({required this.keyString})
    : key = enc.Key.fromUtf8(keyString),
      iv = enc.IV.fromLength(16);

  @override
  String encrypt(String data) {
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    final encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }

  @override
  String decrypt(String encryptedData) {
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    final encrypted = enc.Encrypted.fromBase64(encryptedData);
    return encrypter.decrypt(encrypted, iv: iv);
  }
}
