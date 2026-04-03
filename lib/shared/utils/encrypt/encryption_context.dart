import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_crypto_control/shared/utils/encrypt/aes256encryption.dart';
import 'package:flutter_crypto_control/shared/utils/encrypt/iencrypty.dart';
import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';

/// Classe de contexto para criptografia, implementando o padrão Singleton.
///
/// Essa classe permite definir e alterar a estratégia de criptografia
/// dinamicamente, seguindo o padrão Strategy
class EncryptionContext {
  // Chave padrão (32 caracteres para AES-256)
  static const _defaultKey =
      'AaVCeTwlHuTgCIDqkRan2GZ50x/VqmujdRrsDW79ZefWObfSyZgw8AIFPKpDg6HC';

  // Instância singleton
  static final EncryptionContext _instance = EncryptionContext._internal();

  // Estratégia de criptografia atual (iniciada com AES256 por padrão)
  late IEncryptionStrategy _encryptionStrategy;

  /// Construtor privado
  EncryptionContext._internal() {
    _encryptionStrategy = AES256Encryption(keyString: _defaultKey);
  }

  static EncryptionContext get instance => _instance;

  /// Retorna a instância única do contexto
  factory EncryptionContext() => _instance;

  /// Altera dinamicamente a estratégia de criptografia
  void setEncryptionStrategy(IEncryptionStrategy strategy) {
    _encryptionStrategy = strategy;
  }

  /// Criptografa os dados usando a estratégia definida
  String encrypt(String data) {
    return _encryptionStrategy.encrypt(data);
  }

  /// Descriptografa os dados usando a estratégia definida
  String decrypt(String encryptedData) {
    return _encryptionStrategy.decrypt(encryptedData);
  }

  /// Gera um array de bytes aleatórios (salt) com tamanho baseado em bits e baseBits.
  ///
  /// [bits]: quantidade total de bits desejados (padrão: 128).
  /// [baseBits]: tamanho base de conversão para bytes (padrão: 8).
  ///
  /// Exemplo:
  /// ```dart
  /// final salt = generateSaltToBytes();
  /// print(salt); // Uint8List
  /// ```
  Uint8List generateSaltToBytes({int bits = 128, int baseBits = 8}) {
    if (bits < 8 || baseBits < 8) {
      throw ArgumentError(
        'Parâmetros "bits" e "baseBits" devem ser maiores que 8',
      );
    }

    final byteCount = (bits / baseBits).ceil();
    final rand = Random.secure();
    final salt = Uint8List(byteCount);

    for (int i = 0; i < byteCount; i++) {
      salt[i] = rand.nextInt(256); // 0-255
    }

    return salt;
  }

  /// Gera um salt criptograficamente seguro e retorna como String Base64.
  ///
  /// [bits]: número total de bits (padrão: 128).
  /// [baseBits]: fator de conversão para bytes (padrão: 8).
  ///
  /// Exemplo:
  /// ```dart
  /// final salt = generateSalt();
  /// print(salt); // "Wk9F5sF9qkFvRz+Iq3iTsw=="
  /// ```
  String generateSalt({int bits = 128, int baseBits = 8}) {
    return base64Encode(generateSaltToBytes(bits: bits, baseBits: baseBits));
  }

  /// Gera um hash seguro da senha utilizando PBKDF2 com HMAC-SHA256.
  ///
  /// [password]: senha em texto simples.
  /// [salt]: vetor de bytes aleatórios (Uint8List).
  ///
  /// Retorna o hash como uma String codificada em Base64.
  String getPasswordHash(String password, Uint8List salt) {
    final derivator = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64))
      ..init(Pbkdf2Parameters(salt, 1000, 32)); // 32 bytes = 256 bits

    final hashBytes = derivator.process(utf8.encode(password));

    return base64Encode(hashBytes);
  }

  /// Gera um hash SHA-256 da string de entrada e retorna como string hexadecimal.
  ///
  /// Exemplo:
  /// ```dart
  /// final hash = generateSHA256Hash("senha123");
  /// print(hash); // e.g. "8d969eef6ecad3c29a3a629280e686cf..."
  /// ```
  String generateSHA256Hash(String input) {
    final bytes = utf8.encode(input); // Converte string para bytes UTF-8
    final digest = sha256.convert(bytes); // Gera o hash SHA-256
    return digest.toString(); // Retorna como hexadecimal (lowercase)
  }

  EncryptedPasswordResult encryptPassword(String input, {salt}) {
    String salts = "";
    if (salt == null) {
      salts = generateSalt(); // Base64 string
    } else {
      salts = salt;
    }
    final saltBytes = base64Decode(salts);
    String passwordHash = getPasswordHash(input, saltBytes);
    return EncryptedPasswordResult(passwordHash, salts);
  }
}

/// Representa o resultado da criptografia de senha contendo o hash e o salt.
class EncryptedPasswordResult {
  /// Hash da senha resultante do PBKDF2 com HMAC-SHA256.
  final String hash;

  /// Salt aleatório utilizado, codificado em Base64.
  final String salt;

  EncryptedPasswordResult(this.hash, this.salt);
}
