---
weight: 20
title: SQL
---

## Declare a Variable in MySQL
([ref](http://stackoverflow.com/questions/11754781/how-to-declare-a-variable-in-mysql))

There are mainly three types of variables in MySQL:

User-defined variables (prefixed with @):

You can access any user-defined variable without declaring it or initializing it. If you refer to a variable that has not been initialized, it has a value of NULL and a type of string.

SELECT @var_any_var_name
You can initialize a variable using SET or SELECT statement:

SET @start = 1, @finish = 10;    
or

SELECT @start := 1, @finish := 10;

SELECT * FROM places WHERE place BETWEEN @start AND @finish;
User variables can be assigned a value from a limited set of data types: integer, decimal, floating-point, binary or nonbinary string, or NULL value.

User-defined variables are session-specific. That is, a user variable defined by one client cannot be seen or used by other clients.

They can be used in SELECT queries using Advanced MySQL user variable techniques.
Local Variables (no prefix) :

Local variables needs to be declared using DECLARE before accessing it.

They can be used as local variables and the input parameters inside a stored procedure:

```sql
DELIMITER //

CREATE PROCEDURE sp_test(var1 INT) 
BEGIN   
    DECLARE start  INT unsigned DEFAULT 1;  
    DECLARE finish INT unsigned DEFAULT 10;

    SELECT  var1, start, finish;

    SELECT * FROM places WHERE place BETWEEN start AND finish; 
END; //

DELIMITER ;

CALL sp_test(5);
```

If the DEFAULT clause is missing, the initial value is NULL.

The scope of a local variable is the BEGIN ... END block within which it is declared.
Server System Variables (prefixed with @@):

The MySQL server maintains many system variables configured to a default value. They can be of type GLOBAL, SESSION or BOTH.

Global variables affect the overall operation of the server whereas session variables affect its operation for individual client connections.

To see the current values used by a running server, use the SHOW VARIABLES statement or SELECT @@var_name.

SHOW VARIABLES LIKE '%wait_timeout%';

SELECT @@sort_buffer_size;

They can be set at server startup using options on the command line or in an option file. Most of them can be changed dynamically while the server is running using SET GLOBAL or SET SESSION:

```sql
-- Syntax to Set value to a Global variable:
SET GLOBAL sort_buffer_size=1000000;
SET @@global.sort_buffer_size=1000000;

-- Syntax to Set value to a Session variable:
SET sort_buffer_size=1000000;
SET SESSION sort_buffer_size=1000000;
SET @@sort_buffer_size=1000000;
SET @@local.sort_buffer_size=10000;
```
