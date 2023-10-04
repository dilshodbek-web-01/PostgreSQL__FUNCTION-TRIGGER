cars 
course   
animals
fruits
        
         copy_info table -> CRUD trigger pocedura

CREATE DATABASE trigger_db;

--  extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
SELECT uuid_generate_v4();

-- ======================== cars table ======================= --
CREATE TABLE cars(
   id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
   title VARCHAR NOT NULL,
   color VARCHAR NOT NULL,
   price INT NOT NULL
);

-- create car
CREATE TABLE carsInsert(
   id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
   title VARCHAR NOT NULL,
   color VARCHAR NOT NULL,
   price INT NOT NULL
);
 
CREATE OR REPLACE FUNCTION carsInsertFunc() 
RETURNS TRIGGER 
AS $create_car$
   BEGIN
      INSERT INTO carsInsert(id, title, color, price) 
      VALUES (new.id, new.title, new.color, new.price);
      RETURN new;
   END;
$create_car$ LANGUAGE plpgsql;

CREATE TRIGGER car_insert_trigger AFTER INSERT ON cars
FOR EACH ROW EXECUTE PROCEDURE carsInsertFunc();
 
INSERT INTO cars (title, color, price)
         VALUES ('malibu', 'white', 35000),
                  ('tracker', 'blue', 18000);


-- update car
CREATE TABLE updateCars(
   id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
   old_title VARCHAR NOT NULL,
   new_title VARCHAR NOT NULL,
   color VARCHAR NOT NULL,
   price INT NOT NULL
);
 
CREATE OR REPLACE FUNCTION updateCarsFunc() 
RETURNS TRIGGER 
AS $update_car$
   BEGIN
      INSERT INTO updateCars(id, old_title, new_title, color, price) 
      VALUES (old.id, old.title, new.title, new.color, new.price);
      RETURN new;
   END;
$update_car$ LANGUAGE plpgsql;
 
CREATE TRIGGER car_update_trigger AFTER UPDATE ON cars
FOR EACH ROW EXECUTE PROCEDURE updateCarsFunc();

UPDATE cars SET title = 'cobalt', color = 'black', price = 10000
WHERE id = '5523e88e-3987-4a8c-8394-1e654c24a0fc';


-- delete car
CREATE TABLE deleteCar(
   id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
   title VARCHAR NOT NULL,
   color VARCHAR NOT NULL,
   price INT NOT NULL
);

CREATE OR REPLACE FUNCTION deleteCarFunc() 
RETURNS TRIGGER 
AS $delete_car$
   BEGIN
      INSERT INTO deleteCar(id, title, color, price) 
      VALUES (old.id, old.title, old.color, old.price);
      RETURN old;
   END;
$delete_car$ LANGUAGE plpgsql;

CREATE TRIGGER car_delete_trigger AFTER DELETE ON cars
FOR EACH ROW EXECUTE PROCEDURE deleteCarFunc(); 

DELETE FROM cars WHERE id = 'aac28c5a-aa28-451c-9a15-69edf862d914';


-- ======================== courses table ====================== --
CREATE TABLE courses(
   id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
   title VARCHAR NOT NULL,
   price INT NOT NULL,
   teacher_name VARCHAR NOT NULL
);

-- create course
CREATE TABLE courseInsert(
   id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
   title VARCHAR NOT NULL,
   price INT NOT NULL,
   teacher_name VARCHAR NOT NULL
);
 
CREATE OR REPLACE FUNCTION courseInsertFunc() 
RETURNS TRIGGER 
AS $create_course$
   BEGIN
      INSERT INTO courseInsert(id, title, price, teacher_name) 
      VALUES (new.id, new.title, new.price, new.teacher_name);
      RETURN new;
   END;
$create_course$ LANGUAGE plpgsql;

CREATE TRIGGER course_insert_trigger AFTER INSERT ON courses
FOR EACH ROW EXECUTE PROCEDURE courseInsertFunc();
 
INSERT INTO courses(title, price, teacher_name)
         VALUES ('react', 800000, 'muhriddin'),
                  ('vue', 800000, 'muhriddin');


-- update course
CREATE TABLE updateCourse(
   id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
   old_title VARCHAR NOT NULL,
   new_title VARCHAR NOT NULL,
   price INT NOT NULL,
   teacher_name VARCHAR NOT NULL
);
 
CREATE OR REPLACE FUNCTION updateCourseFunc() 
RETURNS TRIGGER 
AS $update_course$
   BEGIN
      INSERT INTO updateCourse(id, old_title, new_title, price, teacher_name) 
      VALUES (old.id, old.title, new.title, new.price, new.teacher_name);
      RETURN new;
   END;
$update_course$ LANGUAGE plpgsql;
 
CREATE TRIGGER course_update_trigger AFTER UPDATE ON courses
FOR EACH ROW EXECUTE PROCEDURE updateCourseFunc();

UPDATE courses SET title = 'Vue.js', price = 801000, teacher_name = 'hodiev'
WHERE id = 'a72712c8-e3d8-4d5a-9796-f7f19c1f9475';


-- delete course
CREATE TABLE deleteCourse(
   id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
   title VARCHAR NOT NULL,
   price INT NOT NULL,
   teacher_name VARCHAR NOT NULL
);

CREATE OR REPLACE FUNCTION deleteCourseFunc() 
RETURNS TRIGGER 
AS $delete_course$
   BEGIN
      INSERT INTO deleteCourse(id, title, price, teacher_name) 
      VALUES (old.id, old.title, old.price, old.teacher_name);
      RETURN old;
   END;
$delete_course$ LANGUAGE plpgsql;

CREATE TRIGGER course_delete_trigger AFTER DELETE ON courses
FOR EACH ROW EXECUTE PROCEDURE deleteCourseFunc(); 

