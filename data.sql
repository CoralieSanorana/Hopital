/* TABLE USER_LOG */
    create table user_log(
        id_user_log NUMBER PRIMARY KEY,
        nom_user_log VARCHAR2(20) NOT NULL,
        pwd_user_log VARCHAR2(20) NOT NULL
    );
    create SEQUENCE seq_user_log
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    /
    create or replace TRIGGER user_before_insert
    BEFORE INSERT ON user_log
    FOR EACH ROW
    BEGIN
        :NEW.id_user_log := seq_user_log.NEXTVAL;
    END;
    /
    INSERT INTO user_log (nom_user_log,pwd_user_log) 
    VALUES ('Coralie','123');

/* INCREMENTER LES ID DE MED)ORDONNANCE */
    CREATE OR REPLACE TRIGGER VANIALA.TRG_MED_ORDONNANCE_BI
    BEFORE INSERT ON VANIALA.MED_ORDONNANCE
    FOR EACH ROW
    BEGIN
        IF :NEW.ID IS NULL THEN
            :NEW.ID := 'ORD' || LPAD(SEQ_MED_ORDONNANCE.NEXTVAL, 6, '0');
        END IF;
    END;
    /

/* INCREMENTER LES ID DE MED_ORDONNANCE_FILLE */
    CREATE OR REPLACE TRIGGER VANIALA.TRG_MED_ORDONNANCE_FILLE_BI
    BEFORE INSERT ON VANIALA.MED_ORDONNANCE_FILLE
    FOR EACH ROW
    BEGIN
        IF :NEW.ID IS NULL THEN
            :NEW.ID := 'ORDF' || LPAD(SEQ_MED_ORDONNANCE_FILLE.NEXTVAL, 6, '0');
        END IF;
    END;
    /

/* VIEW DE MED_ORDONNANCE */
CREATE OR REPLACE VIEW V_ORDONNANCE_COMPLET AS
SELECT
    ordo.id,
    ordo.id_consultation,
    ordo.daty,
    ordo.nb_jours,
    ordo.date_debut,
    ordo.date_fin,
    ordo.observation,
    ordo.type,
    ordo.etat,
    ordo.idmedecin,
    cl.id          AS idclient,
    cl.nom,
    cl.telephone,
    cl.mail,
    cl.adresse,
    cl.remarque,
    cl.pers_sexe,
    cl.pers_date_nais,
    med.nom        AS nomMedecin,
    med.prenom     AS prenomMedecin,
    med.matricule,
    med.telephone  AS telMedecin,
    med.email      AS emailMedecin
FROM MED_ORDONNANCE ordo
LEFT JOIN CLIENT cl       ON ordo.observation_soins = cl.id
LEFT JOIN MED_MEDECIN med ON ordo.idmedecin = med.id;


