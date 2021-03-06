package dbos;

import java.io.*;

public class Usuario {
	protected int id;
	protected String email;
	protected String senha;

	public Usuario() {}

	public Usuario(int id, String email, String senha) {
		this.setId(id);
		this.setEmail(email);
		this.setSenha(senha);
	}

	public int getId(){
		return this.id;
	}

	public void setId(int id){
		this.id = id;
	}

	public String getEmail(){
		return this.email;
	}

	public void setEmail(String email) throws Exception{
		if (email == null)
			throw new Exception("Email ausente!");

		this.email = email;
	}

	public String getSenha(){
		return this.senha;
	}

	public void setSenha(String senha) throws Exception{
		if (senha == null)
			throw new Exception("Senha ausente!");

		this.senha = senha;
	}
}