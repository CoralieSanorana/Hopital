************ HOPITAL *************
    * [ok]installer DBeaver
    * [ok] inserer les donnes
========================== PARTIE 1 =============== PHARMACIE =================================
    
    * [] visionner les data a utiliser{  (EN COURS ....
    )
            - med_medecin
            - client
            - user_log 
            - ordonnances{
                .med_ordonnance
                .med_ordonnance_fille
                .ordonnancepdg
                .prescription
            } 
            - as_ingredients (medicaments)
            - livraison
            - stockage{
                .etatstock
                .mvtstock
            }
        }
    [ok] ameliorer deploy.sh

    ====== language UTILISER ========
        - JSP
        - JAVA
        - CSS

    ===== JAVA =======
        Function.java
            (la ou il y a tous les fonctions)
        User.java
            [ok] une classe qui represente user_log dans les data
        VanialaConnection.java
            [ok] getConnection()

    ===== DATA ========
        - [ok] prendre la base de donnees originale
        - [ok] creer table user (pour pouvoir se loger)
            . [ok] nom
            . [ok] pwd
            . [ok] id avec sequence increment
    
    ====== JSP ========
        ***** login.jsp ******
        - PAGE: 
            . [ok] creer page login.jsp 
            . [ok] formulaire de login (nom && pwd)
            . [ok] diriger vers form.jsp
        - FONCTION:
            . [ok] login()

        ***** form.jsp ******
        - PAGE:
            . [ok] creer page form.jsp
            . [ok] recuperer les informations saisi dans login.jsp
            . [ok] verifier si le user existe
            . [ok] appel de la fonction login()
                ~[ok] si oui -> diriger vers home.jsp
                ~[ok] si non -> diriger vers login.jsp (avec message erreur)

        ***** home.jsp *****  (EN COURS ......)
        - PAGE:
            . [] creer page home.jsp
            . [ok] afficher le user actuelle
            . [ok] mettre un navbar pour faciliter orientation
            . [] formulaire de saisi des ordonnances{
                * [ok] quel docteur (liste deroulante)
                * [ok] quel patient (liste deroulante)
                * [ok] quels sont les medicaments{
                    . [ok] afficher tous les medicaments
                    . [ok] ajouter des checkbox (pour checker les medicaments a prescrire)
                    . [ok] ajouter un input number(pour prendre la quantite)
                    . [ok] ajouter un input text (pour les descriptions)
                }
            . [] daty, date debut, date fin
            }
            . [] sauvegarder les ordonnances saisi
            . [] diriger les informations vers form.jsp
        - FONCTION:
            . [ok] get_clients()
            . [ok] get_medecins()
            . [ok] get_medicaments()
            
        - JAVA:
            . [ok] creer Client.java
            . [ok] creer Medecin.java
            . [ok] creer Medicament.java
            

        ****** form.jsp ********
        - PAGE:
            .[] creer page form.jsp
            .[] recuperer les informations du formulaire
            .[] insertion des donnees (ordonnance, ordonnance_fille)
                * appel de la fonction insert_ordonnance()
                * appel de la fonction insert_ordonnance_fille()
            .[] verification de cette action{
                * si inserer -> envoyer message de succes vers home.jsp
                * si non -> envoyer message de error vers home.jsp
            }

        - FONCTION:
            . [ok] get_medordonnances()
            . [ok] get_medordonnances_fille()
            . [] insert_ordonnance()
            . [] insert_ordonnance_fille()
        - JAVA:
            . [ok] creer Med_Ordonnance.java
            . [ok] creer MedOrdonnanceFille.java


        - [] creer page livraison des medicaments
            . [] afficher seulement tous les ordonnances non livrer
            . [] cliquer sur un ordonnance pour le livrer
            . [] gerer le stock des medicaments apres livraison{
                * [] afficher le stock actuelle
                * [] afficher erreur au cas ou le stock est peu
            }


        - [] creer page inventaire de stock
            . [] apres livraison, calculer le reste de stockage
            . [] voir etat theorique et etat reel du stockage{
                * [] en cas de desequilibre ( afficher ce qui se passe)
            }
            **** Un arreter ******
                . [] est le fait de faire une observation profonde de etat de stockage
                . [] voir si il y a manque ou surplus de stock