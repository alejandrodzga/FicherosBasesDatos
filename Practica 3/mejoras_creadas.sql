------------------ INDICES CREADOS ----------------------------

-- INDICE PARA LA VISTA 1 CP_aragna

CREATE INDEX ind_view1 ON comments(nick,club,title,director);

-- INDICE PARA LA VISTA 2 leader

CREATE INDEX ind_view2 ON comments(club,title,director);

-- INDICE PARA LA QUERY 2

CREATE INDEX ind_citi1 ON contracts(citizenID);

-- INDICE PARA LA QUERY 3

CREATE INDEX ind_coments ON comments(title,director);


------------------ CLUSTERS CREADOS ----------------------------

-- CLUSTER PARA LA QUERY 2

DROP CLUSTER clusq2;	
CREATE CLUSTER clusq2 (citizenID VARCHAR2(10));
CREATE INDEX index_clusq2 ON CLUSTER clusq2;

CREATE TABLE profiles (
nick           VARCHAR2(35),
name         VARCHAR2(35),
surname     VARCHAR2(35),
secsurname  VARCHAR2(35),
citizenID    VARCHAR2(10) NOT NULL,
mobile       NUMBER(12),
birthdate   DATE,
CONSTRAINT PK_PROFILES PRIMARY KEY (nick),
CONSTRAINT UK_PROFILES UNIQUE (citizenID),
CONSTRAINT FK_PROFILES_USERS FOREIGN KEY (nick) REFERENCES users ON DELETE CASCADE
)CLUSTER clusq2(citizenID);

CREATE TABLE contracts (
idcontract    VARCHAR2(20),
citizenID      VARCHAR2(10) NOT NULL,
contract_type VARCHAR2(50) NOT NULL,
startdate     DATE NOT NULL,
enddate       DATE,
address       VARCHAR2(100) NOT NULL,
town          VARCHAR2(100) NOT NULL,
ZIPcode       VARCHAR2(8) NOT NULL,
country       VARCHAR2(100) NOT NULL,
CONSTRAINT PK_CONTRACTS PRIMARY KEY (idcontract),
CONSTRAINT FK_CONTRACTS_PRODUCTS FOREIGN KEY (contract_type) REFERENCES products,
CONSTRAINT FK_CONTRACTS_PROFILES FOREIGN KEY (citizenID) REFERENCES profiles(citizenID), 
CONSTRAINT CK_CONTRACTS CHECK (enddate IS NULL OR enddate>startdate)
)CLUSTER clusq2(citizenID);
