BEGIN


    -- declare variables for database and table names
    DECLARE dbname VARCHAR(128) DEFAULT '';

    DECLARE done INTEGER DEFAULT 0;
    
    -- declare cursor for list of log tables
    
    DECLARE log_clear CURSOR FOR 
      SELECT DISTINCT TABLE_SCHEMA AS `database`
        FROM `information_schema`.TABLES
        
	     -- select all databases except ('information_schema', 'performance_schema', 'mysql')
       WHERE TABLE_SCHEMA NOT IN ('information_schema', 'performance_schema', 'mysql')
	     -- or select databases: WHERE TABLE_SCHEMA IN ('mydatabase1', 'mydatabase2', 'mydatabase3')
       
       ORDER BY TABLE_SCHEMA;
       
      
    -- declare NOT FOUND handler
    
        DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET done = 1;
	 
	 SET @sql = ' ';

		 
    OPEN log_clear;

	log_clear_table: LOOP

        FETCH log_clear INTO dbname;

        IF done = 1 THEN
        LEAVE log_clear_table;
        END IF;

        -- create an appropriate text string for a DDL or other SQL statement
        SET @sql  = CONCAT(' DELETE FROM ',dbname, '.logs; ');

        
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt; 
        
    END LOOP    log_clear_table;

    CLOSE log_clear;
   
END
