package bd.dbos;

import java.io.*;

public class Usuario {
	protected int id;
	protected String nome;
	protected String email;
	protected String senha;

	public Usuario() {}

	public Usuario(int id, String nome, String email, String senha) throws Exception {
		this.setId(id);
		this.setNome(nome);
		this.setEmail(email);
		this.setSenha(senha);
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) throws Exception{
		if (id <= 0) 
			throw new Exception("ID invalido!");

		this.id = id;
	}

	public String getNome() {
		return this.nome;
	}

	public void setNome(String nome) throws Exception {
		if (nome == null) 
			throw new Exception("Nome ausente!");

		this.nome = nome;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) throws Exception {
		if (email == null)
			throw new Exception("Email ausente!");

		this.email = email;
	}

	public String getSenha() {
		return this.senha;
	}

	public void setSenha(String senha) throws Exception {
		if (senha == null)
			throw new Exception("Senha ausente!");

		this.senha = senha;
	}
}