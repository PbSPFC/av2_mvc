package bean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;

/**
 * @file Mensagem.java
 * @brief Classe Mensagem
 * @author DE SOUZA, Edson Melo <souzaem at outlook.com>
 * @date 16/11/2014, 13:31:58
 */
public class Mensagem implements Serializable {

    private int id;
    private int idUsuario;
    private int idDestinatario;
    private String destinatario;  //usuario
    private String remetente;
    private String email;
    private String assunto;
    private String mensagem;
    private String hash;
    private int lida;
    private Calendar dataEnvio;

    public Mensagem() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getIdDestinatario() {
        return idDestinatario;
    }

    public void setIdDestinatario(int idDestinatario) {
        this.idDestinatario = idDestinatario;
    }

    public String getDestinatario() {
        return destinatario;
    }

    public void setDestinatario(String destinatario) {
        this.destinatario = destinatario;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAssunto() {
        return assunto;
    }

    public void setAssunto(String assunto) {
        this.assunto = assunto;
    }

    public String getMensagem() {
        return mensagem;
    }

    public void setMensagem(String mensagem) {
        this.mensagem = mensagem;
    }

    public String getHash() {
        return hash;
    }

    public void setHash(String hash) {
        this.hash = hash;
    }

    public int getLida() {
        return lida;
    }

    public void setLida(int lida) {
        this.lida = lida;
    }

    public String getRemetente() {
        return remetente;
    }

    public void setRemetente(String remetente) {
        this.remetente = remetente;
    }

    
    public Calendar getDataEnvio() {
        return dataEnvio;
    }

    public void setDataEnvio(Calendar dataEnvio) {
        this.dataEnvio = dataEnvio;
    }

    public ArrayList<String> verificaDados() {

        ArrayList<String> campos = new ArrayList<>();

        if (assunto.isEmpty()) {
            campos.add("O campo Assunto deve ser preenchido");
        }

        if (email.isEmpty()) {
            campos.add("O campo Email deve ser preenchido");
        }

        if (mensagem.isEmpty()) {
            campos.add("O campo Mensagem deve ser preenchido");
        }

        return campos;
    }
}
