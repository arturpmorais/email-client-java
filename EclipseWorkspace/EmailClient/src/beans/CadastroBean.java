package beans;

import mycrypto.MyCrypto;

public class CadastroBean {
	protected String nome, email, senha;

	public CadastroBean(String nome, String email, String senha) {
		super();
		this.nome = nome;
		this.email = email;
		this.senha = senha;
	}
	
	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) throws Exception{
		MyCrypto md5 = new MyCrypto();
		this.senha = md5.generateMD5(senha);
	}
	
	@Override
	public String toString() {
		return "LoginBean [email=" + email + ", senha=" + senha + "]";
	}
}

