package email;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailHandler {
	
	protected String emailAddress, password, protocol, host, port;
	protected Session mySession;
	protected Store myStore;
	
	public EmailHandler (String emailAddress, String password, String protocol, String host, String port) 
			throws Exception {

        this.emailAddress = emailAddress;
        this.password = password;

        Properties properties = new Properties();

        properties.put(parseProperty("mail", protocol, "host"), parseProperty("mail", host, "com"));
        properties.put(parseProperty("mail", protocol, "port"), port);
        properties.put(parseProperty("mail", protocol, "starttls", "enable"), "true");


        /* codigo caso seja desejado fazer a conexao em POP3:

        propriedades.put("mail.pop3.host", "pop.gmail.com");
        propriedades.put("mail.pop3.port", "995");
        propriedades.put("mail.pop3.starttls.enable", "true");

        */
        
        this.mySession = Session.getDefaultInstance(properties);
        this.myStore = mySession.getStore("imaps");
        this.myStore.connect("imap.gmail.com", emailAddress, password);
    }
	
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
        Message newMessage = new MimeMessage(mySession);
        newMessage.setFrom(new InternetAddress(this.emailAddress)); //Remetente

        Address[] toUser = InternetAddress //Destinatário(s)
                .parse(destination);
        
        newMessage.setRecipients(Message.RecipientType.TO, toUser);
        newMessage.setSubject(subject); //Assunto
        newMessage.setText(content);

        Transport.send(newMessage);
    }

    public Message[] listInboxEmails() throws Exception {
    	
        Folder inboxFolder = myStore.getFolder("INBOX");
        try {
            inboxFolder.open(Folder.READ_ONLY);
            return inboxFolder.getMessages();
            
        } finally {
            inboxFolder.close();
        }
    }

    public Folder[] listFolders() throws Exception{
        return myStore.getDefaultFolder().list();
    }
}
