INSERT INTO customer(
	customer_id,
	first_name,
	last_name,
	phone,
	email
)VALUES(
	1,
	'Kayla',
	'Jones',
	'707-302-4555',
	'kjones@gmail'
);
	
INSERT INTO customer (
	customer_id,
	first_name,
	last_name,
	phone,
	email
)VALUES(
	2,
	'Grace',
	'White',
	'702-899-0100',
	'gwhite@gmail.com'
);

INSERT INTO salesperson (
	salesperson_id,
	first_name,
	last_name
)VALUES(
	1,
	'Michael',
	'Pratt'
);

INSERT INTO salesperson (
	salesperson_id,
	first_name,
	last_name
)VALUES(
	2,
	'Oscar',
	'Williams'
);




INSERT INTO mechanic (
	mechanic_id,
	first_name,
	last_name
)VALUES(
	2,
	'Rose',
	'Brown'
);

INSERT INTO mechanic (
	mechanic_id,
	first_name,
	last_name
)VALUES(
	1,
	'Juicy',
	'Blue'
);


-- Car ID should have been varchar since I am using this car_id as a serial/VIN number
-- therefore I must alter the table, starting where car_id is used as foreign keys in other tables

ALTER TABLE invoice DROP CONSTRAINT invoice_car_id_fkey; -- removed constraints
ALTER TABLE invoice ALTER COLUMN car_id TYPE VARCHAR(50);
ALTER TABLE invoice ADD CONSTRAINT invoice_car_id_fkey FOREIGN KEY(car_id) REFERENCES car(car_id);


ALTER TABLE car_mechanic DROP CONSTRAINT car_mechanic_car_id_fkey;
ALTER TABLE car_mechanic ALTER COLUMN car_id TYPE VARCHAR(50);
ALTER TABLE car_mechanic ADD CONSTRAINT car_mechanic_car_id_fkey FOREIGN KEY(car_id) REFERENCES car(car_id);


ALTER TABLE service_ticket ALTER COLUMN car_id TYPE VARCHAR(50);
ALTER TABLE service_ticket ADD CONSTRAINT service_ticket_car_id_fkey FOREIGN KEY(car_id) REFERENCES car(car_id);


-- finally, changed data type inside of car table so I can add vin number
ALTER TABLE car ALTER COLUMN car_id TYPE VARCHAR(50);



-- now entering primary key car_id with letters and numbers)
INSERT INTO car (
	car_id,
	make,
	model,
	YEAR,
	price,
	car_condition,
	customer_id,
	salesperson_id
)VALUES(
	'4Y1SL65848Z411439',
	'Toyota',
	'Camry',
	1999,
	2499.99,
	'USED',
	1,
	1
);

INSERT INTO car (
	car_id,
	make,
	model,
	YEAR,
	price,
	car_condition,
	customer_id,
	salesperson_id
)VALUES(
	'2A5KL65233Z411123',
	'Ford',
	'Mustang',
	1997,
	7999.99,
	'NEW',
	2,
	2
);

-- Using a stored function to add car parts
CREATE OR REPLACE FUNCTION car_part(
	_part_id INTEGER, _item_name VARCHAR, _item_description VARCHAR, _price NUMERIC
	)
RETURNS void
AS $MAIN$
BEGIN 
		INSERT INTO car_part(part_id, item_name, item_description, price)
		VALUES(_part_id, _item_name, _item_description, _price);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT car_part(1, 'alternator', 'The alternator converts mechanical energy from the engine into electrical energy ensuring a steady supply for the vehicles electrical needs.', 500.00)
SELECT car_part(2, 'brake caliper', 'The brake caliper is part of the disc brake system and plays a key role in slowing down or stopping the vehicle', 250.89)




INSERT INTO car_mechanic (
	car_mechanic_id,
	car_id,
	mechanic_id
)VALUES(
	1,
	'4Y1SL65848Z411439',
	1
);


INSERT INTO car_mechanic (
	car_mechanic_id,
	car_id,
	mechanic_id
)VALUES(
	2,
	'2A5KL65233Z411123',
	2
);

INSERT INTO invoice (
	invoice_id,
	car_id,
	customer_id,
	salesperson_id
)VALUES(
	1,
	'2A5KL65233Z411123',
	2,
	1
);

INSERT INTO invoice (
	invoice_id,
	car_id,
	customer_id,
	salesperson_id
)VALUES(
	2,
	'4Y1SL65848Z411439',
	1,
	2
);
	
INSERT INTO service_ticket(
	ticket_id,
	service_descript,
	car_id,
	customer_id,
)VALUES(
	1, 
	'detail and deep clean',
	'2A5KL65233Z411123',	
	2,
);


INSERT INTO service_ticket(
	ticket_id,
	service_descript,
	car_id,
	customer_id,
	part_id
)VALUES(
	2, 
	'added and repaired breaks',
	'4Y1SL65848Z411439',
	1,
	2
);


INSERT INTO mechanic_ticket (
	mechanic_ticket_id,
	mechanic_id,
	ticket_id
)VALUES(
	1,
	1,
	2
);

INSERT INTO mechanic_ticket (
	mechanic_ticket_id,
	mechanic_id,
	ticket_id
)VALUES(
	2,
	2,
	1
);
	





