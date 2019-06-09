import java.io.*;

public class Teste {
    static String IV = "AAAAAAAAAAAAAAAA";
    static String chaveencriptacao = "0123456789abcdef";

    public static void main(String [] args) {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        try {
            String texto = br.readLine();

            Crypto crypto = new Crypto(IV, texto, chaveencriptacao);

            System.out.println("Texto Puro: " + texto);

            byte[] textoencriptado = crypto.encrypt(texto, chaveencriptacao);

            System.out.print("Texto Encriptado: ");

            for (int i = 0; i < textoencriptado.length; i++)
                System.out.print(new Integer(textoencriptado[i])+" ");

            System.out.println("\n");

            String textoDecriptado = crypto.decrypt(textoencriptado, chaveencriptacao);

            System.out.println("Texto Decriptado: " + textoDecriptado);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
