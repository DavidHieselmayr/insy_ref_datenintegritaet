# Deklarative Datenintegrität (not null, unique, primary key, index,
# define length, check, FOREIGN KEY, Delete, update, insert


# Entitätenintegrität
select *
from Customer;
DESCRIBE Customer;
drop table Customer;

# not null
create table Customer
(
    ID        int,
    LastName  varchar,
    FirstName varchar,
    Age       int
);

insert into Customer(ID, LastName, FirstName, Age)
VALUES (null, null, null, null);


# unique attribute (darf allerdings null sein, im Gegensatz zum Primary Key)
create table Customer
(
    ID        int unique,
    LastName  varchar,
    FirstName varchar,
    Age       int
);



insert into Customer(ID, LastName, FirstName, Age)
values (1, 'Hieselmayr', 'David', 1);
insert into Customer(ID, LastName, FirstName, Age)
values (1, 'Berger', 'David', 1);

# primary key
alter table Customer
    add primary key (ID);

# primary key composite key
alter table Customer
    add primary key (ID, LastName);

# remove primary key
alter table Customer
    drop PRIMARY KEY;

# create index
create index idx_lastname on Customer (LastName);



drop table Customer;
# primary key
create table Customer
(
    ID        int primary key auto_increment,
    LastName  varchar,
    FirstName varchar,
    Age       int
);

insert into Customer(LastName, FirstName, Age)
values ('Dieselmayr', 'David', 10);
insert into Customer(LastName, FirstName, Age)
values ('Benzinmayer', 'David', 21);
insert into Customer(LastName, FirstName, Age)
values ('Emayer', 'David', 22);


# Domänenintegrität

# define length
CREATE TABLE Person
(
    ID        int primary key auto_increment,
    LastName  varchar(2) NOT NULL,
    FirstName varchar(2),
    Age       int,
    City      varchar(255) DEFAULT 'Bad Hall'
);

describe Person;

insert into Person(LastName, FirstName, Age)
VALUES ('Gruber', 'Hans', 2);
insert into Person(LastName, FirstName, Age, City)
VALUES ('Gruber', 'Hans', 2, 'Steyr');

alter table Person
    modify FirstName varchar(50);
alter table Person
    modify LastName varchar(60);

# check constraint
drop table Person;
CREATE TABLE Person
(
    ID        int primary key auto_increment,
    LastName  varchar(60) NOT NULL,
    FirstName varchar(50),
    City      varchar(255) DEFAULT 'Bad Hall',
    Age       int,
    check ( Age >= 18)
);

insert into Person(LastName, FirstName, Age)
values ('Linsenmayr', 'David', 17);
insert into Person(LastName, FirstName, Age)
values ('Linsenmayr', 'David', 18);

select *
from Person;


#FOREIGN KEY
CREATE TABLE OrderPerson
(
    OrderPersonID  int         NOT NULL PRIMARY KEY,
    name     varchar(40) not null,
    personId Int,
    CONSTRAINT person_fk foreign key (personId) references Person (id)
);

describe OrderPerson;

select *
from Person;

insert into OrderPerson(OrderPersonID, name, personId)
values (1, 'LKW', 1);

select O.OrderPersonID, O.name, P.FirstName
from OrderPerson O
         left join Person P on O.personId = P.ID;



# Referentielle Integrität

# passt
DELETE
From OrderPerson
where OrderPersonID = 1;
select *
from OrderPerson;
insert into OrderPerson(OrderPersonID, name, personId)
values (1, 'LKW', 1);

# ALARM
DELETE
From Person
where ID = 1;
# GEHT
UPDATE Person
set FirstName='Wieselmayr'
where ID = 1;


# Prozedurale Datenintegrität (Views, Trigger und gespeicherte Prozeduren)

