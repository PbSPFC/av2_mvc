/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.io.Serializable;

/**
 * @aviso Expression status is undefined on line 11, column 13 in Templates/Classes/Class.java.
 *
 * @file Formatos.java
 * @brief Classe Formatos
 * @author Edson Melo de Souza <souzaem@uninove.br>
 * @date 15/05/2015, 13:59:12
 */
public class Formata implements Serializable {

    public Formata() {
    }

    public String firstUp(String value) {
        String mais = "";

        String posicao = "" + value.charAt(0);//pega a primeira letra que sera maiuscula
        String pos = posicao.toUpperCase();    //transforma em maiuscula

        int tamanho = value.length();//ve o tamanho da frase
        for (int i = 1; i < value.length(); i++) {  //coloca o for de acordo com o tamanho
            mais = mais + value.charAt(i); //acrescenta as letras

            if (value.charAt(i) == ' ') {  //se houver um espaço a próxima vai ser transformada em maisucula.
                String maiuscula = "" + value.charAt(i + 1);//pega a próxima apos o espaço  
                String maiuscula2 = maiuscula.toUpperCase();       //transforma em maiuscula.
                mais = mais + maiuscula2;//acrescenta a maiuscula a palavra completa, que se chama mais
                i = i + 1; //soma um, pois uma letra minuscula foi substituida e ja foi acrescentada                                 
            }
        }
        String tudo = pos + mais;
        return tudo;
    }

}
