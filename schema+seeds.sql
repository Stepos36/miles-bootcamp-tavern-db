CREATE TABLE taverns
(
    tavern_id INT NOT NULL IDENTITY(1,1),
    name VARCHAR(250) NOT NULL,
    location_id INT NOT NULL,
    owner_id INT NOT NULL,
    floors_quantity INT NOT NULL,
    primary key(tavern_id)
);

INSERT INTO taverns(name, location_id, owner_id, floors_quantity)
VALUES ('Moe''s', 1, 1, 2), 
('The Bada Bing!', 2, 2, 2), 
('The Drunken Clam', 3, 3, 1), 
('Paddy’s Pub', 4, 4, 3), 
('The Peach Pit After Dark', 5, 5, 2);

CREATE TABLE roles
(
    role_id INT NOT NULL IDENTITY(1,1),
    role_name VARCHAR(250) NOT NULL,
    description VARCHAR(3500) NOT NULL,
    primary key(role_id)
);

INSERT INTO roles(role_name, description) 
VALUES 
('Owner', 'Be the boss, watch everything, manage employees, count money, get free drinks at the bar'), 
('Bartender', 'Sell drinks, watch the counter, clean glasses and the bar stand'), 
('Waitor', 'Make sure customers are satisfied, carry plates and drinks'), 
('Busser', 'Clean the tables, wash the dishes, mop the floor'), 
('Bodyguard', 'Kick people out if necessary'), 
('Room manager', 'Check-ins, check-outs, room service and other services');

CREATE TABLE users
(
    user_id INT NOT NULL IDENTITY(1,1),
    first_name VARCHAR(250) NOT NULL,
    last_name VARCHAR(250) NOT NULL,
    role_id INT NOT NULL references roles(role_id),
    tavern_id INT NOT NULL references taverns(tavern_id),
    primary key(user_id)
);

INSERT INTO users(first_name,last_name,role_id,tavern_id)
VALUES 
('Bilbo', 'Baggins', 1, 1),
('Mr', 'Peanutbutter', 1, 2),
('Gerald', 'The IIIrd', 1, 3), 
('Emma', 'Watson', 1, 4), 
('Rick', 'Sanchez', 1, 5), 
('Robot', 'Beep-boop', 2, 1), 
('Michael', 'Schoemacher', 3, 2), 
('Jessica', 'Parker', 5,2), 
('Andy', 'McGuier', 4, 3), 
('Peter', 'Griffin', 3,4), 
('Emily', 'Ma', 5,5), 
('James', 'Blunt', 4,5);

ALTER TABLE taverns ADD FOREIGN KEY(owner_id) references users(user_id);

CREATE TABLE states 
(
    state_id INT NOT NULL IDENTITY(1,1),
    state_name VARCHAR(100),
    primary key(state_id)
);

INSERT INTO states(state_name)
VALUES ('Alabama'),
('Alaska'),
('American Samoa'),
('Arizona'),
('Arkansas'),
('California'),
('Colorado'),
('Connecticut'),
('Delaware'),
('District Of Columbia'),
('Federated States Of Micronesia'),
('Florida'),
('Georgia'),
('Guam'),
('Hawaii'),
('Idaho'),
('Illinois'),
('Indiana'),
('Iowa'),
('Kansas'),
('Kentucky'),
('Louisiana'),
('Maine'),
('Marshall Islands'),
('Maryland'),
('Massachusetts'),
('Michigan'),
('Minnesota'),
('Mississippi'),
('Missouri'),
('Montana'),
('Nebraska'),
('Nevada'),
('New Hampshire'),
('New Jersey'),
('New Mexico'),
('New York'),
('North Carolina'),
('North Dakota'),
('Northern Mariana Islands'),
('Ohio'),
('Oklahoma'),
('Oregon'),
('Palau'),
('Pennsylvania'),
('Puerto Rico'),
('Rhode Island'),
('South Carolina'),
('South Dakota'),
('Tennessee'),
('Texas'),
('Utah'),
('Vermont'),
('Virgin Islands'),
('Virginia'),
('Washington'),
('West Virginia'),
('Wisconsin'),
('Wyoming');

CREATE TABLE locations
(
    location_id INT NOT NULL IDENTITY(1,1),
    street_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state_id INT NOT NULL references states(state_id),
    primary key(location_id)
);

INSERT INTO locations(street_name,city,state_id)
VALUES 
('4 Johnson Ln', 'Voorhees', 35),
('5 Evergreen Blvd', 'Boston', 26),
('1200 Marlton Pike E', 'Cherry Hill', 35),
('6000 Atrium Way', 'Gibbsboro twp', 12),
('1 Big Bunny cir', 'Los Angeles', 6),
('222 Freezing ave', 'Lumberton', 2);

