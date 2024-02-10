-- Курсовой проектa
DROP DATABASE IF EXISTS company;
CREATE DATABASE IF NOT EXISTS company;
USE company;

/* 			****************** Раздел проектов компании ******************	       */

DROP TABLE IF EXISTS projects;								-- Таблица проектов компании
CREATE TABLE IF NOT EXISTS projects (
project_id SERIAL PRIMARY KEY,					-- id проекта
project_name VARCHAR(250) NOT NULL,				-- название проекта
head_of_the_project VARCHAR(250) NOT NULL,		-- Руководитель проекта, его имени в данной БД нет, поэтому выполняю через VARCHAR
info VARCHAR(250) DEFAULT NULL					-- Дополнительная информация
);


/* 			****************** Раздел штата компании ******************	       */

DROP TABLE IF EXISTS odop;									-- Таблица, содержащая список сотрудников ОДОП
CREATE TABLE IF NOT EXISTS odop (
dispatcher_id SERIAL PRIMARY KEY,				-- id диспетчера, уникальное
date_of_hire DATETIME NOT NULL DEFAULT NOW(),	-- Дата найма оператора на работу. Хотел написать DEFAULT CURRENT_DATE(), но выдает ошибку
name VARCHAR(250) NOT NULL,						-- Имя диспетчера
surname VARCHAR(250) NOT NULL,					-- Фамилия диспетчера
patronymic VARCHAR(250),						-- Отчество диспетчера, может быть Null
birthday DATE NOT NULL,							-- Дата рождения диспетчера
current_status ENUM('work', 'fired', 'training', 'vacation', 'downtime') NOT NULL DEFAULT 'work',	-- Текущий статус - работает, уволен, проходит обучение, отпуск, простой
info VARCHAR(250) DEFAULT NULL,					-- Дополнительная информация

UNIQUE INDEX odop_people(name, surname, patronymic, birthday)	-- Проверка на то, что бы не добавили одного и того же диспетчера несколько раз
);


DROP TABLE IF EXISTS operators;								-- Таблица, содержащая список операторов - штат компании
CREATE TABLE IF NOT EXISTS operators (
operator_id SERIAL PRIMARY KEY,					-- id оператора, уникальное
date_of_hire DATETIME NOT NULL DEFAULT NOW(),	-- Дата найма оператора на работу. Хотел написать DEFAULT CURRENT_DATE(), но выдает ошибку
name VARCHAR(250) NOT NULL,						-- Имя оператора
surname VARCHAR(250) NOT NULL,					-- Фамилия оператора
patronymic VARCHAR(250),						-- Отчество оператора, может быть Null
birthday DATE NOT NULL,							-- Дата рождения оператора
current_status ENUM('work', 'fired', 'training', 'vacation', 'downtime') NOT NULL DEFAULT 'downtime',	-- Текущий статус - работает, уволен, проходит обучение, отпуск, простой
id_head_of_the_operator BIGINT UNSIGNED DEFAULT NULL,	-- Начальник оператора 
info VARCHAR(250) DEFAULT NULL,					-- Дополнительная информация

UNIQUE INDEX operators_people(name, surname, patronymic, birthday)	-- Проверка на то, что бы не добавили одного и того же оператора несколько раз
);


DROP TABLE IF EXISTS head_of_field_party;					-- Таблица руководителей полевых партий
CREATE TABLE IF NOT EXISTS head_of_field_party (
head_id SERIAL PRIMARY KEY,						-- id Руководителя полевой партии, он выбирается из операторов
operator_head_id BIGINT UNSIGNED NOT NULL,		-- id оператора, который является руководителем
project_id BIGINT UNSIGNED NOT NULL,			-- id проекта, которым руководит данный руководитель
info VARCHAR(250) DEFAULT NULL					-- Дополнительная информация
);


/* 			****************** Раздел оборудования компании (БВС) ******************	       */

DROP TABLE IF EXISTS uas_type;								-- Таблица моделей БВС
CREATE TABLE IF NOT EXISTS uas_type (
uas_type_id SERIAL PRIMARY KEY,					-- id модели БВС
name VARCHAR(250) NOT NULL UNIQUE,				-- Название модели БВС
info VARCHAR(250) DEFAULT NULL					-- Дополнительная информация
);


