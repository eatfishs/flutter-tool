import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

class CryptoUtil {
  // ============================== 哈希算法 ==============================
  /// MD5 加密（不可逆）
  static String md5Hash(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  /// SHA-256 加密（不可逆）
  static String sha256Encrypt(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }

  // ============================== AES 加解密 ==============================
  /// AES 加密（CBC 模式 + PKCS7 填充）
  /// 返回值包含加密数据和 IV（Base64 格式）
  static Map<String, String> aesEncrypt(String plainText, String password) {
    try {
      final key = _generateAESKey(password);
      final iv = IV.fromSecureRandom(16); // 生成随机初始化向量
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final encrypted = encrypter.encrypt(plainText, iv: iv);

      return {
        'iv': iv.base64,
        'data': encrypted.base64,
      };
    } catch (e) {
      throw Exception('AES 加密失败: $e');
    }
  }

  /// AES 解密
  static String aesDecrypt(
      String encryptedBase64, String password, String ivBase64) {
    try {
      final key = _generateAESKey(password);
      final iv = IV.fromBase64(ivBase64);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final encrypted = Encrypted.fromBase64(encryptedBase64);

      return encrypter.decrypt(encrypted, iv: iv);
    } catch (e) {
      throw Exception('AES 解密失败: $e');
    }
  }

  /// 根据密码生成 256 位 AES 密钥
  static Key _generateAESKey(String password) {
    // 使用 SHA-256 哈希密码，截取 32 字节（256 位）
    final hash = sha256.convert(utf8.encode(password)).bytes;
    return Key(Uint8List.fromList(hash));
  }
}
