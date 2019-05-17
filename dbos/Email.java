package dbos;

import java.io.*;

public class Email {
	protected int id;
	protected int idDono;
	protected String email;
	protected String senha;
	protected int porta;
	protected String protocolo;

	public Email() {}

	public Email(int id, int idDono, String email, String senha, int porta, String protocolo) {
		this.setId(id);
		this.setIdDono(idDono);
		this.setEmail(email);
		this.setSenha(senha);
		this.setPorta(porta);
		this.setProtocolo(protocolo);
	}

	public int getId(){
		return this.id;
	}

	public void setId(int id){
		this.id = id;
	}

	public int getIdDono(){
		return this.idDono;
	}

	public void setIdDono(int id) throws Exception{
		if (id <= 0)
			throw new Exception('ID inválido!');
		if (id == null)
			throw new Exception('ID ausente!');

		this.idDono = id;
	}

	public String getEmail(){
		return this.email;
	}

	public void setEmail(String email) throws Exception{
		if (email == null)
			throw new Exception('Email ausente!');

		this.email = email;
	}

	public String getSenha(){
		return this.senha;
	}

	public void setSenha(String senha) throws Exception{
		if (senha == null)
			throw new Exception('Senha ausente!');

		this.senha = senha;
	}

	public int getPorta(){
		return this.porta;
	}

	public void setPorta(int porta) throws Exception{
		if (porta <= 0)
			throw new Exception('Porta inválida!');
		if (porta == null)
			throw new Exception('Porta ausente!');

		this.porta = porta;
	}

	public int getProtocolo(){
		return this.protocolo;
	}

	public void setProtocolo(int protocolo) throws Exception{
		if (protocolo <= 0)
			throw new Exception('Protocolo inválida!');
		if (protocolo == null)
			throw new Exception('Protocolo ausente!');
		
		this.protocolo = protocolo;
	}
}