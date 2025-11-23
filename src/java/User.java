package model;
import java.util.*;
import java.sql.*;
import database.*;

public class User{
    private int id;
    private String nom;
    private String pwd;

    public User(){}
    public User(int id, String nom, String pwd) throws Exception{
        try{
            set_id(id);
            set_nom(nom);
            set_pwd(pwd);
        }catch (SQLException e) {
            throw e;
        }
    }

    public int get_id(){ return this.id; }
    public String get_nom(){ return this.nom; }
    public String get_pwd(){ return this.pwd; }

    public void set_id(int id) throws Exception{ 
        try{
            if(id <= 0){
                throw new Exception("ID <= 0 invalide");
            } else{
                this.id = id; 
            }

        }catch (SQLException e) {
            throw e;
        }
    }
    public void set_nom(String nom)throws Exception{ 
        try{
            if(nom == "" || nom == null){
                throw new Exception("NOM VIDE invalide");
            } else{
                this.nom = nom; 
            }
        }catch (SQLException e) {
            throw e;
        }
    }
    public void set_pwd(String pwd) throws Exception{ 
        try{
            if(pwd == "" || pwd == null){
                throw new Exception("PWD VIDE invalide");
            } else{
                this.pwd = pwd; 
            }
        }catch (SQLException e) {
            throw e;
        }
    }



}