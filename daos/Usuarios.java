package daos;

import core.MeuResultSet;
import bdqsl.BDSQLServer;
import java.sql.*;
import dbos.Usuario;

public class Usuarios {
	public static boolean cadastrado(String email) throws Exception {
        boolean retorno = false;

        try {
            String sql;

            sql = "SELECT * " +
                  "FROM USUARIO " +
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
                  "FROM USUARIO " +
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

    public static void incluir(Usuario usuario) throws Exception {
        if (usuario == null)
            throw new Exception ("Usuario nao fornecido!");
        
        if (cadastrado(usuario.getId()))
            throw new Exception ("Usuario ja cadastrado!");
        
        if (cadastrado(usuario.getEmail()))
            throw new Exception ("Email ja cadastrado!");
        
        try {
            String sql;

            sql = "INSERT INTO USUARIO " +
                  "(ID,EMAIL,SENHA) " +
                  "VALUES " +
                  "(?,?,?)";

            BDSQLServer.COMANDO.prepareStatement(sql);

            BDSQLServer.COMANDO.setInt(1, usuario.getId());
            BDSQLServer.COMANDO.setString(2, usuario.getEmail());
            BDSQLServer.COMANDO.setString(3, usuario.getSenha());

            BDSQLServer.COMANDO.executeUpdate();
            BDSQLServer.COMANDO.commit();
        } catch (SQLException erro) {
            throw new Exception (erro.getMessage());
        }
    }

    public static void excluir(int id) throws Exception {
        if (!cadastrado(id))
            throw new Exception ("Usuario nao cadastrado!");

        try {
            String sql;

            sql = "DELETE FROM USUARIO " +
                  "WHERE ID=?";

            BDSQLServer.COMANDO.prepareStatement(sql);

            BDSQLServer.COMANDO.setInt(1, id);

            BDSQLServer.COMANDO.executeUpdate();
            BDSQLServer.COMANDO.commit();     
        } catch (SQLException erro) {
            throw new Exception (erro.getMessage());
        }
    }

    public static void alterar(Usuario usuario) throws Exception {
        if (usuario == null)
            throw new Exception ("Usuario nao fornecido!");

        if (!cadastrado (usuario.getId()))
            throw new Exception ("Usuario nao cadastrado!");
        
        if (cadastrado(usuario.getNome()))
            throw new Exception ("Nome ja cadastrado!");

        try {
            String sql;

            sql = "UPDATE USUARIO " +
                  "SET EMAIL=? , " +
                  "SENHA=? " +
                  "WHERE ID = ?";

            BDSQLServer.COMANDO.prepareStatement (sql);

            BDSQLServer.COMANDO.setString(1, usuario.getEmail());
            BDSQLServer.COMANDO.setString(2, usuario.getSenha());
            BDSQLServer.COMANDO.setInt(3, usuario.getId());

            BDSQLServer.COMANDO.executeUpdate();
            BDSQLServer.COMANDO.commit();
        } catch (SQLException erro) {
            throw new Exception ("Erro ao atualizar dados de livro: " + erro.getMessage());
        }
    }

    public static Usuario getUsuario(int id) throws Exception {
        Usuario usuario = null;

        try {
            String sql;

            sql = "SELECT * " +
                  "FROM USUARIO " +
                  "WHERE ID = ?";

            BDSQLServer.COMANDO.prepareStatement(sql);

            BDSQLServer.COMANDO.setInt(1, id);

            MeuResultSet resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery();

            if (!resultado.first())
                throw new Exception ("Usuario nao cadastrado!");

            usuario = new Usuario(resultado.getInt("ID"), resultado.getString("EMAIL"), resultado.getString("SENHA"));
        }
        catch (SQLException erro) {
            throw new Exception (erro.getMessage());
        }

        return usuario;
    }

    public static MeuResultSet getUsuarios() throws Exception {
        MeuResultSet resultado = null;

        try {
            String sql;

            sql = "SELECT * " +
                  "FROM USUARIO";

            BDSQLServer.COMANDO.prepareStatement(sql);

            resultado = (MeuResultSet)BDSQLServer.COMANDO.executeQuery();
        } catch (SQLException erro) {
            throw new Exception(erro.getMessage());
        }

        return resultado;
    }
}