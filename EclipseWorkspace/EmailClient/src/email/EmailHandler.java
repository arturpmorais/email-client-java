package email;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.security.MessageDigest;
import java.util.Properties;

import bd.dbos.Email;

public class EmailHandler {
	
	protected String emailAddress, password, protocol, host;
	protected int port;
	protected Properties myProperties;
	protected Session mySession;
	protected Store myStore;
	
	public EmailHandler (String emailAddress, String password, String protocol, String host, int port) 
			throws Exception {

        this.emailAddress = emailAddress;
        this.password = password;

        myProperties = new Properties();

        myProperties.put(parseProperty("mail", protocol, "host"), parseProperty(protocol, host, "com"));
        myProperties.put(parseProperty("mail", protocol, "port"), "" + protocol);
        myProperties.put(parseProperty("mail", protocol, "starttls", "enable"), "true");


        /* codigo caso seja desejado fazer a conexao em POP3:

        propriedades.put("mail.pop3.host", "pop.gmail.com");
        propriedades.put("mail.pop3.port", "995");
        propriedades.put("mail.pop3.starttls.enable", "true");

        */
        
        this.mySession = Session.getDefaultInstance(myProperties);
        this.myStore = mySession.getStore("imaps");
        this.myStore.connect(parseProperty(protocol, host, "com"), emailAddress, password);
    }
	
	public EmailHandler(Email email) throws Exception { 
		this(email.getEmail(), email.getSenha(), email.getProtocolo(), email.getHost(), 
			email.getPorta());
	}
	
	public EmailHandler() {}
	
	protected String parseProperty(String... infos) {
		String result = "";
		for(String info : infos) {
			if(!(result == ""))
				result += ".";
			result += info;
		}
		return result;
	}
	
	public void renameFolder(String oldName, String newName) throws Exception {
        Folder folder = myStore.getFolder(oldName);

        if (!folder.exists())
            throw new FolderNotFoundException();

        if (folder.isOpen())
            folder.close();

        folder.renameTo(myStore.getFolder(newName));
	}
	
	public void createFolder(String folderName) throws Exception {
        Folder newFolder = myStore.getFolder(folderName);
        
        if (newFolder.exists())
        	throw new Exception("There's already a folder with this name!");
        
        if (newFolder.create(Folder.HOLDS_MESSAGES))
            newFolder.setSubscribed(true);
    }

    public void deleteFolder(String folderName) throws Exception {
        Folder folder = myStore.getFolder(folderName);

        if (!folder.exists())
            throw new FolderNotFoundException();

        if (folder.isOpen())
            folder.close();

        folder.delete(true);
    }

    public void sendEmail(String destination, String subject, String content) throws Exception {
    	try {                        
            Message message = new MimeMessage(mySession);
            message.setFrom(new InternetAddress(this.emailAddress));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destination));
            message.setSubject(subject);
            message.setText(content);
            
            /*
            Transport transport = mySession.getTransport("smtp");
            transport.connect(this.host, Integer.valueOf(this.port), this.emailAddress, this.password);
            transport.sendMessage(message, message.getAllRecipients());
            transport.close();
            */
            Transport.send(message);
            
        } catch(MessagingException e) { } 
    	  catch(Exception e) { }
    	
    	/*
        Message newMessage = new MimeMessage(mySession);
        newMessage.setFrom(new InternetAddress(this.emailAddress)); //Remetente

        Address[] toUser = InternetAddress //Destinatário(s)
                .parse(destination);
        
        newMessage.setRecipients(Message.RecipientType.TO, toUser);
        newMessage.setSubject(subject); //Assunto
        newMessage.setText(content);

        Transport.send(newMessage);
    	*/
    }

    public Message[] listInboxEmails() throws Exception {
    	
        Folder inboxFolder = myStore.getFolder("INBOX");
        inboxFolder.open(Folder.READ_ONLY);
        try {
            return inboxFolder.getMessages();
            
        } finally {
            //inboxFolder.close();
        }
    }

    public Folder[] listFolders() throws Exception {
        return myStore.getDefaultFolder().list();
    }

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getProtocol() {
		return protocol;
	}

	public void setProtocol(String protocol) {
		this.protocol = protocol;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public Session getMySession() {
		return mySession;
	}

	public void setMySession(Session mySession) {
		this.mySession = mySession;
	}

	public Store getMyStore() {
		return myStore;
	}

	public void setMyStore(Store myStore) {
		this.myStore = myStore;
	}
    
}