ALTER TABLE taverns ADD FOREIGN KEY(location_id) references locations(location_id);


-- CREATE TABLE basement_rats
-- (
--     rat_id INT NOT NULL IDENTITY(1,1),
--     tavern_id INT NOT NULL references taverns(tavern_id),
--     name VARCHAR(250) NOT NULL,
--     primary key(rat_id)
-- );

CREATE TABLE supplies
(
    supply_id INT NOT NULL IDENTITY(1,1),
    supply_name VARCHAR(250) NOT NULL,
    retail_price DECIMAL(10,2),
    unit VARCHAR(20) NOT NULL,
    primary key(supply_id)
);

INSERT INTO supplies(supply_name, unit, retail_price)
VALUES 
('Corona', 'bottle(s)', 7.10), 
('Golden Monkey', 'bottle(s)', 8.50), 
('Tall Glass', 'piece(s)', 5.50), 
('Metal sponge', 'case(s)', 2.30), 
('Chair', 'pair(s)', 20.55), 
('CO2', 'tank(s)', 92.40), 
('Limes', 'lbs', 7.30), 
('Absinth', 'oz', 4.20), 
('Chicken', 'lbs', 7.50);

CREATE TABLE inventory 
(
    inventory_id INT NOT NULL IDENTITY(1,1),
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
    shipment_id INT NOT NULL IDENTITY(1,1),
    tavern_id INT NOT NULL references taverns(tavern_id),
    supply_id INT NOT NULL references supplies(supply_id),
    amt_received INT NOT NULL,
    date_of_shipping DATE,
    primary key(shipment_id)
);

INSERT INTO shipments(tavern_id, supply_id, amt_received, date_of_shipping)
VALUES 
(1, 1, 10, '2020-02-04'), 
(2,3,30, '2020-02-03'), 
(3, 4,15, '2020-02-03'), 
(4, 6, 2, '2020-02-05'), 
(5, 7, 1, '2020-02-01');

CREATE TABLE service_status
(
    status_id INT NOT NULL IDENTITY(1,1),
    name VARCHAR(250),
    primary key(status_id)
);

INSERT INTO service_status(name)
VALUES
('available'),
('not available');

CREATE TABLE services
(
    service_id INT NOT NULL IDENTITY(1,1),
    name VARCHAR(250),
    retail_price DECIMAL(10,2),
    status_id INT NOT NULL references service_status(status_id),
    date_of_status_update DATE,
    primary key(service_id)
);

INSERT INTO services(name, retail_price, status_id, date_of_status_update)
VALUES 
('30 min. massage',60.00,1,'02/10/2020'),
('60 min. massage',120.00,1,'02/10/2020'),
('pedicure',30.00,2,'02/11/2020'),
('oxygen mask',75.99,1,'02/04/2020'),
('shoe cleanse',5.50,2,'02/10/2020');

CREATE TABLE guests
(
    guest_id INT NOT NULL IDENTITY(1,1),
    gst_first_name VARCHAR(250),
    gst_last_name VARCHAR(250),
    gst_birthday DATE,
    gst_cakeday DATE,
    gst_status_id INT,
    primary key(guest_id)
);

INSERT INTO guests(gst_first_name,gst_last_name,gst_birthday,gst_cakeday)
VALUES 
('John', 'Wick', '04/15/1966', '10/22/2004'),
('Mike', 'Tyson', '01/31/1970', '5/30/2010'),
('Alyx', 'Freeman', '01/31/1989', '7/05/2010'),
('Elvis', 'The Great', '10/12/1999', '4/20/2000'),
('Margo', 'Martindale', '11/02/2004', '6/23/2005');

CREATE TABLE supply_trans_link
(
    supply_sale_id INT NOT NULL IDENTITY(1,1),
    supply_id INT NOT NULL references supplies(supply_id),
    guest_id INT NOT NULL references guests(guest_id),
    tavern_id INT NOT NULL references taverns(tavern_id),
    primary key(supply_sale_id)
);

CREATE TABLE service_trans_link
(
    service_sale_id INT NOT NULL IDENTITY(1,1),
    service_id INT NOT NULL references services(service_id),
    guest_id INT NOT NULL references guests(guest_id),
    tavern_id INT NOT NULL references taverns(tavern_id),
    primary key(service_sale_id)
);

