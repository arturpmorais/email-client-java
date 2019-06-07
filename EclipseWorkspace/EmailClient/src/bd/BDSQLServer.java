package bd;

import bd.core.*;
import bd.daos.*;

public class BDSQLServer
{
    public static final MeuPreparedStatement COMANDO;

    static
    {
    	MeuPreparedStatement comando = null;

    	try
        {
            comando =
            new MeuPreparedStatement (
            "com.microsoft.sqlserver.jdbc.SQLServerDriver",
            "jdbc:sqlserver://143.106.250.84:1433;databasename=BD17175",
            "BD17175", "BD17175");
        }
        catch (Exception erro)
        {
            System.err.println ("Problemas de conexao com o BD" + erro.getMessage() + erro.getClass() + erro.getStackTrace());
            System.exit(0); // aborta o programa
        }
        
        COMANDO = comando;
    }
}