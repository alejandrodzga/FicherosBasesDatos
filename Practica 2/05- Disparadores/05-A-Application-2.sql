-- 05 Disparadores A
--Vista para juntar club y candidates
CREATE OR REPLACE VIEW T7 AS(
SELECT candidates.nick, candidates.club, candidates.member, candidates.type, candidates.req_date, candidates.req_msg, candidates.rej_date, candidates.rej_msg, clubs.open
FROM candidates INNER JOIN clubs
    ON candidates.club=clubs.name
);

CREATE OR REPLACE TRIGGER llenar_T7
INSTEAD OF INSERT ON T7
FOR EACH ROW
BEGIN
INSERT INTO T7(nick, club, member, type, req_date, req_msg, rej_date, rej_msg, open)
VALUES (candidates.new.nick, candidates.new.club, candidates.new.member, candidates.new.type, candidates.new.req_date, candidates.new.req_msg, candidates.new.rej_date, candidates.new.rej_msg, club.open);
END;

-- Disparador Application 
CREATE OR REPLACE TRIGGER application  
INSTEAD OF INSERT ON T7-- SE INSERTA LA INFORMACION DESPUES DE TENERLA EN CLUBS
--INSTEAD OF INSERT ON T7
FOR EACH ROW 
BEGIN
IF :T7.open = 'C'
THEN
    INSERT INTO candidates(nick, club, member, type, req_date, req_msg, rej_date, rej_msg)
    VALUES (:new.nick, :new.club, :new.member, :new.type, :new.req_date, :new.req_msg, current_date, "Club con privacidad cerrada");
END IF;
END;
