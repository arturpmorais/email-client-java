import javax.crypto.spec.SecretKeySpec;
import javax.crypto.spec.IvParameterSpec;

import javax.crypto.Cipher;

public class Crypto {
    /*
    * Estes atributos precisam seguir a seguinte formatacao:
    *   IV                   == 16 bytes
    *   Chave de encriptacao == 16 bytes
    * */
    protected String IV;
    protected String texto;
    protected String chaveEncriptacao;

    public Crypto() {}

    public Crypto(String iv, String texto, String chave) throws Exception{
        this.setIV(iv);
        this.setTexto(texto);
        this.setChave(chave);
    }

    public void setIV(String iv) throws Exception{
        if (iv == null)
            throw new Exception ("IV ausente!");
        if (iv.length() != 16)
            throw new Exception ("IV deve ter 16 digitos!");

        this.IV = iv;
    }

    public void setTexto(String texto) throws Exception{
        if (texto == null)
            throw new Exception ("Texto ausente!");

        this.texto = texto;
    }

    public void setChave(String chave) throws Exception{
        if (chave == null)
            throw new Exception ("Chave ausente!");
        if (chave.length() != 16)
            throw new Exception ("A chave deve ter 15 digitos!");

        this.chaveEncriptacao = chave;
    }

    public byte[] encrypt(String textopuro, String chaveencriptacao) throws Exception {
        Cipher encripta = Cipher.getInstance("AES/CBC/PKCS5Padding", "SunJCE");
        SecretKeySpec key = new SecretKeySpec(chaveencriptacao.getBytes("UTF-8"), "AES");
        encripta.init(Cipher.ENCRYPT_MODE, key,new IvParameterSpec(this.IV.getBytes("UTF-8")));

        return encripta.doFinal(textopuro.getBytes("UTF-8"));
    }

    public String decrypt(byte[] textoencriptado, String chaveencriptacao) throws Exception{
        Cipher decripta = Cipher.getInstance("AES/CBC/PKCS5Padding", "SunJCE");
        SecretKeySpec key = new SecretKeySpec(chaveencriptacao.getBytes("UTF-8"), "AES");
        decripta.init(Cipher.DECRYPT_MODE, key,new IvParameterSpec(this.IV.getBytes("UTF-8")));

        return new String(decripta.doFinal(textoencriptado),"UTF-8");
    }

}