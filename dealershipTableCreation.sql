-- Database creation --
CREATE DATABASE dealership;

-- Table Creation --
CREATE TABLE customer (
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	phone VARCHAR(22),
	email VARCHAR(255)
);

CREATE TABLE salesperson (
	salesperson_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);


CREATE TABLE mechanic (
	mechanic_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);
	
CREATE TABLE car (
	car_id SERIAL PRIMARY KEY, 
	make VARCHAR(150),
	model VARCHAR(150),
	YEAR INTEGER,
	price NUMERIC(8,2),
	car_condition VARCHAR(5),
	customer_id INTEGER,
	salesperson_id INTEGER,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id)
);


CREATE TABLE car_part (
	part_id SERIAL PRIMARY KEY,
	item_name VARCHAR(150),
	item_description VARCHAR(1000),
	price NUMERIC(5,2)
);
	

-- junction table to store many to many relationships

CREATE TABLE car_mechanic (
	car_mechanic_id SERIAL PRIMARY KEY,
	car_id INTEGER NOT NULL,
	mechanic_id INTEGER NOT NULL
);

-- mistakeningly didnt reference them as foreign keys
ALTER TABLE car_mechanic ALTER COLUMN car_id TYPE VARCHAR(50);
ALTER TABLE car_mechanic ADD CONSTRAINT car_mechanic_car_id_fkey FOREIGN KEY(car_id) REFERENCES car(car_id);

ALTER TABLE car_mechanic ALTER COLUMN car_id TYPE VARCHAR(50);
ALTER TABLE car_mechanic ADD CONSTRAINT car_mechanic_car_id_fkey FOREIGN KEY(car_id) REFERENCES car(car_id);



CREATE TABLE invoice (
	invoice_id SERIAL PRIMARY KEY,
	invoice_date DATE DEFAULT current_date,
	car_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	salesperson_id INTEGER NOT NULL,
	FOREIGN KEY(car_id) REFERENCES car(car_id),
	FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id)
);


CREATE TABLE service_ticket (
	ticket_id SERIAL PRIMARY KEY,
	service_date DATE DEFAULT current_date,
	service_descript VARCHAR(1000),
	car_id INTEGER NOT NULL, 
	customer_id INTEGER NOT NULL,
	mechanic_id INTEGER NOT NULL,
	part_id INTEGER, -- ALL cars dont need NEW parts 
	FOREIGN KEY(car_id) REFERENCES car(car_id),
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY(part_id) REFERENCES car_part(part_id)
);
	

-- junction table for mechanic and service tickets
CREATE TABLE mechanic_ticket (
	mechanic_ticket_id SERIAL PRIMARY KEY,
	mechanic_id INTEGER NOT NULL,
	ticket_id INTEGER NOT NULL,
	FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id),
	FOREIGN KEY(ticket_id) REFERENCES service_ticket(ticket_id)
);




	
	
	
	
	
	