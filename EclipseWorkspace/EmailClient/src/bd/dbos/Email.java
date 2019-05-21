package bd.dbos;

import java.io.*;

public class Email {
	protected int id;
	protected int idDono;
	protected String email;
	protected String senha;
	protected int porta;
	protected String host;
	protected String protocolo;

	public Email() {}

	public Email(int id, String email) throws Exception {
		this.setId(id);
		this.setEmail(email);
	}
	
	public Email(int id, int idDono, String email, String senha, int porta, String host, String protocolo) throws Exception {
		this.setId(id);
		this.setIdDono(idDono);
		this.setEmail(email);
		this.setSenha(senha);
		this.setPorta(porta);
		this.setHost(host);
		this.setProtocolo(protocolo);
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdDono() {
		return this.idDono;
	}

	public void setIdDono(int id) throws Exception {
		if (id <= 0)
			throw new Exception("ID invalido!");

		this.idDono = id;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) throws Exception {
		if (email == null)
			throw new Exception("Email ausente!");

		if (email.length() == 50) 
			throw new Exception("Email muito grande!");

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

	public int getPorta() {
		return this.porta;
	}

	public void setPorta(int porta) throws Exception {
		if (porta <= 0)
			throw new Exception("Porta invalida!");

		this.porta = porta;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) throws Exception {
		if (host == null) 
			throw new Exception("Host ausente!");

		if (host.length() == 30) 
			throw new Exception("Host invalido!");

		this.host = host;
	}

	public String getProtocolo() {
		return this.protocolo;
	}

	public void setProtocolo(String protocolo) throws Exception {
		
		if (protocolo == null)
			throw new Exception("Protocolo ausente!");
		
		this.protocolo = protocolo;
	}
}