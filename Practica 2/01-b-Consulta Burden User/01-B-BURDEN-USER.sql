-- CONSULTA a BURDEN-USER 

WITH T1 AS(  -- Aqui obtenemos los usuarios con mas de seis de registro 
SELECT nick
FROM users
WHERE reg_date<= ADD_MONTHS(current_date, -6)
),

T2 AS(   -- Aqui tenemos los usuarios con mas de 6 meses que no ha pertenecido ni pertencen a ningun club
SELECT nick
FROM T1
WHERE nick NOT IN (SELECT nick FROM membership)
),

T3 AS(  -- Aqui­ cogemos lo perfiles que tienen o han tenido un contrato
SELECT nick 
FROM profiles
WHERE citizenid IN (SELECT citizenid FROM contracts) 
),

T4 AS(  --Aqui hacemos una anti-combinacion para obtener el resultado
SELECT nick
FROM T2
WHERE nick NOT IN (SELECT nick FROM T3)
)
SELECT * FROM T4;