DROP DATABASE IF EXISTS taverns_db;
CREATE DATABASE taverns_db;
USE taverns_db;
CREATE TABLE taverns
(
    tavern_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(250) NOT NULL,
    location_id INT NOT NULL,
    owner_id INT NOT NULL,
    floors_quantity INT NOT NULL,
    primary key(tavern_id)
);

INSERT INTO taverns(name,location_id, owner_id, floors_quantity)
VALUES ('Moe''s', 1, 1, 2), ('The Bada Bing!', 2, 2, 2), ('The Drunken Clam', 3, 3, 1), ('Paddy’s Pub', 4, 4, 3), ('The Peach Pit After Dark', 5, 5, 2);

CREATE TABLE roles
(
    role_id INT NOT NULL AUTO_INCREMENT,
    role_name VARCHAR(250) NOT NULL,
    description VARCHAR(3500) NOT NULL,
    primary key(role_id)
);

INSERT INTO roles(role_name, description) 
VALUES ('Owner', 'Be the boss, watch everything, manage employees, count money, get free drinks at the bar'), ('Bartender', 'Sell drinks, watch the counter, clean glasses and the bar stand'), ('Waitor', 'Make sure customers are satisfied, carry plates and drinks'), ('Busser', 'Clean the tables, wash the dishes, mop the floor'), ('Bodyguard', 'Kick people out if necessary'), ('Room manager', 'Check-ins, check-outs, room service and other services');

CREATE TABLE users
(
    user_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(250) NOT NULL,
    last_name VARCHAR(250) NOT NULL,
    role_id INT NOT NULL references roles(role_id),
    tavern_id INT NOT NULL references taverns(tavern_id),
    primary key(user_id)
);

INSERT INTO users(first_name,last_name,role_id,tavern_id)
VALUES ('Bilbo', 'Baggins', 1, 1),('Mr', 'Peanutbutter', 1, 2),('Gerald', 'The IIIrd', 1, 3), ('Emma', 'Watson', 1, 4), ('Rick', 'Sanchez', 1, 5), ('Robot', 'Beep-boop', 2, 1), ('Michael', 'Schoemacher', 3, 2), ('Jessica', 'Parker', 5,2), ('Andy', 'McGuier', 4, 3), ('Peter', 'Griffin', 3,4), ('Emily', 'Ma', 5,5), ('James', 'Blunt', 4,5);

ALTER TABLE taverns ADD FOREIGN KEY(owner_id) references users(user_id);

CREATE TABLE states 
(
    state_id INT NOT NULL AUTO_INCREMENT,
    state_name VARCHAR(100),
    primary key(state_id)
);

INSERT INTO states(state_name)
VALUES ('Alabama'),('Alaska'),('American Samoa'),('Arizona'),('Arkansas'),('California'),('Colorado'),('Connecticut'),('Delaware'),('District Of Columbia'),('Federated States Of Micronesia'),('Florida'),('Georgia'),('Guam'),('Hawaii'),('Idaho'),('Illinois'),('Indiana'),('Iowa'),('Kansas'),('Kentucky'),('Louisiana'),('Maine'),('Marshall Islands'),('Maryland'),('Massachusetts'),('Michigan'),('Minnesota'),('Mississippi'),('Missouri'),('Montana'),('Nebraska'),('Nevada'),('New Hampshire'),('New Jersey'),('New Mexico'),('New York'),('North Carolina'),('North Dakota'),('Northern Mariana Islands'),('Ohio'),('Oklahoma'),('Oregon'),('Palau'),('Pennsylvania'),('Puerto Rico'),('Rhode Island'),('South Carolina'),('South Dakota'),('Tennessee'),('Texas'),('Utah'),('Vermont'),('Virgin Islands'),('Virginia'),('Washington'),('West Virginia'),('Wisconsin'),('Wyoming');

CREATE TABLE locations
(
    location_id INT NOT NULL AUTO_INCREMENT,
    street_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state_id INT NOT NULL references states(state_id),
    primary key(location_id)
);

INSERT INTO locations(street_name,city,state_id)
VALUES ('4 Johnson Ln', 'Voorhees', 35), ('5 Evergreen Blvd', 'Boston', 26), ('1200 Marlton Pike E', 'Cherry Hill', 35), ('6000 Atrium Way', 'Gibbsboro twp', 12), ('1 Big Bunny cir', 'Los Angeles', 6), ('222 Freezing ave', 'Lumberton', 2);

ALTER TABLE taverns ADD FOREIGN KEY(location_id) references locations(location_id);


-- CREATE TABLE basement_rats
-- (
--     rat_id INT NOT NULL AUTO_INCREMENT,
--     tavern_id INT NOT NULL references taverns(tavern_id),
--     name VARCHAR(250) NOT NULL,
--     primary key(rat_id)
-- );

CREATE TABLE supplies
(
    supply_id INT NOT NULL AUTO_INCREMENT,
    supply_name VARCHAR(250) NOT NULL,
    retail_price DECIMAL(10,2),
    unit VARCHAR(20) NOT NULL,
    primary key(supply_id)
);