DROP TABLE IF EXISTS uas;									-- Таблица БВС, имеющихся в компании
CREATE TABLE IF NOT EXISTS uas (
uas_id SERIAL PRIMARY KEY,						-- id БВС 
uas_type_id	BIGINT UNSIGNED NOT NULL,			-- Ссылка на id модели БВС
reg_number VARCHAR(250) UNIQUE NOT NULL,		-- Регистрационный номер БВС
data_of_purchasement DATE NOT NULL,				-- Дата покупки БВС
offset_x_for_metashape FLOAT NOT NULL DEFAULT 0,-- Оффсет по оси X из Меташейпа	
offset_y_for_metashape FLOAT NOT NULL DEFAULT 0,-- Оффсет по оси Y из Меташейпа	
offset_z_for_metashape FLOAT NOT NULL DEFAULT 0,-- Оффсет по оси Z из Меташейпа	
offset_date DATETIME NOT NULL DEFAULT NOW() ON UPDATE NOW(),	-- Дата внесения оффсета в базу
current_status ENUM('work', 'cracsed', 'testing', 'downtime') NOT NULL DEFAULT 'downtime',
info VARCHAR(250) DEFAULT NULL,					-- Дополнительная информация

UNIQUE INDEX uas_date_of_perchasment_reg_number(data_of_purchasement, reg_number)	-- Проверка на то, что бы не добавили один и тот же БВС дважды
);


/* 			****************** Раздел обеспечения безопасности полетов ******************	       */

DROP TABLE IF EXISTS reg_centers;							-- Таблица, содержащая перечень региональных центров и их сокращений, а также шаблоны документов для каждого центра
CREATE TABLE IF NOT EXISTS reg_centers (
reg_center_id SERIAL PRIMARY KEY,				-- id регионального центра
short_name CHAR(5) NOT NULL UNIQUE,				-- Аббревиатура регионального центра
name VARCHAR(250) UNIQUE NOT NULL,				-- Полное название регионального центра
sample_of_view VARCHAR(250),					-- Ссылка на документ, содержащий образец представления (документ Word)
sample_of_SHR VARCHAR(250),						-- Ссылка на документ, содержащий образец SHR (документ Word)
info VARCHAR(250) DEFAULT NULL					-- Дополнительная информация
);

DROP TABLE IF EXISTS regims;								-- Таблица представляет собой архив установленных представлений
CREATE TABLE IF NOT EXISTS regims (
regim_id SERIAL PRIMARY KEY,					-- id установленного режима
regim_type ENUM('МР', 'ВР') NOT NULL,			-- тип режима
number_regim BIGINT NOT NULL,						-- номер режима
reg_center_id BIGINT UNSIGNED NOT NULL,			-- id регионального центр, в котором установлен режим
reference_to_view VARCHAR(250) NOT NULL UNIQUE,		-- ссылка на документ представления
reference_to_SHR1 VARCHAR(250) NOT NULL UNIQUE,		-- ссылка на документ SHR
reference_to_SHR2 VARCHAR(250) DEFAULT NULL UNIQUE,	-- ссылка на документ SHR
reference_to_SHR3 VARCHAR(250) DEFAULT NULL UNIQUE,	-- ссылка на документ SHR
reference_to_SHR4 VARCHAR(250) DEFAULT NULL UNIQUE,	-- ссылка на документ SHR
reference_to_SHR5 VARCHAR(250) DEFAULT NULL UNIQUE,	-- ссылка на документ SHR
reference_to_SHR6 VARCHAR(250) DEFAULT NULL UNIQUE,	-- ссылка на документ SHR
reference_to_SHR7 VARCHAR(250) DEFAULT NULL UNIQUE,	-- ссылка на документ SHR
reference_to_SHR8 VARCHAR(250) DEFAULT NULL UNIQUE,	-- ссылка на документ SHR
id_regim_creator BIGINT UNSIGNED NOT NULL,					-- id сотрудника ОДОП, установившего данный режим
info VARCHAR(250) DEFAULT NULL,					-- Дополнительная информация

UNIQUE INDEX regim_type_number(regim_type, number_regim)	-- Проверка на то, что бы не добавили один и тот же режим дважды
);


/* 			****************** Производственный раздел компании ******************	       */

DROP TABLE IF EXISTS flights;								-- Таблица совершенных полетов
CREATE TABLE IF NOT EXISTS flights (
flight_id SERIAL PRIMARY KEY,						-- id каждого полета - уникальное значение
utc_flight_date_time_start DATETIME NOT NULL,		-- UTC - время взлета, заполняется вручную
utc_flight_date_time_end DATETIME NOT NULL,			-- UTC - время посадки, заполняется вручную
flight_duration TIME NOT NULL,						-- Длительность полета в минутах. Хотел сделать через DEFAULT MINUTE(flights.utc_flight_date_time_end - flights.utc_flight_date_time_start), но была выдана ошибка
flight_folder VARCHAR(250) UNIQUE NOT NULL,			-- Ссылка на папку с логами полета
project_id BIGINT UNSIGNED,							-- id проекта, согласно которому выоплнялся полет. Может принимать значения NULL
operator1_id BIGINT UNSIGNED NOT NULL,				-- Оператор БВС №1, выполняющий полет
operator2_id BIGINT UNSIGNED DEFAULT NULL,			-- Оператор БВС №2, выполняющий полет. Может принимать значения NULL
operator3_id BIGINT UNSIGNED DEFAULT NULL,			-- Оператор БВС №3, выполняющий полет. Может принимать значения NULL
operator4_id BIGINT UNSIGNED DEFAULT NULL,					-- Оператор БВС №4, выполняющий полет. Может принимать значения NULL
uas_id BIGINT UNSIGNED NOT NULL,					-- id БВС, выполняющего полет
regim_id BIGINT UNSIGNED NOT NULL,					-- Режим, согласно которому выполнялся полет. Может быть Null
info VARCHAR(250) DEFAULT NULL,						-- Дополнительная информация

UNIQUE INDEX flights_operators(utc_flight_date_time_start, utc_flight_date_time_end, operator1_id, operator2_id, operator3_id, operator4_id)	-- Проверка на то, что бы один и тот же полет "не был совершен дважды"
);

