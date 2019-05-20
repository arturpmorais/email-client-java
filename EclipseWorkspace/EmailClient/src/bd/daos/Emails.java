package bd.daos;

import bd.core.MeuResultSet;
import bd.BDSQLServer;
import java.sql.*;
import bd.dbos.Email;

public class Emails {
	public static boolean cadastrado(String email) throws Exception {
        boolean retorno = false;

        try {
            String sql;

            sql = "SELECT * " +
                  "FROM EMAIL " +
                  "WHERE EMAIL = ?";

            BDSQLServer.COMANDO.prepareStatement(sql);

            BDSQLServer.COMANDO.setString(1, email);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery();

            retorno = resultado.first();
        } catch (SQLException erro) {
            throw new Exception (erro.getMessage());
        }

        return retorno;
    }

    public static boolean cadastrado(int id) throws Exception {
        boolean retorno = false;

        try {
            String sql;

            sql = "SELECT * " +
                  "FROM EMAIL " +
                  "WHERE ID = ?";

            BDSQLServer.COMANDO.prepareStatement(sql);

            BDSQLServer.COMANDO.setInt(1, id);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery();

            retorno = resultado.first(); // pode-se usar resultado.last() ou resultado.next() ou resultado.previous() ou resultado.absotule(numeroDaLinha)

            /* // ou, se preferirmos,
            String sql;
            sql = "SELECT COUNT(*) AS QUANTOS " +
                  "FROM LIVROS " +
                  "WHERE CODIGO = ?";
            BDSQLServer.COMANDO.prepareStatement (sql);
            BDSQLServer.COMANDO.setInt (1, codigo);
            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery ();
            resultado.first();
            retorno = resultado.getInt("QUANTOS") != 0;
            */
        } catch (SQLException erro) {
            throw new Exception (erro.getMessage());
        }

        return retorno;
    }

    public static void incluir(Email email) throws Exception {
        if (email == null)
            throw new Exception ("Email nao fornecido!");
        
        if (cadastrado(email.getId()))
            throw new Exception ("Email ja cadastrado!");
        
        try {
            String sql;

            sql = "INSERT INTO EMAIL " +
                  "(ID,IDDONO,EMAIL,SENHA,PORTA,HOST,PROTOCOLO) " +
                  "VALUES " +
                  "(?,?,?,?,?,?,?)";

            BDSQLServer.COMANDO.prepareStatement(sql);

            BDSQLServer.COMANDO.setInt(1, email.getId());
            BDSQLServer.COMANDO.setInt(2, email.getIdDono());
            BDSQLServer.COMANDO.setString(3, email.getEmail());
            BDSQLServer.COMANDO.setString(4, email.getSenha());
            BDSQLServer.COMANDO.setInt(5, email.getPorta());
            BDSQLServer.COMANDO.setString(6, email.getHost());
            BDSQLServer.COMANDO.setString(7, email.getProtocolo());

            BDSQLServer.COMANDO.executeUpdate();
            BDSQLServer.COMANDO.commit();
        } catch (SQLException erro) {
            throw new Exception (erro.getMessage());
        }
    }

    public static void excluir(int id) throws Exception {
        if (!cadastrado(id))
            throw new Exception ("Email nao cadastrado!");

        try {
            String sql;

            sql = "DELETE FROM EMAIL " +
                  "WHERE ID=?";

            BDSQLServer.COMANDO.prepareStatement(sql);

            BDSQLServer.COMANDO.setInt(1, id);

            BDSQLServer.COMANDO.executeUpdate();
            BDSQLServer.COMANDO.commit();     
        } catch (SQLException erro) {
            throw new Exception (erro.getMessage());
        }
    }

    public static void alterar(Email email) throws Exception {
        if (email == null)
            throw new Exception ("Email nao fornecido!");

        if (!cadastrado (email.getId()))
            throw new Exception ("Email nao cadastrado!");

        try {
            String sql;

            sql = "UPDATE EMAIL " +
                  "SET EMAIL=? , " +
                  "SENHA=? , " +
                  "PORTA=? ," +
                  "HOST=? ," +
                  "PROTOCOLO=? , " +
                  "WHERE ID = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString(1, email.getEmail());
            BDSQLServer.COMANDO.setString(2, email.getSenha());
            BDSQLServer.COMANDO.setInt(3, email.getPorta());
            BDSQLServer.COMANDO.setString(4, email.getHost());
            BDSQLServer.COMANDO.setString(5, email.getProtocolo());
            BDSQLServer.COMANDO.setInt(6, email.getId());

            BDSQLServer.COMANDO.executeUpdate();
            BDSQLServer.COMANDO.commit();
        } catch (SQLException erro) {
            throw new Exception ("Erro ao atualizar dados de livro: " + erro.getMessage());
        }
    }

    public static Email getEmail(int id) throws Exception {
        Email email = null;

        try {
            String sql;

            sql = "SELECT * " +
                  "FROM EMAIL " +
                  "WHERE ID = ?";

            BDSQLServer.COMANDO.prepareStatement(sql);

            BDSQLServer.COMANDO.setInt(1, id);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery();

            if (!resultado.first())
                throw new Exception ("Email nao cadastrado!");

            email = new Email(resultado.getInt("ID"), resultado.getInt("ID_DONO"), resultado.getString("EMAIL"), 
                resultado.getString("SENHA"), resultado.getInt("PORTA"), resultado.getString("HOST"), resultado.getString("PROTOCOLO"));
        }
        catch (SQLException erro) {
            throw new Exception (erro.getMessage());
        }

        return email;
    }

    public static MeuResultSet getEmails() throws Exception {
        MeuResultSet resultado = null;

        try {
            String sql;

            sql = "SELECT * " +
                  "FROM EMAIL";

            BDSQLServer.COMANDO.prepareStatement(sql);

            resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery();
        } catch (SQLException erro) {
            throw new Exception(erro.getMessage());
        }

        return resultado;
    }
}