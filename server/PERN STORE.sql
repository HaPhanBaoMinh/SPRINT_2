CREATE TYPE "payment" AS ENUM (
  'PAYSTACK',
  'STRIPE'
);

CREATE TABLE "cart" (
  "id" integer PRIMARY KEY NOT NULL,
  "user_id" integer
);

CREATE TABLE "cart_item" (
  "id" integer PRIMARY KEY NOT NULL,
  "cart_id" integer NOT NULL,
  "product_id" integer NOT NULL,
  "quantity" integer NOT NULL
);

CREATE TABLE "order_item" (
  "id" integer PRIMARY KEY NOT NULL,
  "order_id" integer NOT NULL,
  "product_id" integer NOT NULL,
  "quantity" integer NOT NULL
);

CREATE TABLE "orders" (
  "order_id" integer PRIMARY KEY NOT NULL,
  "user_id" integer NOT NULL,
  "status" VARCHAR(20) NOT NULL,
  "date" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "amount" real,
  "total" integer,
  "ref" VARCHAR(100),
  "payment_method" VARCHAR(100)
);

CREATE TABLE "products" (
  "product_id" integer PRIMARY KEY NOT NULL,
  "name" VARCHAR(100) NOT NULL,
  "slug" VARCHAR(100) NOT NULL,
  "price" real NOT NULL,
  "description" text NOT NULL,
  "image_url" VARCHAR
);

CREATE TABLE "resetTokens" (
  "id" integer PRIMARY KEY NOT NULL,
  "email" VARCHAR NOT NULL,
  "token" VARCHAR NOT NULL,
  "used" boolean NOT NULL,
  "expiration" timestamp
);

CREATE TABLE "reviews" (
  "product_id" integer NOT NULL,
  "user_id" integer NOT NULL,
  "content" text NOT NULL,
  "rating" integer NOT NULL,
  "date" date NOT NULL DEFAULT CURRENT_DATE,
  "id" SERIAL NOT NULL,
  PRIMARY KEY ("user_id", "product_id")
);

CREATE TABLE "users" (
  "user_id" integer PRIMARY KEY NOT NULL,
  "password" VARCHAR(200),
  "email" VARCHAR(100) NOT NULL,
  "fullname" VARCHAR(100) NOT NULL,
  "username" VARCHAR(50) NOT NULL,
  "google_id" VARCHAR(100),
  "roles" VARCHAR[] NOT NULL DEFAULT '{customer}',
  "address" VARCHAR(200),
  "city" VARCHAR(100),
  "state" VARCHAR(100),
  "country" VARCHAR(100),
  "created_at" timestamp DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE "cart" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "cart_item" ADD FOREIGN KEY ("cart_id") REFERENCES "cart" ("id");

ALTER TABLE "cart_item" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("product_id");

ALTER TABLE "order_item" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("order_id");

ALTER TABLE "order_item" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("product_id");

ALTER TABLE "orders" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");

ALTER TABLE "reviews" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("product_id");

ALTER TABLE "reviews" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("user_id");
