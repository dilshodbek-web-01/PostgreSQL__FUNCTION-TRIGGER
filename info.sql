array_agg
jsonb_agg
jsonb_build_object

FUNCTION

CREATE OR REPLACE FUNCTION getUserInfo(user_name TEXT)
RETURNS TEXT
LANGUAGE plpgsql
AS
$$
DECLARE 
    result TEXT;

BEGIN
 
  RETURN 'Assalomu Alaykum ' || username;
END
$$;


CREATE OR REPLACE FUNCTION getUserInfo2(user_name TEXT, age INT)
RETURNS INT
LANGUAGE plpgsql
AS
$$
DECLARE 
    result TEXT;

BEGIN
  IF
     age > 15
  THEN
     result = 'Assalomu Alaykum ' || user_name || ' Akam!' ;
  ELSIF
      age = 0
  THEN
     result = user_name;
  ELSE 
     result = 'Assalomu Alaykum ' || user_name || ' ukam!';
  END IF;
  RETURN age;
END
$$;


CREATE OR REPLACE FUNCTION getUserInfo(user_name TEXT, age INT)
RETURNS TEXT
LANGUAGE plpgsql
AS
$$
DECLARE 
    result TEXT;
    a INT;
    b INT;
    c INT;

BEGIN
  IF
     age > 15
  THEN
     result = 'Hello brat!';
  ELSIF
      age = 0
  THEN
     result = '0';
  ELSE 
     result = 'Hello bratishka!';
  END IF;
  RETURN result;
END
$$;


DROP FUNCTION getUserInfo();


select getUserInfo('Muhammadali', 21);



array_agg
SELECT
users.age,
    ARRAY_AGG (
        email || ' ' || password
    ) user_info
FROM
    users
     group by 
     email,
     password,
     age;


jsonb_agg
select 
   jsonb_agg(email)
  from users where user_id in (2, 3, 4, 5);


  jsonb_build_object
  select 
    jsonb_build_object('name', username, 'user_email', email)
     from users;