/* RESAKA INVENTAIRE ET ETATSTOCK */
    CREATE OR REPLACE FORCE VIEW "VANIALA"."MVTSTOCKFILLEMONTANT_2" ("ID", "IDMVTSTOCK", "IDPRODUIT", "ENTREE", "SORTIE", "IDVENTEDETAIL", "IDTRANSFERTDETAIL", "PU", "MVTSRC", "RESTE", "DESIGNATION", "MONTANTENTREE", "MONTANTSORTIE") AS 
    SELECT
        mf."ID",
        mf."IDMVTSTOCK",
        mf."IDPRODUIT",
        mf."ENTREE",
        mf."SORTIE",
        mf."IDVENTEDETAIL",
        mf."IDTRANSFERTDETAIL",
        mf."PU",
        mf."MVTSRC",
        mf."RESTE",
        mf."DESIGNATION",
        CAST(mf.PU*mf.quantite AS NUMBER(30,
        2)) AS montantEntree,
        CAST(mf.PU*mf.quantite AS NUMBER(30,
        2)) AS montantSortie
    FROM
	MVTSTOCKFILLE mf ;

    CREATE OR REPLACE FORCE VIEW VANIALA.MVTSTOCKFILLEMONTANT_2
    (ID, IDMVTSTOCK, IDPRODUIT, ENTREE, SORTIE, IDVENTEDETAIL, IDTRANSFERTDETAIL,
    PU, MVTSRC, RESTE, DESIGNATION, MONTANTENTREE, MONTANTSORTIE)
    AS
    SELECT 
        mf.ID,
        mf.IDMVTSTOCK,
        mf.IDPRODUIT,
        mf.ENTREE,
        mf.SORTIE,
        mf.IDVENTEDETAIL,
        mf.IDTRANSFERTDETAIL,
        mf.PU,
        mf.MVTSRC,
        mf.RESTE,
        mf.DESIGNATION,
        CASE WHEN mf.ENTREE > 0 THEN ROUND(mf.ENTREE * mf.PU, 2) ELSE 0 END AS MONTANTENTREE,
        CASE WHEN mf.SORTIE > 0 THEN ROUND(mf.SORTIE * mf.PU, 2) ELSE 0 END AS MONTANTSORTIE
    FROM VANIALA.MVTSTOCKFILLE mf;
    /

    CREATE OR REPLACE VIEW V_ETATSTOCK_ING_2 AS
    SELECT
        p.ID                                            AS "ID",
        p.LIBELLE                                       AS "IDPRODUITLIB",
        p.CATEGORIEINGREDIENT                           AS "CATEGORIEINGREDIENT",
        tp.DESCE                                        AS "IDTYPEPRODUITLIB",
        NVL(ms.IDMAGASIN, 'MAG001')                     AS "IDMAGASIN",
        mag.VAL                                         AS "IDMAGASINLIB",
        NVL(ms.DATY, TO_DATE('01-01-2001','DD-MM-YYYY')) AS "DATEDERNMOUV", 
        NVL(ms.quantite, 0)     AS "QUANTITE",
        NVL(ms.entree, 0)       AS "ENTREE",
        NVL(ms.sortie, 0)       AS "SORTIE",
        NVL(ms.quantite, 0)     AS "RESTE",
        p.UNITE                 AS "UNITE",
        u.DESCE                 AS "IDUNITELIB",
        NVL(p.PV, 0)            AS "PUVENTE",
        mag.IDPOINT             AS "IDPOINT",
        mag.IDTYPEMAGASIN       AS "IDTYPEMAGASIN",
        NVL(p.SEUILMIN, 0)       AS "SEUILMIN",
        NVL(p.SEUILMAX, 0)      AS "SEUILMAX",
        NVL(ms.montantEntree, 0) AS "MONTANTENTREE",
        NVL(ms.montantSortie, 0) AS "MONTANTSORTIE",
        NVL(p.PU, 0)             AS "PU",
        NVL(ms.montant, 0)       AS "MONTANTRESTE",
        NVL(ms.DATY, TO_DATE('01-01-2001','DD-MM-YYYY')) AS "DATY"
    FROM AS_INGREDIENTS p
    LEFT JOIN MONTANT_STOCK_2 ms ON ms.IDPRODUIT = p.ID
    LEFT JOIN CATEGORIEINGREDIENT tp ON p.CATEGORIEINGREDIENT = tp.ID
    LEFT JOIN MAGASINPOINT mag ON NVL(ms.IDMAGASIN, 'MAG001') = mag.ID
    LEFT JOIN AS_UNITE u ON p.UNITE = u.ID;


-- 1. Créer la séquence dans le bon schéma
CREATE SEQUENCE VANIALA.SEQ_INVENTAIRE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOORDER;
    
-- 3. Recréer le trigger (maintenant la séquence existe → plus d’erreur)
CREATE OR REPLACE TRIGGER VANIALA.TRG_INVENTAIRE_BI
BEFORE INSERT ON VANIALA.INVENTAIRE
FOR EACH ROW
BEGIN
IF :NEW.ID IS NULL OR :NEW.ID = '' THEN
    :NEW.ID := 'INV-' || LPAD(VANIALA.SEQ_INVENTAIRE.NEXTVAL, 6, '0');
END IF;
END;
/

-- 1. Créer la séquence dédiée aux lignes filles
CREATE SEQUENCE VANIALA.SEQ_INVENTAIREFILLE
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- Trigger qui génère automatiquement l’ID (ex : INVF-000001)
CREATE OR REPLACE TRIGGER VANIALA.TRG_INVENTAIREFILLE_BI
    BEFORE INSERT ON VANIALA.INVENTAIREFILLE
    FOR EACH ROW
