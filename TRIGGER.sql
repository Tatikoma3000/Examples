DELIMITER // 
CREATE TRIGGER create_offset_history AFTER UPDATE ON uas
FOR EACH ROW
BEGIN
	INSERT INTO history_offsets
	(uas_id, offset_x_for_metashape, offset_y_for_metashape, offset_z_for_metashape)
	VALUES
	(OLD.uas_id, OLD.offset_x_for_metashape, OLD.offset_y_for_metashape, OLD.offset_z_for_metashape);
END;//

DELIMITER //