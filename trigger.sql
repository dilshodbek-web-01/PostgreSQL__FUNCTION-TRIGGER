--  trigger info
https://www.postgresqltutorial.com/postgresql-triggers/

TRIGGER
PROCEDURE

CREATE DATABASE trigger_db;

DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users(
    ID INT PRIMARY KEY     NOT NULL,
    USERNAME  VARCHAR    NOT NULL,
    AGE            INT     NOT NULL,
    EMAIL  VARCHAR NOT NULL
);

INSERT INTO users (id, USERNAME,AGE,EMAIL)
VALUES (1,'Paul', 32, 'California@gmail.com');
 
INSERT INTO users (id, USERNAME,AGE,EMAIL)
VALUES (2,'John', 23, 'example@gmail.com');

DELETE FROM users WHERE id = 1;


-- deleted users log 
CREATE TABLE deletedUserLog(
    ID INT PRIMARY KEY     NOT NULL,
    USERNAME  VARCHAR    NOT NULL,
    AGE            INT     NOT NULL,
    EMAIL  VARCHAR NOT NULL
);

CREATE OR REPLACE FUNCTION deleteUserlogfunc() 
RETURNS TRIGGER 
AS $example_table$
   BEGIN
      INSERT INTO deletedUserLog(ID, USERNAME, AGE, EMAIL) 
      VALUES (old.ID, old.USERNAME, old.AGE, old.EMAIL);
      RETURN old;
   END;
$example_table$ LANGUAGE plpgsql;
 
CREATE TRIGGER deleteUser_trigger AFTER DELETE ON users
FOR EACH ROW EXECUTE PROCEDURE deleteUserlogfunc(); 


-- created user log
CREATE TABLE createdUserLog(
   ID INT PRIMARY KEY     NOT NULL,
   USERNAME  VARCHAR    NOT NULL,
   AGE            INT     NOT NULL,
   EMAIL  VARCHAR NOT NULL
);

CREATE OR REPLACE FUNCTION createdUserlogfunc() 
RETURNS TRIGGER 
AS $example_table$
   BEGIN
      INSERT INTO createdUserLog(ID, USERNAME, AGE, EMAIL) 
      VALUES (new.ID, new.USERNAME, new.AGE, new.EMAIL);
      RETURN new;
   END;
$example_table$ LANGUAGE plpgsql;

CREATE TRIGGER insert_trigger AFTER INSERT ON users
FOR EACH ROW EXECUTE PROCEDURE createdUserlogfunc();
 
INSERT INTO users (id, USERNAME,AGE,EMAIL)
VALUES (3,'Anvar', 32, 'anvar@gmail.com');
 
INSERT INTO users (id, USERNAME,AGE,EMAIL)
VALUES (4,'John', 23, 'example@gmail.com');
 

-- updated user log
CREATE TABLE updatedUserLog(
   ID INT PRIMARY KEY     NOT NULL,
   old_username  VARCHAR    NOT NULL,
   new_username  VARCHAR    NOT NULL,
   AGE            INT     NOT NULL,
   EMAIL  VARCHAR NOT NULL
);
 
CREATE OR REPLACE FUNCTION updatedUserlogfunc() 
RETURNS TRIGGER 
AS $update_user$
   BEGIN
      INSERT INTO updatedUserLog(ID, old_username, new_username, AGE, EMAIL) 
      VALUES (old.ID, old.USERNAME, new.USERNAME, new.AGE, new.EMAIL);
      RETURN new;
   END;
$update_user$ LANGUAGE plpgsql;
 
CREATE TRIGGER update_trigger AFTER UPDATE ON users
FOR EACH ROW EXECUTE PROCEDURE updatedUserlogfunc();
 
-- UPDATE 
UPDATE users SET USERNAME = 'lochinbek' WHERE id = 3;

-- DELETE TRIGGER
DROP TRIGGER updateD_trigger ON users;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 