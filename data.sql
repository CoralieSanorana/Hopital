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

CREATE OR REPLACE TRIGGER VANIALA.TRG_MED_ORDONNANCE_BI
BEFORE INSERT ON VANIALA.MED_ORDONNANCE
FOR EACH ROW
BEGIN
    IF :NEW.ID IS NULL THEN
        :NEW.ID := 'ORD' || LPAD(SEQ_MED_ORDONNANCE.NEXTVAL, 6, '0');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER VANIALA.TRG_MED_ORDONNANCE_FILLE_BI
BEFORE INSERT ON VANIALA.MED_ORDONNANCE_FILLE
FOR EACH ROW
BEGIN
    IF :NEW.ID IS NULL THEN
        :NEW.ID := 'ORDF' || LPAD(SEQ_MED_ORDONNANCE_FILLE.NEXTVAL, 6, '0');
    END IF;
END;
/

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


select count(*) from mvtstockfille where idmvtstock = 'MVTST764048846882';

CREATE OR REPLACE VIEW MONTANT_STOCK AS
SELECT
    mf.IDPRODUIT,
    SUM(NVL(mf.ENTREE,0)) AS ENTREE,
    SUM(NVL(mf.SORTIE,0)) AS SORTIE,
    SUM(NVL(mf.ENTREE,0)) - SUM(NVL(mf.SORTIE,0)) AS quantite,
    SUM(NVL(mf.montantEntree,0)) AS montantEntree,
    SUM(NVL(mf.montantSortie,0)) AS montantSortie,
    NVL(ai.PU, 0) * (SUM(NVL(mf.ENTREE,0)) - SUM(NVL(mf.SORTIE,0))) AS montant,
    m.IDMAGASIN,
    MAX(m.DATY) AS daty
FROM mvtStockFilleMontant mf
JOIN MVTSTOCK m ON m.id = mf.IDMVTSTOCK AND m.ETAT >= 11  -- on garde le filtre
JOIN AS_INGREDIENTS ai ON ai.ID = mf.IDPRODUIT
GROUP BY mf.IDPRODUIT, ai.PU, m.IDMAGASIN;


CREATE OR REPLACE VIEW V_ETATSTOCK_ING AS
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
LEFT JOIN MONTANT_STOCK ms ON ms.IDPRODUIT = p.ID
LEFT JOIN CATEGORIEINGREDIENT tp ON p.CATEGORIEINGREDIENT = tp.ID
LEFT JOIN MAGASINPOINT mag ON NVL(ms.IDMAGASIN, 'MAG001') = mag.ID
LEFT JOIN AS_UNITE u ON p.UNITE = u.ID;