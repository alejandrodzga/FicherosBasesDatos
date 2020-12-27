-- 05 Disparador Overwrite B
CREATE OR REPLACE TRIGGER overwrite  
BEFORE INSERT ON comments -- SE INSERTA LA INFORMACION DESPUES DE TENERLA EN CLUBS
FOR EACH ROW 
BEGIN
IF :new.nick IS old.nick
THEN
    INSERT INTO comments(old.club, old.nick, old.msg_date, old.title, old.director, old.subject, old.msg, old,valoration)
    VALUES (new.club, new.nick, new.msg_date, new.title, new.director, new.subject, new.msg, new,valoration);
END IF;
END;
