package bean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

/**
 * @file Usuario.java
 * @brief Classe Usuario
 * @author DE SOUZA, Edson Melo <souzaem at outlook.com>
 * @date 14/11/2014, 20:29:02
 */
public class Usuario implements Serializable {

    private int id;
    private String nome;
    private String email;
    private String senha;
    private String confirmar;

    private Calendar dataCadastro;

    public Usuario() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getConfirmar() {
        return confirmar;
    }

    public void setContraSenha(String contraSenha) {
        this.confirmar = contraSenha;
    }

    public Calendar getDataCadastro() {
        return dataCadastro;
    }

    public void setDataCadastro(Calendar dataCadastro) {
        this.dataCadastro = dataCadastro;
    }

    public Map<String, String> verificaDados() {
        /*
         ArrayList<String> camposInvalidos = new ArrayList<>();

         if (nome.isEmpty()) {
         //camposInvalidos.add("O campo <strong>Nome</strong> deve ser preenchido");
         camposInvalidos.add("nome");
         }

         if (email.isEmpty()) {
         camposInvalidos.add("O campo <strong>Email</strong> deve ser preenchido");
         }

         if (senha.isEmpty()) {
         camposInvalidos.add("O campo <strong>Senha</strong> deve ser preenchido");
         }

         if (contraSenha.isEmpty()) {
         camposInvalidos.add("O campo <strong>Repetir senha</strong> deve ser preenchido");
         }

         if ((!senha.isEmpty()) && (!contraSenha.isEmpty())) {
         if (!senha.equals(contraSenha)) {
         camposInvalidos.add("As senhas informadas devem ser iguais");
         }
         }
         */

        Map<String, String> campos = new HashMap<>();
        
        if (nome.isEmpty()) {
            campos.put("nome", "");
        } else {
            campos.put("nome", new String(nome));
        }

        if (email.isEmpty()) {
            campos.put("email", "");
        } else {
            campos.put("email", new String(email));
        }

        if (senha.isEmpty()) {
            campos.put("senha", "");
        } else {
            campos.put("senha", new String(senha));
        }

        if (!senha.equals(confirmar)) {
            campos.put("confirmar", "");
        } else {
            campos.put("confirmar", new String(confirmar));
        }
        return campos;
    }
}
