package com.sportsstore.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * MD5 加密工具类
 */
public class MD5Util {

    private static final String SALT = "sportsstore_2024";  // 加盐

    /**
     * MD5 加密 (加盐)
     */
    public static String encode(String password) {
        if (password == null) return null;
        try {
            String salted = password + SALT;
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] bytes = md.digest(salted.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                String hex = Integer.toHexString(b & 0xff);
                if (hex.length() == 1) sb.append("0");
                sb.append(hex);
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("MD5加密失败", e);
        }
    }

    /**
     * 比较密码
     */
    public static boolean matches(String rawPassword, String encodedPassword) {
        return encode(rawPassword).equals(encodedPassword);
    }
}