CREATE TABLE service_sales
(
    sale_id INT NOT NULL IDENTITY(1,1),
    tavern_id INT NOT NULL references taverns(tavern_id),
    service_id INT NOT NULL references services(service_id),
    guest_id INT NOT NULL references users(user_id),
    primary key(sale_id)
);

CREATE TABLE supply_sales
(
    sale_id INT NOT NULL IDENTITY(1,1),
    tavern_id INT NOT NULL references taverns(tavern_id),
    supply_id INT NOT NULL references supplies(supply_id),
    guest_id INT NOT NULL references users(user_id),
    amount INT NOT NULL,
    total DECIMAL(10,2),
    date_of_purchase DATE,
    primary key(sale_id)
);

INSERT INTO supply_sales(tavern_id, supply_id, guest_id, amount, total, date_of_purchase)
VALUES
(1,1,1,10,71.00,'2020-02-10'),
(2,2,2,5,42.50,'2020-02-06'),
(3,3,3,15,82.50,'2020-02-01'),
(4,4,4,20,46.00,'2020-02-11'),
(5,5,2,2,41.10,'2020-02-11'),
(2,7,2,2,14.60,'2020-02-11'),
(2,7,2,10,73.00,'2020-02-11'),
(2,7,2,10,73.00,'2020-02-12'),
(5,8,4,5,21.00,'2020-02-07'),
(4,1,5,20,142.00,'2020-02-08'),
(1,2,3,10,85.00,'2020-02-02'),
(4,1,3,9,76.50,'2020-02-03');

CREATE TABLE guest_notes
(
    note_id INT NOT NULL IDENTITY(1,1),
    guest_id INT NOT NULL,
    note_text VARCHAR(3500),
    note_date DATE,
    primary key(note_id)
)
GO
ALTER TABLE guest_notes ADD FOREIGN KEY(guest_id) references guests(guest_id);

CREATE TABLE class_names
(
    class_name_id INT NOT NULL IDENTITY(1,1),
    class_name_name VARCHAR(250),
    primary key(class_name_id)
);


INSERT INTO class_names(class_name_name)
VALUES 
    ('Mage'), 
    ('Fighter'), 
    ('Witcher'), 
    ('Human'), 
    ('Ghost'), 
    ('Zombie'), 
    ('ManBearPig');

CREATE TABLE gst_statuses
(
    gst_status_id INT NOT NULL IDENTITY(1,1),
    gst_status_name VARCHAR(250),
    primary key(gst_status_id)
);

INSERT INTO gst_statuses(gst_status_name)
VALUES 
    ('sick'), 
    ('fine'), 
    ('angry'), 
    ('hungry'), 
    ('raging'), 
    ('placid'), 
    ('happy'), 
    ('drunk');

ALTER TABLE guests ADD FOREIGN KEY(gst_status_id) references gst_statuses(gst_status_id);

CREATE TABLE guest_class_link
(
    link_id INT NOT NULL IDENTITY(1,1),
    guest_id INT NOT NULL references guests(guest_id),
    level INT NOT NULL,
    class_name_id INT references class_names(class_name_id),
    primary key(link_id)
);

INSERT INTO guest_class_link(guest_id, level, class_name_id)
VALUES 
(1,20,1),
(2,30,4),
(3,3,3),
(4,15,6),
(5,100,7),
(1,2,6),
(2,10,3),
(3,11,2),
(4,80,4);

CREATE TABLE rooms
(
    room_unique_num INT NOT NULL IDENTITY(1,1),
    tavern_room_name VARCHAR(100) NOT NULL,
    status_available BOOLEAN,
    status_clean BOOLEAN,
    cost_per_night DECIMAL(10,2),
    primary key(room_unique_num)
)

INSERT INTO rooms(tavern_room_name, status_available, status_clean, cost_per_night) 
VALUES
('Presidential Lux', 1, 1, 1000.00),
('Penthouse', 1, 0, 450.99),
('Room 100', 1, 1, 60.00),
('Room 101', 1, 1, 60.00),
('Room 102', 1, 1, 60.00),
('Room 300', 1, 1, 60.00),
('Room 400', 1, 1, 60.00),
('Room 404', 0, 0, 60.00),
('Room 500', 1, 1, 60.00),
('Rooftop loft', 1, 0, 357.99),

CREATE TABLE room_link_table
(
    room_link_id INT NOT NULL IDENTITY(1,1),
    room_unique_num INT NOT NULL references rooms(room_unique_num),
    tavern_id INT NOT NULL references taverns(tavern_id),
    service_sale_id INT NOT NULL references service_sales(sale_id),
    date_in DATE,
    date_out DATE,
    rate DECIMAL(10,2),
    primary key(room_link_id)
)

