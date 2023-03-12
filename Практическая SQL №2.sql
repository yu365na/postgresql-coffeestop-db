--DROP TABLE toppings_pos_order;
--DROP TABLE toppings;
--DROP TABLE position_order;
--DROP TABLE ingridients_coffee;
--DROP TABLE coffee;
--DROP TABLE ingridients;
--DROP TABLE "order";
--DROP TABLE employes;
--DROP TABLE post;

CREATE TABLE IF NOT EXISTS post
(
    id serial PRIMARY KEY NOT NULL,
    title varchar(50) NOT NULL,
	salary decimal(10,2) NOT NULL
);


CREATE TABLE IF NOT EXISTS employes 
(
    id serial PRIMARY KEY NOT NULL,
    name varchar(50) NOT NULL,
	firstname varchar(50) NOT NULL,
	patronymic varchar(50) NOT NULL,
	telephone varchar(16)  NOT NULL,
	date_birth date NOT NULL,
	post_ID integer NOT NULL REFERENCES post (id) 
	--внешний ключ, связь 1 к м, к таблице post
);

CREATE TABLE IF NOT EXISTS "order" 
(
    id serial PRIMARY KEY NOT NULL,
    registration timestamp NOT NULL,
	prise decimal(10,2) NOT NULL,
	status varchar(50) NOT NULL,
	ending timestamp NULL,
	emp_ID integer NOT NULL REFERENCES employes (id) 
	--внешний ключ, связь 1 к м, к таблице employes
);

CREATE TABLE IF NOT EXISTS ingridients
(
    id serial PRIMARY KEY NOT NULL,
    title varchar(50) NOT NULL,
	price decimal(10,2) NOT NULL,
	description text NULL
);

CREATE TABLE IF NOT EXISTS coffee
(
    id serial PRIMARY KEY NOT NULL,
    title varchar(50) NOT NULL,
	price decimal(10,2) NOT NULL,
	volume integer NOT NULL,
	description text NULL,
	recept text NOT NULL
);

CREATE TABLE IF NOT EXISTS ingridients_coffee
(
    id serial PRIMARY KEY NOT NULL,
	ing_ID integer NOT NULL REFERENCES ingridients(id),
	cof_ID integer NOT NULL REFERENCES coffee(id),
	volume_ing integer NOT NULL,
	volume_type varchar (10) NOT NULL,
	
	UNIQUE(ing_ID, cof_ID)
);

CREATE TABLE IF NOT EXISTS position_order
(
    id serial PRIMARY KEY NOT NULL,
	cof_ID integer NOT NULL REFERENCES coffee(id),
	ord_ID integer NOT NULL REFERENCES "order"(id),
	count_cof integer NOT NULL,
	
	UNIQUE(ing_ID, cof_ID)
);

CREATE TABLE IF NOT EXISTS toppings
(
    id serial PRIMARY KEY NOT NULL,
    title varchar(50) NOT NULL,
	price decimal(10,2) NOT NULL,
	description text NULL
);

CREATE TABLE IF NOT EXISTS toppings_pos_order
(
    id serial PRIMARY KEY NOT NULL,
	top_ID integer NOT NULL REFERENCES toppings(id),
	pos_ord_ID integer NOT NULL REFERENCES position_order(id),
	
	UNIQUE( top_ID , pos_ord_ID)
);

--Добавление данных в таблицу
INSERT INTO post (title,salary) VALUES
('бариста','50000'),
('мэнэджер', '60000'),
('Руководитель' ,'75000');

INSERT INTO employes (name, firstname, patronymic, telephone, date_birth, post_ID) VALUES
('Иван' ,'Иванович' ,'Иванов' ,'8(916)3801202', '17-03-1999', 2),
('Наталья' ,'Викторовна' ,'Сова' ,'8(916)3866202' ,'07-10-1969', 3),
('Юрий', 'Юрьевич' ,'Юрьев', '8(906)3807202', '13-03-1979', 1);

INSERT INTO "order" (registration , prise , status , ending , emp_ID) VALUES
('2023-01-08 00:00:01' , 990 ,'Завершён' ,'2023-01-08 00:30:09', 2),
('2022-11-08 15:13:01' , 990 ,'Завершён' ,'2022-11-08 15:13:01', 2),
('2023-01-18 00:00:01' , 990 ,'В процессе' ,NULL, 2);

INSERT INTO ingridients (title , price, description ) VALUES
('Молоко' , 99 ,'Молоко "НЕКислое" 4%'),
('Зерно робуста' , 450 ,'Зерна робуста для перемалывания'),
('Молочный шоколад' , 150 ,'Очень вкусный шоколад'),
('Молотый кофе' , 150 ,'Порошочек молотой арабики'),
('Вода' , 7 ,'Чистая вода из под крана');

INSERT INTO coffee (title , price , volume , description , recept) VALUES
('ла́тте' , 130 ,150 ,'Ла́тте — кофейный напиток, на основе молока, 
 представляющий собой трёхслойную смесь из пены, молока и кофе эспрессо. Был изобретён в Италии.', 
 'Подогрейте молоко, не давая ему закипеть и взбейте пену. Приготовьте порцию эспрессо традиционным способом и перелейте 
 её в кофейный стакан или керамическую чашку большого объема. Добавьте молоко. Тонкой струйкой влейте теплое молоко в кофе.'),

('эспрессо' , 100 ,20 ,'Эспре́ссо — метод приготовления кофе путём прохождения горячей воды под давлением через фильтр с молотым кофе.', 
 'От 7 до 9 граммов свежемолотого кофе засыпается в холдер, тщательно разравнивается и затем прессуется "Темпер" темпером так, чтобы
 молотый кофе сформировался в ровную таблетку. Затем через получившуюся таблетку под давлением 9 бар пропускается разогретая до температуры
 88—92 °C вода.'),

('фраппе́' , 180 ,150 ,NULL, 
 'Кофе фраппе готовится с помощью шейкера или миксера на основе одной или двух порций кофе, сахара и небольшого
 количества воды, которые взбиваются до образования пены. Напиток подается в стеклянном стакане с добавлением холодной воды, льда и молока. ');

INSERT INTO ingridients_coffee (ing_ID , cof_ID, volume_ing ,volume_type  ) VALUES
(1,1,100,'мл'),
(5,1,50,'грамм'),
(3,1,10,'грамм'),
(2,2,7,'грамм'),
(4,2,30,'мл');


INSERT INTO  position_order(cof_ID ,ord_ID ,count_cof) VALUES
(1,1,1),
(2,1,3),
(1,2,2),
(2,3,3);

INSERT INTO  toppings (title, price ,description ) VALUES
('Твердый шоколад' , 50 ,'Шоколадная крошка'),
('Карамельный сироп' , 45 ,'Карамельный сироп для кофе'),
('Ванильный сироп' , 45 ,'Ванильный сироп для кофе');

INSERT INTO  toppings_pos_order(top_ID ,pos_ord_ID ) VALUES
(1,1),
(2,1),
(2,2),
(1,4),
(3,4);

SELECT*FROM post;
SELECT*FROM employes;
SELECT*FROM "order";
SELECT*FROM ingridients;
SELECT*FROM coffee;
SELECT*FROM ingridients_coffee;
SELECT*FROM position_order;
SELECT*FROM toppings;
SELECT*FROM toppings_pos_order;
