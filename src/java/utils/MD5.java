package utils;

import java.security.*;
import java.math.*;

public class MD5 {

    public String md5(String valor) throws Exception {
        MessageDigest m = MessageDigest.getInstance("MD5");
        m.update(valor.getBytes(), 0, valor.length());
        return new BigInteger(1, m.digest()).toString(16);
    }
}
