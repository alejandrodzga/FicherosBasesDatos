-- 03 Historico
---------------------- Creacion de las vistas ----------------------------------------------------------
CREATE OR REPLACE VIEW clubes_vigentes AS( -- Insertamos los existentes de clubs en vigentes, es decir aquellos que no tienen fecha de fin 
SELECT name,founder,cre_date,slogan,open
FROM clubs
WHERE end_date IS NULL
);

CREATE OR REPLACE VIEW clubes_historicos AS( -- Insertamos los clubes existentes que tienen fecha de finalizacion para que consten en la vista de historicos
SELECT name,founder,cre_date, end_date,slogan,open
FROM clubs
WHERE end_date IS NOT NULL
);
------ Creacion de los disparadores-----------------------------------------
-- Trigger 1 que al eliminar de historicos pasa a eliminarse de la tabla de clubs 
CREATE OR REPLACE TRIGGER eliminar_historicos
instead of DELETE ON CLUBES_HISTORICOS
FOR EACH ROW
BEGIN
    DELETE FROM CLUBS
    WHERE CLUBS.NAME = :OLD.NAME AND CLUBS.FOUNDER = :OLD.FOUNDER;
END; 
-- Trigger 2 que cuando se elimina un elemento de vigentes pase a historicos
CREATE OR REPLACE TRIGGER eliminar_vigentes_to_historico
INSTEAD OF DELETE ON clubes_vigentes
FOR EACH ROW
DECLARE
  endd_date DATE;
BEGIN
    endd_date := CURRENT_DATE;
    INSERT INTO clubes_historicos (name, founder, cre_date, end_date, slogan, open) 
    VALUES(:old.name, :old.founder, :old.cre_date, endd_date, :old.slogan, :old.open); 
END;
-- Trigger 3 que impida la operacion de modificar en las vistas VIGENTES 
CREATE OR REPLACE TRIGGER NO_UPDATE_VIGENTES
INSTEAD OF UPDATE ON clubes_vigentes
FOR EACH ROW
BEGIN 
-- SOLO EVITA LA ACTUALIZACION DE DATOS EN LA VISTA
END;
EXCEPTION
    dbms_output.put_line('No se puede actualizar la vista.');
END;
--  Trigger 4 que impida la operacion de modificar en las vistas NO VIGENTES 
CREATE OR REPLACE TRIGGER NO_UPDATE_HISTORICOS
INSTEAD OF UPDATE ON clubes_historicos
FOR EACH ROW
BEGIN 
-- SOLO EVITA LA ACTUALIZACION DE DATOS EN LA VISTA
END;
EXCEPTION
    dbms_output.put_line('No se puede actualizar la vista.');
END;