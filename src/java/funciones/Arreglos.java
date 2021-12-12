/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package funciones;

/**
 *
 * @author PcCom
 */
public class Arreglos {
    
    public String fixtexto(String estetexto){
        estetexto = estetexto.replaceAll("Ã±", "ñ");
        estetexto = estetexto.replaceAll("Ã", "Ñ");
        estetexto = estetexto.replaceAll("Âº", "º");
        estetexto = estetexto.replaceAll("Ã¡", "á");
        estetexto = estetexto.replaceAll("Ã©", "é");
        estetexto = estetexto.replaceAll("Ã­", "í");
        estetexto = estetexto.replaceAll("Ã³", "ó");
        estetexto = estetexto.replaceAll("Ãº", "ú");
        estetexto = estetexto.replaceAll("Ã", "Á");
        estetexto = estetexto.replaceAll("Ã", "É");
        estetexto = estetexto.replaceAll("Ã", "Í");
        estetexto = estetexto.replaceAll("Ã", "Ó");
        estetexto = estetexto.replaceAll("Ã", "Ú");
        String segundotexto = estetexto;
        segundotexto = segundotexto.replaceAll("Ñ¡", "á");
        segundotexto = segundotexto.replaceAll("Ñ©", "é");
        segundotexto = segundotexto.replaceAll("Ñ­", "í");
        segundotexto = segundotexto.replaceAll("Ñ³", "ó");
        segundotexto = segundotexto.replaceAll("Ñº", "ú");
        segundotexto = segundotexto.replaceAll("Ñ", "Á");
        segundotexto = segundotexto.replaceAll("Ñ", "É");
        segundotexto = segundotexto.replaceAll("Ñ", "Í");
        segundotexto = segundotexto.replaceAll("Ñ", "Ó");
        segundotexto = segundotexto.replaceAll("Ñ", "Ú");
        return segundotexto;
    }
}
