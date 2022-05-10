BEGIN


    -- declare variables for database and table names
    DECLARE dbname VARCHAR(128) DEFAULT '';

    DECLARE done INTEGER DEFAULT 0;
    
    -- declare cursor for list of tables
    
    DECLARE multi_table_fetch CURSOR FOR 
      SELECT DISTINCT TABLE_SCHEMA AS `database`
        FROM `information_schema`.TABLES
       WHERE TABLE_SCHEMA NOT IN ('information_schema', 'performance_schema', 'mysql')


       ORDER BY TABLE_SCHEMA;
       
      

    -- declare NOT FOUND handler
        DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET done = 1;
	 
	 SET @s = ' ';
	 
	 SET @union_append = '';
		 
    OPEN multi_table_fetch;

    multi_table: LOOP

        FETCH multi_table_fetch INTO dbname;

        IF done = 1 THEN
        LEAVE multi_table;
        END IF;

        -- create an appropriate text string for a DDL or other SQL statement
        SET @s = CONCAT(@s, @union_append, ' ( SELECT "',dbname,'", `id`,`fullname` FROM  ',dbname,'.users ORDER BY id DESC LIMIT 0 , 10 ) ');
        
        SET @union_append = ' UNION ';
        
        -- PREPARE stmt FROM @s;
        -- EXECUTE stmt;
        -- DEALLOCATE PREPARE stmt; 
        
    END LOOP    multi_table;
    
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt; 
        
    CLOSE multi_table_fetch;
   
END
