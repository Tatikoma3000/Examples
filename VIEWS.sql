/*   ********** Представление для отображения имен руководителей партий ***************** */
CREATE OR REPLACE VIEW get_names_of_heads_of_fields_party AS 
SELECT  operators.operator_id, operators.name, operators.surname FROM operators, head_of_field_party
WHERE operators.operator_id = head_of_field_party.operator_head_id;

/*   ********** Представление для отображения имен руководителей партий для каждого оператора ***************** */
CREATE OR REPLACE VIEW who_is_his_head AS
SELECT tbl1.name, tbl1.surname, operators.name as head_name, operators.surname as head_surname from 
		(SELECT operators.name, operators.surname, head_of_field_party.operator_head_id FROM operators
		JOIN head_of_field_party
		ON operators.id_head_of_the_operator = head_of_field_party.head_id) as tbl1
JOIN operators
ON tbl1.operator_head_id = operators.operator_id;

/*   *** Представление для отображения количества сотрудников у каждого руководителя полевой партии *** */
CREATE OR REPLACE VIEW how_much_employees_for_every_head AS
SELECT operators.name, operators.surname, COUNT(*) as how_much_employees FROM operators
GROUP BY operators.id_head_of_the_operator;