DROP TABLE IF EXISTS operator_bonus;								-- Таблица расчета премии операторов
CREATE TABLE IF NOT EXISTS operator_bonus(
bonus_id SERIAL PRIMARY KEY,						-- id расчета премии
operator_id BIGINT UNSIGNED NOT NULL,				-- id оператора, которому рассчитывается премия
bonus BIGINT UNSIGNED NOT NULL,						-- величина премии
billing_period DATE NOT NULL,						-- за какой расчетный период
date_of_calculation DATETIME NOT NULL DEFAULT NOW(),-- дата расчета премии
who_has_calculated_salary VARCHAR(250) NOT NULL,	-- ФИО сотрудника, рассчитавшего премию
info VARCHAR(250) DEFAULT NULL,						-- Дополнительная информация

UNIQUE INDEX salary_operator_billing_period(operator_id, billing_period)	-- Проверка на то, что бы не посчитать одному и тому же оператору премию дважды за месяц
);

DROP TABLE IF EXISTS history_offsets;								-- Таблица история оффсетов для триггера
CREATE TABLE IF NOT EXISTS history_offsets(
uas_id BIGINT UNSIGNED,
offset_x_for_metashape FLOAT,-- Оффсет по оси X из Меташейпа	
offset_y_for_metashape FLOAT,-- Оффсет по оси Y из Меташейпа	
offset_z_for_metashape FLOAT,
date_of_changing DATETIME NOT NULL DEFAULT NOW()
) ENGINE = ARCHIVE;


ALTER TABLE head_of_field_party 
ADD CONSTRAINT head_of_field_party_from_operators 
FOREIGN KEY (operator_head_id) REFERENCES operators(operator_id);

ALTER TABLE head_of_field_party 
ADD CONSTRAINT head_of_field_party_from_projects 
FOREIGN KEY (project_id) REFERENCES projects(project_id);

ALTER TABLE operators
ADD CONSTRAINT id_head_of_operator 
FOREIGN KEY (id_head_of_the_operator) REFERENCES head_of_field_party(head_id);


ALTER TABLE uas
ADD CONSTRAINT uas_from_uas_type
FOREIGN KEY (uas_type_id) REFERENCES uas_type(uas_type_id);

ALTER TABLE regims
ADD CONSTRAINT reg_center_from_reg_centers
FOREIGN KEY (reg_center_id) REFERENCES reg_centers(reg_center_id);

ALTER TABLE regims
ADD CONSTRAINT regim_creator_from_odop
FOREIGN KEY (id_regim_creator) REFERENCES odop(dispatcher_id);

ALTER TABLE flights
ADD CONSTRAINT project_id_from_projects
FOREIGN KEY (project_id) REFERENCES projects(project_id);

ALTER TABLE flights
ADD CONSTRAINT operator_1_from_operators
FOREIGN KEY (operator1_id) REFERENCES operators(operator_id);

ALTER TABLE flights
ADD CONSTRAINT operator_2_from_operators
FOREIGN KEY (operator2_id) REFERENCES operators(operator_id);

ALTER TABLE flights
ADD CONSTRAINT operator_3_from_operators
FOREIGN KEY (operator3_id) REFERENCES operators(operator_id);

ALTER TABLE flights
ADD CONSTRAINT operator_4_from_operators
FOREIGN KEY (operator4_id) REFERENCES operators(operator_id);

ALTER TABLE flights
ADD CONSTRAINT uas_id_from_uas
FOREIGN KEY (uas_id) REFERENCES uas(uas_id);

ALTER TABLE flights
ADD CONSTRAINT regim_from_regims
FOREIGN KEY (regim_id) REFERENCES regims(regim_id);

ALTER TABLE operator_bonus
ADD CONSTRAINT operator_id_from_operators
FOREIGN KEY (operator_id) REFERENCES operators(operator_id);