INSERT INTO supplies(supply_name, unit)
VALUES ('Corona', 'bottle(s)'), ('Golden Monkey', 'bottle(s)'), ('Tall Glass', 'piece(s)'), ('Metal sponge', 'case(s)'), ('Chair', 'pair(s)'), ('CO2', 'tank(s)'), ('Limes', 'lbs'), ('Absinth', 'oz'), ('Chicken', 'lbs');

CREATE TABLE inventory 
(
    inventory_id INT NOT NULL AUTO_INCREMENT,
    tavern_id INT NOT NULL references taverns(tavern_id),
    supply_id INT NOT NULL references supplies(supply_id),
    current_count INT NOT NULL,
    date_updated DATE,
    primary key(inventory_id)
);

INSERT INTO inventory(tavern_id, supply_id, current_count)
VALUES (1, 1, 49), (2, 2, 23), (3, 3, 100), (4, 4, 35), (5, 6, 53);

CREATE TABLE shipments
(
    shipment_id INT NOT NULL AUTO_INCREMENT,
    tavern_id INT NOT NULL references taverns(tavern_id),
    supply_id INT NOT NULL references supplies(supply_id),
    amt_received INT NOT NULL,
    date_of_shipping DATE,
    primary key(shipment_id)
);

INSERT INTO shipments(tavern_id, supply_id, amt_received, date_of_shipping)
VALUES (1, 1, 10, '2020-02-04'), (2,3,30, '2020-02-03'), (3, 4,15, '2020-02-03'), (4, 6, 2, '2020-02-05'), (5, 7, 1, '2020-02-01');

CREATE TABLE service_status
(
    status_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(250),
    primary key(status_id)
);

CREATE TABLE services
(
    service_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(250),
    retail_price DECIMAL(10,2),
    status_id INT NOT NULL references service_status(status_id),
    date_of_status_update DATE,
    primary key(service_id)
);

CREATE TABLE supply_trans_link
(
    supply_sale_id INT NOT NULL AUTO_INCREMENT,
    supply_id INT NOT NULL references supplies(supply_id),
    guest_id INT NOT NULL references guests(guest_id),
    tavern_id INT NOT NULL references taverns(tavern_id),
    primary key(supply_sale_id)
);

CREATE TABLE service_trans_link
(
    service_sale_id INT NOT NULL AUTO_INCREMENT,
    service_id INT NOT NULL references services(service_id),
    guest_id INT NOT NULL references guests(guest_id),
    tavern_id INT NOT NULL references taverns(tavern_id),
    primary key(service_sale_id)
);

CREATE TABLE service_sales
(
    sale_id INT NOT NULL AUTO_INCREMENT,
    tavern_id INT NOT NULL references taverns(tavern_id),
    service_id INT NOT NULL references services(service_id),
    guest_id INT NOT NULL references users(user_id),
    primary key(sale_id)
);

CREATE TABLE supply_sales
(
    sale_id INT NOT NULL AUTO_INCREMENT,
    tavern_id INT NOT NULL references taverns(tavern_id),
    supply_id INT NOT NULL references supplies(supply_id),
    guest_id INT NOT NULL references users(user_id),
    price DECIMAL(10,2),
    amount INT NOT NULL,
    date_of_purchase DATE,
    primary key(sale_id)
);

CREATE TABLE guest_notes
(
    note_id INT NOT NULL AUTO_INCREMENT,
    guest_id INT NOT NULL,
    note_text VARCHAR(3500)
    note_date DATE,
    primary key(note_id)
)

CREATE TABLE guests
(
    guest_id INT NOT NULL AUTO_INCREMENT,
    gst_first_name VARCHAR(250),
    gst_last_name VARCHAR(250),
    gst_birthday DATE,
    gst_cakeday DATE,
    gst_status_id INT NOT NULL,
    primary key(guest_id)
);

ALTER TABLE guest_notes ADD FOREIGN KEY(guest_id) references gusets(guest_id);

CREATE TABLE class_names
(
    class_name_id INT NOT NULL AUTO_INCREMENT,
    class_name_name VARCHAR(250),
    primary key(class_name_id)
);

INSERT INTO class_names(class_name_name)
VALUES ('Mage', 'Fighter', 'Witcher', 'Human', 'Ghost', 'Zombie', 'ManBearPig')

CREATE TABLE gst_statuses
(
    gst_status_id INT NOT NULL AUTO_INCREMENT,
    gst_status_name VARCHAR(250),
    primary key(gst_status_id)
);

INSERT INTO gst_statuses(gst_status_name)
VALUES ('sick', 'fine', 'angry', 'hungry', 'raging', 'placid', 'happy', 'drunk');

ALTER TABLE guests ADD FOREIGN KEY(gst_status_id) references gst_statuses(gst_status_id);

CREATE TABLE guest_class_link
(
    link_id INT NOT NULL AUTO_INCREMENT,
    guest_id INT NOT NULL references guests(guest_id),
    level INT NOT NULL,
    class_name_id VARCHAR(250) references class_names(class_name_id),
    primary key(link_id)
);
