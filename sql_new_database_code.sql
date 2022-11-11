CREATE TABLE "customer" (
  "customer_id" SERIAL,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50),
  "address" VARCHAR(100),
  "email" VARCHAR(100),
  "phone_number" VARCHAR(50),
  "billing_info" VARCHAR(100),
  PRIMARY KEY ("customer_id")
);

CREATE TABLE "parts" (
  "parts_id" SERIAL,
  "item_name" VARCHAR(50),
  "cost" NUMERIC(8,2),
  PRIMARY KEY ("parts_id")
);

CREATE TABLE "service" (
  "service_id" SERIAL,
  "service_type" VARCHAR(50),
  "parts_id" INTEGER,
  "amount" NUMERIC(8,2),
  "date" DATE,
  "mechanic_id" INTEGER,
  PRIMARY KEY ("service_id"),
  CONSTRAINT "FK_service.parts_id"
    FOREIGN KEY ("parts_id")
      REFERENCES "parts"("parts_id")
);

CREATE TABLE "salesperson" (
  "salesperson_id" SERIAL,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50),
  "car_id" INTEGER,
  PRIMARY KEY ("salesperson_id")
);

CREATE TABLE "car" (
  "car_id" SERIAL,
  "customer_id" INTEGER,
  "make" VARCHAR(25),
  "model" VARCHAR(25),
  "year" INTEGER,
  PRIMARY KEY ("car_id"),
  CONSTRAINT "FK_car.car_id"
    FOREIGN KEY ("car_id")
      REFERENCES "salesperson"("car_id")
);

CREATE TABLE "invoice" (
  "invoice_id" SERIAL,
  "customer_id" INTEGER,
  "service_id" INTEGER,
  "total_amount" NUMERIC(8,2),
  "date" DATE,
  "tax" NUMERIC(8,2),
  "sales_id" INTEGER,
  PRIMARY KEY ("invoice_id"),
  CONSTRAINT "FK_invoice.customer_id"
    FOREIGN KEY ("customer_id")
      REFERENCES "customer"("customer_id")
);

CREATE TABLE "mechanic" (
  "mechanic_id" SERIAL,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50),
  "car_id" INTEGER,
  PRIMARY KEY ("mechanic_id")
);

CREATE TABLE "sales" (
  "sales_id" SERIAL,
  "amount" NUMERIC(8,2),
  "date" DATE,
  "salesperson" INTEGER,
  PRIMARY KEY ("sales_id"),
  CONSTRAINT "FK_sales.salesperson"
    FOREIGN KEY ("salesperson")
      REFERENCES "salesperson"("salesperson_id")
);

CREATE FUNCTION add_customer(
	_customer_id NUMERIC,
	_first_name VARCHAR(50),
	_last_name VARCHAR(50),
	address_ VARCHAR(150),
	email_ VARCHAR(100),
	_phone_number VARCHAR(50),
	_billing_info VARCHAR(50)
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO customer(customer_id, first_name, last_name, address, email, phone_number, billing_info)
	VALUES(_customer_id, _first_name, _last_name, address_, email_, _phone_number, _billing_info);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_customer(
	1,
	'Old',
	'Greg',
	'1234 cave',
	'oldgreg@greg.com',
	'123-456-7890',
	'1234-1234-1234-1234'
);

SELECT add_customer(
	2,
	'New',
	'Greg',
	'1234 cave',
	'newgreg@greg.com',
	'098-765-4321',
	'4321-4321-4321-4321'
);

SELECT *
FROM customer;

CREATE FUNCTION add_parts(
	_parts_id NUMERIC,
	_item_name VARCHAR(100),
	cost_ NUMERIC(8,2)
)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO parts(parts_id, item_name, cost)
	VALUES(_parts_id, _item_name, cost_);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_parts(
	1,
	'exhaust',
	300.00
);

SELECT add_parts(
	2,
	'tires',
	250.00
);

SELECT *
FROM parts;