BEGIN
    IF :NEW.ID IS NULL OR :NEW.ID = '' THEN
        :NEW.ID := 'INVF-' || LPAD(VANIALA.SEQ_INVENTAIREFILLE.NEXTVAL, 6, '0');
    END IF;
END;
/

/* vente_details */
ALTER TABLE vente_details ADD(
    unite VARCHAR2(20),
    qte_total NUMBER(10,2)
);

/* mvtstockfille */
ALTER TABLE mvtstockfille ADD(
    unite VARCHAR2(20),
    quantite NUMBER(10,2),
    pv NUMBER(10,2)
);

/* INVENTAIRE FILLE COMPLET */
CREATE OR REPLACE VIEW INVENTAIRE_FILLE_COMPLET AS 
SELECT 
 i.ID ,
 i.IDINVENTAIRE ,
 i.IDPRODUIT ,
 p.LIBELLE AS IDPRODUITLIB,
 i.EXPLICATION ,
 i.QUANTITETHEORIQUE ,
 i.QUANTITE ,
 i2.DATY ,
 i2.IDMAGASIN ,
 i.idJauge,
 i2.ETAT 
FROM INVENTAIREFILLE i 
LEFT JOIN AS_INGREDIENTS  p ON p.ID  = i.IDPRODUIT 
LEFT JOIN INVENTAIRE i2 ON i2.ID  = i.IDINVENTAIRE ;


/* EQUIVALENCE */
-- 1) Création de la table avec clé primaire
CREATE TABLE equivalence (
    id          VARCHAR2(20) PRIMARY KEY,
    idproduit   VARCHAR2(20),
    unite       VARCHAR2(20),
    unite_ref   VARCHAR2(20),
    quantite    NUMBER(10,2),
    pv          NUMBER(10,2)
);
DROP SEQUENCE seq_equivalence;

-- 2) Séquence pour générer les ID
CREATE SEQUENCE seq_equivalence
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
/
-- 3) Trigger BEFORE INSERT
CREATE OR REPLACE TRIGGER equivalence_before_insert
BEFORE INSERT ON equivalence
FOR EACH ROW
BEGIN
    :NEW.id := 'EQUI00-' || seq_equivalence.NEXTVAL;
END;
/

/* (FARANY) */
/* UNITE */
create table AS_UNITE_2(
    id VARCHAR2(20),
    val VARCHAR2(20),
    desce VARCHAR2(20)
);
INSERT INTO AS_UNITE_2 (id,val,desce) VALUES ('UNIT0002','plaquette','plaquette');
INSERT INTO AS_UNITE_2 (id,val,desce) VALUES ('STU000007152420','unite','unite');
INSERT INTO AS_UNITE_2 (id,val,desce) VALUES ('UNI000006','boite','boite');
INSERT INTO AS_UNITE_2 (id,val,desce) VALUES ('UNT001106','carton','carton');
INSERT INTO AS_UNITE_2 (id,val,desce) VALUES ('UNT00005','unite','unite') ;

/* supprimer equivalence */
/* BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE EQUIVALENCE CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
 */

ALTER table equivalence add etat NUMBER(1,0);

INSERT INTO AS_INGREDIENTS 
(id,libelle,unite,pu,CATEGORIEINGREDIENT,pv) VALUES 
('IGC','A medicament','STU000007152420',62,'CATMED',62);

INSERT INTO AS_UNITE_2 (id,val,desce) VALUES ('unite1','uniteDivisible','uniteDivisible');
INSERT INTO AS_UNITE_2 (id,val,desce) VALUES ('unite2','uniteNonDivisible','uniteNonDivisible');

INSERT INTO equivalence (idproduit, unite, unite_ref, quantite, pv,etat) VALUES ('IGC', 'unite1', 'STU000007152420', 100, 5000.0,0);
INSERT INTO equivalence (idproduit, unite, unite_ref, quantite, pv, etat) VALUES ('IGC', 'unite2', 'STU000007152420', 100, 5000.0,1);