DELETE FROM courses WHERE id = '46710a8c-f3cd-495d-acb7-845e2c698e70';


-- ======================== animals table ====================== --
CREATE TABLE animals(
   id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
   title VARCHAR NOT NULL,
   type VARCHAR NOT NULL,
   count INT NOT NULL
);

-- create animals
CREATE TABLE animalsInsert(
   id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
   title VARCHAR NOT NULL,
   type VARCHAR NOT NULL,
   count INT NOT NULL
);
 
CREATE OR REPLACE FUNCTION animalsInsertFunc() 
RETURNS TRIGGER 
AS $create_animal$
   BEGIN
      INSERT INTO animalsInsert(id, title, type, count) 
      VALUES (new.id, new.title, new.type, new.count);
      RETURN new;
   END;
$create_animal$ LANGUAGE plpgsql;

CREATE TRIGGER animals_insert_trigger AFTER INSERT ON animals
FOR EACH ROW EXECUTE PROCEDURE animalsInsertFunc();
 
INSERT INTO animals(title, type, count)
         VALUES ('rabbit', 'not-wild', 25),
                  ('bear', 'wild', 85);


-- update animal
CREATE TABLE updateAnimals(
   id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
   old_title VARCHAR NOT NULL,
   new_title VARCHAR NOT NULL,
   type VARCHAR NOT NULL,
   count INT NOT NULL
);
 
CREATE OR REPLACE FUNCTION updateAnimalsFunc() 
RETURNS TRIGGER 
AS $update_animals$
   BEGIN
      INSERT INTO updateAnimals(id, old_title, new_title, type, count) 
      VALUES (old.id, old.title, new.title, new.type, new.count);
      RETURN new;
   END;
$update_animals$ LANGUAGE plpgsql;
 
CREATE TRIGGER animals_update_trigger AFTER UPDATE ON animals
FOR EACH ROW EXECUTE PROCEDURE updateAnimalsFunc();

UPDATE animals SET title = 'lion', type = 'wild', count = 95
WHERE id = '5b896dc3-f3fd-42dc-af49-09126fde56e0';


-- delete animal
CREATE TABLE deleteAnimals(
   id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
   title VARCHAR NOT NULL,
   type VARCHAR NOT NULL,
   count INT NOT NULL
);

CREATE OR REPLACE FUNCTION deleteAniamlsFunc() 
RETURNS TRIGGER 
AS $delete_animal$
   BEGIN
      INSERT INTO deleteAnimals(id, title, type, count) 
      VALUES (old.id, old.title, old.type, old.count);
      RETURN old;
   END;
$delete_animal$ LANGUAGE plpgsql;

CREATE TRIGGER animals_delete_trigger AFTER DELETE ON animals
FOR EACH ROW EXECUTE PROCEDURE deleteAniamlsFunc(); 

DELETE FROM animals WHERE id = '5b896dc3-f3fd-42dc-af49-09126fde56e0';


-- ======================== fruits table ====================== --
CREATE TABLE fruits(
   id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
   title VARCHAR NOT NULL,
   price INT NOT NULL,
   description VARCHAR NOT NULL
);

-- create fruits
CREATE TABLE fruitsInsert(
   id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
   title VARCHAR NOT NULL,
   price INT NOT NULL,
   description VARCHAR NOT NULL
);
 
CREATE OR REPLACE FUNCTION fruitsInsertFunc() 
RETURNS TRIGGER 
AS $create_fruit$
   BEGIN
      INSERT INTO fruitsInsert(id, title, price, description) 
      VALUES (new.id, new.title, new.price, new.description);
      RETURN new;
   END;
$create_fruit$ LANGUAGE plpgsql;

CREATE TRIGGER fruits_insert_trigger AFTER INSERT ON fruits
FOR EACH ROW EXECUTE PROCEDURE fruitsInsertFunc();
 
INSERT INTO fruits(title, price, description)
         VALUES ('peach', 10000, 'delicious'),
                  ('apple', '5000', 'delicious');


-- update fruits
CREATE TABLE updateFruits(
   id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
   old_title VARCHAR NOT NULL,
   new_title VARCHAR NOT NULL,
   price INT NOT NULL,
   description VARCHAR NOT NULL
);
 
CREATE OR REPLACE FUNCTION updateFruitsFunc() 
RETURNS TRIGGER 
AS $update_fruit$
   BEGIN
      INSERT INTO updateFruits(id, old_title, new_title, price, description) 
      VALUES (old.id, old.title, new.title, new.price, new.description);
      RETURN new;
   END;
$update_fruit$ LANGUAGE plpgsql;
 
CREATE TRIGGER fruits_update_trigger AFTER UPDATE ON fruits
FOR EACH ROW EXECUTE PROCEDURE updateFruitsFunc();

UPDATE fruits SET title = 'strawberry', price = 10000, description = 'delicious'
WHERE id = '70af0af2-4207-4f39-a8a5-b1be54065c64';


-- delete fruit
CREATE TABLE deleteFruit(
   id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
   title VARCHAR NOT NULL,
   price INT NOT NULL,
   description VARCHAR NOT NULL
);

CREATE OR REPLACE FUNCTION deleteFruitFunc() 
RETURNS TRIGGER 
AS $delete_fruit$
   BEGIN
      INSERT INTO deleteFruit(id, title, price, description) 
      VALUES (old.id, old.title, old.price, old.description);
      RETURN old;
   END;
$delete_fruit$ LANGUAGE plpgsql;

CREATE TRIGGER fruit_delete_trigger AFTER DELETE ON fruits
FOR EACH ROW EXECUTE PROCEDURE deleteFruitFunc(); 

DELETE FROM fruits WHERE id = '70af0af2-4207-4f39-a8a5-b1be54065c64';