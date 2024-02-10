USE company;

INSERT INTO `odop` 
VALUES 
(1,'1976-03-02 14:15:07','voluptatibus','et',NULL,'2019-09-20','downtime',NULL),
(2,'1989-02-13 08:41:32','saepe','soluta',NULL,'2018-10-29','training',NULL),
(3,'2019-06-02 02:08:15','voluptatem','veniam',NULL,'1991-04-24','downtime',NULL),
(4,'1988-01-18 08:26:41','itaque','earum',NULL,'1972-06-27','fired',NULL),
(5,'1999-03-05 18:46:44','voluptatem','libero',NULL,'1993-12-26','vacation',NULL);

INSERT INTO `operators` (`operator_id`, `date_of_hire`, `name`, `surname`, `patronymic`,`birthday`,
`current_status`, `info`)
VALUES 
(1,'1972-07-04 04:32:46','et','sint',NULL,'2017-09-30','training',NULL),
(2,'1999-02-13 06:09:21','ut','odio',NULL,'1971-12-10','downtime',NULL),
(3,'1973-09-18 05:18:52','recusandae','eligendi',NULL,'1972-10-13','downtime',NULL),
(4,'2015-05-23 05:41:08','tenetur','tempore',NULL,'1984-01-23','downtime',NULL),
(5,'1990-01-07 06:01:09','aut','quia',NULL,'1979-09-29','fired',NULL),
(6,'1977-10-15 22:30:20','sed','et',NULL,'2002-01-26','fired',NULL),
(7,'1989-10-22 11:02:46','sit','voluptatem',NULL,'1987-08-24','training',NULL),
(8,'1977-09-13 01:34:50','quasi','minus',NULL,'2022-06-03','work',NULL),
(9,'2009-02-13 00:42:07','omnis','eveniet',NULL,'1991-07-08','downtime',NULL),
(10,'1987-05-12 13:44:15','rem','sequi',NULL,'2016-06-10','vacation',NULL),
(11,'2004-07-15 22:50:54','ea','quibusdam',NULL,'1996-02-07','downtime',NULL),
(12,'2005-02-14 13:06:08','dignissimos','enim',NULL,'1982-07-31','vacation',NULL),
(13,'1994-09-16 09:13:07','possimus','voluptatem',NULL,'1973-02-06','training',NULL),
(14,'2010-01-11 16:10:38','aperiam','voluptas',NULL,'1982-10-19','fired',NULL),
(15,'2001-12-08 08:48:27','similique','repudiandae',NULL,'2010-03-09','training',NULL);

INSERT INTO `projects` 
VALUES 
(1,'autem','',NULL),
(2,'architecto','',NULL),
(3,'harum','',NULL);

INSERT INTO `reg_centers` 
VALUES 
(1,'et','occaecati',NULL,NULL,NULL),
(2,'enim','fugiat',NULL,NULL,NULL),
(3,'magni','eius',NULL,NULL,NULL),
(4,'modi','voluptatem',NULL,NULL,NULL),
(5,'sed','in',NULL,NULL,NULL),
(6,'nihil','ety',NULL,NULL,NULL),
(7,'deser','et',NULL,NULL,NULL),
(8,'culpa','perferendis',NULL,NULL,NULL),
(9,'aut','dicta',NULL,NULL,NULL),
(10,'dolor','accusamus',NULL,NULL,NULL);

INSERT INTO `uas_type` 
VALUES 
(1,'et',NULL),
(2,'mollitia',NULL),
(3,'eos',NULL);

INSERT INTO head_of_field_party (`operator_head_id`, `project_id`)
VALUES
(1, 2),
(3, 3),
(5, 1);

INSERT INTO `company`.`uas`
(`uas_type_id`,
`reg_number`,
`data_of_purchasement`)
VALUES
(1, '017Z3BL', '2000-12-11'),
(1, '017Z3BM', '2000-12-11'),
(1, '017Z3Bsd', '2000-12-11'),
(1, '017Z4BL', '2000-12-11'),
(1, '01qweZ3BL', '2000-12-11'),
(1, '01qq5Z3BL', '2000-12-11'),
(1, '01sd3BL', '2000-12-11'),
(1, '0dfs23BL', '2000-12-11');


