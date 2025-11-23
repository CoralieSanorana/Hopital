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