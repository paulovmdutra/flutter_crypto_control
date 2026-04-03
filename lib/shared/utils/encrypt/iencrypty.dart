/// Uma interface que define o contrato para algoritmos de criptografia.
///
/// Esta interface deve ser implementada por qualquer classe que deseje
/// fornecer uma estratégia de criptografia personalizada, como AES-256,
/// AES-128, RSA, entre outros.
///
/// O objetivo é permitir a troca de algoritmos de criptografia sem impactar
/// a lógica de negócio da aplicação, utilizando o padrão de projeto Strategy.
abstract class IEncryptionStrategy {
  /// Criptografa uma string de entrada e retorna o resultado como uma string codificada.
  ///
  /// Parâmetros:
  /// - [data]: A string de texto simples (plaintext) que será criptografada.
  ///
  /// Retorna:
  /// Uma string criptografada, geralmente em formato Base64.
  String encrypt(String data);

  /// Descriptografa uma string criptografada e retorna o texto original.
  ///
  /// Parâmetros:
  /// - [encryptedData]: A string criptografada que será convertida de volta ao texto original.
  ///
  /// Retorna:
  /// A string de texto simples (plaintext) descriptografada.
  String decrypt(String encryptedData);
}