INSERT INTO `company`.`regims`
(`regim_type`, `number_regim`, `reg_center_id`, `reference_to_view`, `reference_to_SHR1`, `reference_to_SHR2`, 
`reference_to_SHR3`, `reference_to_SHR4`, `reference_to_SHR5`, `reference_to_SHR6`, `reference_to_SHR7`, 
`reference_to_SHR8`, `id_regim_creator`, `info`)
VALUES
('МР', '1730', 1, 'D:\view11.docx', 'D:\SHR11.docx', 'D:\SHR12.docx', 'D:\SHR13.docx', 'D:\SHR14.docx', 'D:\SHR15.docx',
'D:\SHR16.docx', 'D:\SHR17.docx', 'D:\SHR18.docx', 1, 'extra_info'),
('МР', '1731', 2, 'D:\view21.docx', 'D:\SHR21.docx', 'D:\SHR22.docx', 'D:\SHR23.docx', 'D:\SHR24.docx', 'D:\SHR25.docx',
'D:\SHR26.docx', 'D:\SHR27.docx', 'D:\SHR28.docx', 1, 'extra_info'),
('МР', '1732', 3, 'D:\view31.docx', 'D:\SHR31.docx', 'D:\SHR42.docx', 'D:\SHR33.docx', 'D:\SHR34.docx', 'D:\SHR35.docx',
'D:\SHR36.docx', 'D:\SHR37.docx', 'D:\SHR38.docx', 1, 'extra_info'),
('МР', '1733', 4, 'D:\view41.docx', 'D:\SHR41.docx', 'D:\SHR52.docx', 'D:\SHR43.docx', 'D:\SHR44.docx', 'D:\SHR45.docx',
'D:\SHR46.docx', 'D:\SHR47.docx', 'D:\SHR48.docx', 1, 'extra_info'),
('МР', '1734', 5, 'D:\view51.docx', 'D:\SHR51.docx', 'D:\SHR62.docx', 'D:\SHR53.docx', 'D:\SHR54.docx', 'D:\SHR55.docx',
'D:\SHR56.docx', 'D:\SHR57.docx', 'D:\SHR58.docx', 1, 'extra_info');


INSERT INTO `company`.`operator_bonus`
(`operator_id`, `bonus`, `billing_period`, `who_has_calculated_salary`)
VALUES
(1, 2000, '2022-07-00', 'Иванов И.И.'),
(2, 2000, '2022-07-00', 'Иванов И.И.'),
(3, 2000, '2022-07-00', 'Иванов И.И.');


INSERT INTO `company`.`flights`
(`utc_flight_date_time_start`, `utc_flight_date_time_end`, `flight_duration`, `flight_folder`, `project_id`, `operator1_id`,
`operator2_id`, `uas_id`, `regim_id`)
VALUES
('2022-07-09 12:13:43', '2022-07-09 13:13:43', '01:00:00', 'D:\flight1\ ', 1, 4, 3, 2, 4),
('2022-07-09 12:13:43', '2022-07-09 13:13:43', '01:00:00', 'D:\flight2\ ', 1, 4, 3, 2, 4),
('2022-07-09 12:13:43', '2022-07-09 13:13:43', '01:00:00', 'D:\flight3\ ', 1, 4, 3, 2, 4),
('2022-07-09 12:13:43', '2022-07-09 13:13:43', '01:00:00', 'D:\flight4\ ', 1, 4, 3, 2, 4),
('2022-07-09 12:13:43', '2022-07-09 13:13:43', '01:00:00', 'D:\flight5\ ', 1, 4, 3, 2, 4);


UPDATE `company`.`operators`
SET
`id_head_of_the_operator` = 1
WHERE `operator_id` = 1;

UPDATE `company`.`operators`
SET
`id_head_of_the_operator` = 2
WHERE `operator_id` = 2;

UPDATE `company`.`operators`
SET
`id_head_of_the_operator` = 3
WHERE `operator_id` = 3;

UPDATE `company`.`operators`
SET
`id_head_of_the_operator` = 1
WHERE `operator_id` = 4;

UPDATE `company`.`operators`
SET
`id_head_of_the_operator` = 1
WHERE `operator_id` = 5;

UPDATE `company`.`operators`
SET
`id_head_of_the_operator` = 1
WHERE `operator_id` = 6;

UPDATE `company`.`operators`
SET
`id_head_of_the_operator` = 1
WHERE `operator_id` = 7;

UPDATE `company`.`operators`
SET
`id_head_of_the_operator` = 1
WHERE `operator_id` = 8;

UPDATE `company`.`operators`
SET
`id_head_of_the_operator` = 1
WHERE `operator_id` = 9;

UPDATE `company`.`operators`
SET
`id_head_of_the_operator` = 1
WHERE `operator_id` = 10;

UPDATE `company`.`operators`
SET
`id_head_of_the_operator` = 1
WHERE `operator_id` = 11;

UPDATE `company`.`operators`
SET
`id_head_of_the_operator` = 1
WHERE `operator_id` = 12;

UPDATE `company`.`operators`
SET
`id_head_of_the_operator` = 1
WHERE `operator_id` = 13;

UPDATE `company`.`operators`
SET
`id_head_of_the_operator` = 1
WHERE `operator_id` = 14;

UPDATE `company`.`operators`
SET
`id_head_of_the_operator` = 3
WHERE `operator_id` = 15;

UPDATE uas
SET
offset_x_for_metashape = 1,
offset_y_for_metashape = 2,
offset_z_for_metashape = 4
WHERE `uas_id` = 1;

SELECT * FROM `get_names_of_heads_of_fields_party`;
SELECT * FROM `how_much_employees_for_every_head`;
SELECT * FROM `who_is_his_head`;