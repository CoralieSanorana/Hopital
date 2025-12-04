************ HOPITAL *************
    * [ok]installer DBeaver
    * [ok] inserer les donnes
========================== PARTIE 1 =============== PHARMACIE =================================
    
    * [ok] visionner les data a utiliser{  (EN COURS ....
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

        ***** home.jsp *****  
        - PAGE:
            . [ok] creer page home.jsp
            . [ok] afficher le user actuelle
            . [ok] mettre un navbar pour faciliter orientation
            . [ok] formulaire de saisi des ordonnances{
                * [ok] quel docteur (liste deroulante)
                * [ok] quel patient (liste deroulante)
                * [ok] quels sont les medicaments{
                    . [ok] afficher tous les medicaments
                    . [ok] ajouter des checkbox (pour checker les medicaments a prescrire)
                    . [ok] ajouter un input number(pour prendre la quantite)
                    . [ok] ajouter un input text (pour les descriptions)
                }
            }
            . [ok] sauvegarder les ordonnances saisi
            . [ok] diriger les informations vers traitement.jsp
        - FONCTION:
            . [ok] get_clients()
            . [ok] get_medecins()
            . [ok] get_medicaments()
            
        - JAVA:
            . [ok] creer Client.java
            . [ok] creer Medecin.java
            . [ok] creer Medicament.java
            

        ****** traitement.jsp ******** 
        - PAGE:
            .[ok] creer page traitement.jsp
            .[ok] recuperer les informations du formulaire
            .[ok] insertion des donnees (ordonnance, ordonnance_fille)
                * appel de la fonction insert_ordonnance()
                * appel de la fonction insert_ordonnance_fille()
            .[ok] verification de cette action{
                * si inserer -> envoyer message de succes vers ordonnances.jsp
                * si non -> envoyer message de error vers home.jsp
            }

        - FONCTION:
            . [ok] insert_ordonnance()
            . [ok] insert_ordonnance_fille()
        - JAVA:
            . [ok] creer Med_Ordonnance.java
            . [ok] creer MedOrdonnanceFille.java


        ****** ordonnances.jsp ******** (EN COURS ......)
        -PAGE:
            [ok] creer page ordonnances.jsp
                .[ok] afficher tous les ordonnances
                .[ok] ajouter bouton livrer -> diriger vers livraison.jsp
        - FONCTION:
            . [ok] get_medordonnances()
            . [ok] get_medordonnances_fille()
            

        ********** livraison.jsp **********
        - PAGE:
            - [ok] creer page livraison.jsp
                . [ok] recuperer les informations venant de ordonnances.jsp{
                    -[ok] idmedecin
                    -[ok] idpatient
                    -[ok] les medicaments choisis
                   }
                . [ok] insere une nouvelle Vente 
                . [ok] insere tous les VenteDetaille
                . [ok] insere une nouvelle MvtStock 
                . [ok] insere tous les MvtStockFille 
                . [ok] update la date fin de ordonnance liverer
                ->  diriger vers Stock.jsp 
        - FONCTION:
            [ok] get_1ordonnance()
            [ok] set_vente()
            [ok] set_vente_details()
            [ok] get_VenteDetails()
            [ok] update_datefin_ordonnance()
            [ok] getVenteById()
            [ok] get_VenteDetails()
            [ok] set_MvtStock()
            [ok] set_MvtStockFille()

        - JAVA:
            [OK] EtatStock.java
            [ok] Vente.java
            [ok] VenteDetaille.java
            [ok] MvtStock.java
            [ok] MvtStockFille.java

        ******* Stock.jsp ******
        -PAGE:
            - [ok] creer page Stock.jsp
                . [ok] apres livraison, calculer le reste de stockage
                . [ok] recupere les donnees dans V_ETATSTOCK_ING
                . [OK] afficher etat de stock de chaque medicament
        - FONCTION:
            [OK] get_EtatStock


        ******* Entree.jsp *******
        -PAGE:
            [ok] creer page Entree.jsp
                [ok] afficher tous les medicaments{
                    [ok] mettre input checkbox
                    [ok] mettre input numbre (nbre entree)
                    [ok] mettre date entree
                    [ok] bouton sauvegarder_Entree
                    -> diriger vers traite_entree.jsp
                }

        
        ****** traite_entree.jsp *********
        -PAGE:
            [ok] creer page traite_entree.jsp
            [ok] recuperer les informations venant de Entree.jsp
            [ok] appel de fonction
                .[ok] set_MvtStock()
                .[ok] set_MvtStockFille()


        **** arreter.jsp ******
        -PAGE:
            [ok] creer page arreter.jsp
            [ok] date de arretage
            [ok] afficher les medicaments et etat de stockage{
                [ok] medicament
                [ok] quantite logiciel
                [ok] quantite reelle (input number)
            }
            [ok] bouton ajustement
            --> diriger vers traite_arretage.jsp

        -FONCTION:
            [ok] insert_inventaire()
            [ok] insert_inventairefille()
            [ok] get_inventairefille_ing()

        - JAVA:
            [ok] Iventaire.java
            [ok] IventaireFille.java
            [ok] IventaireFille_ING.java

        
        ****** traite_arretage.jsp ********
        -PAGE:
            [ok] creer page traite_arretage.jsp
            [ok] recuperer les informations venant de arreter.jsp
            [ok] creer un nouveau inventaire a la date actuelle
            [ok] creer les inventairefille pour chaque medicament{
                [ok] donner quantite logiciel
                [ok] donner quantite reelle
            }
            (DANS le cas ou quantite reelle != quantite logiciel){
                [ok] ajouter un mouvement de contrage{
                    [ok] inserer un nouveau mouvement
                    [ok] inserer les MvtStockFille pour chaque contrage{
                        si logiciel > reelle  =  type sortie
                        si logiciel < reelle  = type entree
                    }
                }
            }

        ******* Inventaire.jsp *********
        -PAGE:
            [ok] creer la apge Inventaire.jsp
            [ok] afficher les inventaires les plus recentes
            [ok] mettre un input date pour chercher des inventaire
                a cette date donner

        -FONCTION:
            [ok] getInventaireById() -> by id
            [ok] getInventaireByDate() -> date


========================= PARTIE 2 ================= EQUIVALENCE des UNITES ===================
******** les tables a voir ********
    [] equivalence{     (demander a chat)
        [] ajouter les colonnes
        - unite_ref
        - pv
        [] inserer les equivalences pour chaque as_ingredients
        - mettre le prix de vente fixe
    }
    [ok] med_ordonnance_fille{
        [ok] les ajustement action faire 
        - mettre dans prix le prix total
        - mettre dans unite le type de unite choisi
        - mettre dans puunite le prix de unite choisi
        - mettre dans quantite la quantite de unite choisi 
    }
    [ok] vente_details{
        [ok] ajouter colonne
         - unite
         - qte_total
        [ok] ajustement a faire 
         - mettre dans unite le unite choisi
         - mettre dans QTE la quantite de unite vendu
         - mettre dans qte_total le total des pieces vendu
    }
    [] mvtstockfille{
        [ok] ajouter les colonnes
        - unite
        - quantite
        - pv
        [] ajustement a faire
        - mettre dans quantite la quantite de unite choisi
        - mettre dans entree/sortie la qte_total en piece du medicament
        - mettre dans pv le pv de unite choisi
        ----> (le prix total = pv * quantite)
    }
    [ok] as_unite
    [ok] as_unite_v  

***** home.jsp *****
 - PAGE:
    [ok] mettre une liste deroulante de type de unite
 - FONCTION:
    [ok] get_as_unite_v()
 -JAVA:
    [ok] Unite.java

***** traitement.jsp *****
 - PAGE:
    [ok] prendre les unite choisi
    [ok] prendre le pv de unite choisi
    [ok] mettre dans pu(med_ordonnance_fille) le pv(unite choisi)
    [ok] inserer dans unite(med_ordonnance_fille) le unite choisi
 - FONCTION: 
    [ok] get_equivalence()
 - JAVA:
    [ok] Equivalence.java

****** livraison.jsp **********
    [] ajuster les insertion de :
      - vente_details
      - mvtstockfille
