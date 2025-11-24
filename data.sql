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
