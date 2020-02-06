DROP DATABASE IF EXISTS taverns_db;
CREATE DATABASE taverns_db;
USE taverns_db;
CREATE TABLE taverns
(
    tavern_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(250) NOT NULL,
    location_id INT NOT NULL references locations(location_id),
    owner_id INT NOT NULL references users(user_id),
    floors_quantity INT NOT NULL,
    primary key(tavern_id)
);

CREATE TABLE users
(
    user_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(250) NOT NULL,
    last_name VARCHAR(250) NOT NULL,
    role_id INT NOT NULL references roles(role_id),
    tavern_id INT NOT NULL references taverns(tavern_id),
    primary key(user_id)
);

CREATE TABLE roles
(
    role_id INT NOT NULL AUTO_INCREMENT,
    role_name VARCHAR(250) NOT NULL,
    description VARCHAR(21844) NOT NULL,
    primary key(role_id)
);

CREATE TABLE locations
(
    location_id INT NOT NULL AUTO_INCREMENT,
    street_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state_id BIT NOT NULL references states(state_id),
    primary key(location_id)
);

CREATE TABLE states 
(
    state_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(20),
    primary key(state_id)
);

CREATE TABLE basement_rats
(
    rat_id INT NOT NULL AUTO_INCREMENT,
    tavern_id INT NOT NULL references taverns(tavern_id),
    name VARCHAR(250) NOT NULL,
    primary key(rat_id)
);

CREATE TABLE supplies
(
    supply_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(250) NOT NULL,
    unit VARCHAR(20) NOT NULL,
    primary key(supply_id)
);

CREATE TABLE inventory 
(
    inventory_id INT NOT NULL AUTO_INCREMENT,
    tavern_id INT NOT NULL references taverns(tavern_id),
    supply_id INT NOT NULL references supplies(supply_id),
    current_count INT NOT NULL,
    date_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    primary key(inventory_id)
);

CREATE TABLE shipments
(
    shipment_id INT NOT NULL AUTO_INCREMENT,
    tavern_id INT NOT NULL references taverns(tavern_id),
    supply_id INT NOT NULL references supplies(supply_id),
    amt_received INT NOT NULL,
    date_of_shipping TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    primary key(shipment_id)
);

CREATE TABLE services
(
    service_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(250),
    status_id BIT NOT NULL references service_status(status_id),
    date_of_status_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    primary key(service_id)
);

CREATE TABLE service_status
(
    status_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(250),
    primary key(status_id)
);

CREATE TABLE sales
(
    sale_id INT NOT NULL AUTO_INCREMENT,
    tavern_id INT NOT NULL references taverns(tavern_id),
    service_id INT NOT NULL references services(service_id),
    guest_id INT NOT NULL references users(user_id),
    price DECIMAL(10,2),
    amount INT NOT NULL,
    date_of_purchase TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    primary key(sale_id)
);
