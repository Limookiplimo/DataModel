/*
SQL scripts to implement the designed data model. Created tables
can be populated.
*/

-- Employees
CREATE TABLE "public.employees" (
	"emp_id" serial NOT NULL,
	"first_name" varchar NOT NULL,
	"middle_name" varchar,
	"last_name" varchar NOT NULL,
	"age" integer NOT NULL,
	"gender" varchar,
	"phone" integer NOT NULL,
	"email" varchar,
	"job_title" varchar NOT NULL,
	"department" integer NOT NULL,
	"bank_account" varchar,
	"national_id" integer NOT NULL,
	"leave" integer NOT NULL,
	"hire_data" DATE NOT NULL,
	"emp_type" integer NOT NULL,
	"salary" FLOAT NOT NULL,
	"branch" integer NOT NULL,
	CONSTRAINT "employees_pk" PRIMARY KEY ("emp_id")
);


-- Departments
CREATE TABLE "public.departments" (
	"id" serial NOT NULL,
	"name" varchar NOT NULL DEFAULT '255',
	CONSTRAINT "departments_pk" PRIMARY KEY ("id")
);


-- Branch
CREATE TABLE "public.branch" (
	"id" serial NOT NULL,
	"name" varchar NOT NULL,
	"city" varchar NOT NULL,
	"longitude" varchar,
	"latitude" varchar,
	"street" varchar NOT NULL,
	CONSTRAINT "branch_pk" PRIMARY KEY ("id")
);


-- Leaves
CREATE TABLE "public.leaves" (
	"id" serial NOT NULL,
	"type" varchar NOT NULL,
	"days" integer NOT NULL,
	CONSTRAINT "leaves_pk" PRIMARY KEY ("id")
);


-- Employment types
CREATE TABLE "public.emp_types" (
	"id" serial NOT NULL,
	"name" integer NOT NULL,
	"duration" integer NOT NULL,
	"termination_date" DATE NOT NULL,
	CONSTRAINT "emp_types_pk" PRIMARY KEY ("id")
);


-- Sales
CREATE TABLE "public.sales" (
	"invoice_num" serial NOT NULL UNIQUE,
	"rep_id" integer NOT NULL,
	"invoice_date" DATE NOT NULL,
	"payment_method" varchar NOT NULL,
	"product_id" integer NOT NULL,
	"quantity" integer NOT NULL,
	"unit_price" integer NOT NULL,
	"invoice_amount" FLOAT NOT NULL,
	"route" varchar NOT NULL,
	"branch_id" integer NOT NULL,
	"discount" FLOAT,
	"payment_date" DATE NOT NULL,
	"customer_id" varchar NOT NULL,
	"invoice_status" varchar NOT NULL,
	"tax_amount" integer,
	"warehouse_id" integer NOT NULL,
	CONSTRAINT "sales_pk" PRIMARY KEY ("invoice_num")
);


-- Products
CREATE TABLE "public.products" (
	"id" serial NOT NULL,
	"name" varchar NOT NULL,
	"description" varchar,
	"UOM" varchar NOT NULL,
	"category" varchar NOT NULL,
	"price" FLOAT NOT NULL,
	"supplier" varchar NOT NULL,
	CONSTRAINT "products_pk" PRIMARY KEY ("id")
);


-- Payments
CREATE TABLE "public.payments" (
	"id" serial NOT NULL,
	"name" varchar NOT NULL,
	"terms" varchar NOT NULL,
	CONSTRAINT "payments_pk" PRIMARY KEY ("id")
);


-- Customers
CREATE TABLE "public.customers" (
	"id" serial NOT NULL,
	"name" varchar NOT NULL,
	"owner" varchar NOT NULL,
	"kra_pin" varchar,
	"route" varchar NOT NULL,
	"credit_limit" FLOAT NOT NULL,
	"pending_balance" integer NOT NULL,
	"phone" integer NOT NULL,
	"address" varchar NOT NULL,
	"gender" varchar,
	"communicatin_pref" varchar,
	CONSTRAINT "customers_pk" PRIMARY KEY ("id")
);


-- Warehouses
CREATE TABLE "public.warehouses" (
	"id" serial NOT NULL,
	"name" varchar NOT NULL,
	"branch" varchar NOT NULL,
	"address" varchar NOT NULL,
	CONSTRAINT "warehouses_pk" PRIMARY KEY ("id")
);


-- Routes
CREATE TABLE "public.routes" (
	"id" serial NOT NULL,
	"name" varchar NOT NULL,
	"county" varchar NOT NULL,
	CONSTRAINT "routes_pk" PRIMARY KEY ("id")
);


-- Date
CREATE TABLE "public.date" (
	"date" serial NOT NULL,
	"year" integer NOT NULL,
	"month" varchar NOT NULL,
	"date_month" integer NOT NULL,
	"day_week" varchar NOT NULL,
	"week" integer NOT NULL,
	CONSTRAINT "date_pk" PRIMARY KEY ("date")
);


-- Establish Relationships
/*
Create relationship between employees table with other correlated tables
*/
ALTER TABLE "employees" ADD CONSTRAINT "employees_fk0" FOREIGN KEY ("department") REFERENCES "departments"("id");
ALTER TABLE "employees" ADD CONSTRAINT "employees_fk1" FOREIGN KEY ("leave") REFERENCES "leaves"("id");
ALTER TABLE "employees" ADD CONSTRAINT "employees_fk2" FOREIGN KEY ("emp_type") REFERENCES "emp_types"("id");
ALTER TABLE "employees" ADD CONSTRAINT "employees_fk3" FOREIGN KEY ("branch") REFERENCES "branch"("id");


/*
Create relationship between sales table with other correlated tables
*/
ALTE
ALTER TABLE "sales" ADD CONSTRAINT "sales_fk0" FOREIGN KEY ("rep_id") REFERENCES "employees"("emp_id");
ALTER TABLE "sales" ADD CONSTRAINT "sales_fk1" FOREIGN KEY ("invoice_date") REFERENCES "date"("date");
ALTER TABLE "sales" ADD CONSTRAINT "sales_fk2" FOREIGN KEY ("payment_method") REFERENCES "payments"("id");
ALTER TABLE "sales" ADD CONSTRAINT "sales_fk3" FOREIGN KEY ("product_id") REFERENCES "products"("id");
ALTER TABLE "sales" ADD CONSTRAINT "sales_fk4" FOREIGN KEY ("route") REFERENCES "routes"("id");
ALTER TABLE "sales" ADD CONSTRAINT "sales_fk5" FOREIGN KEY ("branch_id") REFERENCES "branch"("id");
ALTER TABLE "sales" ADD CONSTRAINT "sales_fk6" FOREIGN KEY ("customer_id") REFERENCES "customers"("id");
ALTER TABLE "sales" ADD CONSTRAINT "sales_fk7" FOREIGN KEY ("warehouse_id") REFERENCES "warehouses"("id");


-- Create a relationship between warehouse and branch tables.
ALTER TABLE "warehouses" ADD CONSTRAINT "warehouses_fk0" FOREIGN KEY ("branch") REFERENCES "branch"("id");

