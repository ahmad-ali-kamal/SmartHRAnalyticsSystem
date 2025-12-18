BEGIN
  /* ================================
     Name: Ahmad Ali Kamal
     Project: SMART HR ANALYTICS SYSTEM
     Database: HR_Data
     ================================ */

  -- View: Salary Analytics (CASE + Window)
  EXECUTE IMMEDIATE '
    CREATE OR REPLACE VIEW v_hr_salary_analytics AS
    SELECT
      e.employee_id,
      e.first_name,
      e.department_id,
      e.salary,
      AVG(e.salary) OVER (PARTITION BY e.department_id) dept_avg,
      RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) salary_rank,
      CASE
        WHEN e.salary < 5000 THEN ''LOW''
        WHEN e.salary BETWEEN 5000 AND 10000 THEN ''MEDIUM''
        ELSE ''HIGH''
      END salary_level
    FROM employees e
  ';

  -- View: Correlated Subquery
  EXECUTE IMMEDIATE '
    CREATE OR REPLACE VIEW v_above_dept_avg AS
    SELECT e.employee_id, e.first_name, e.salary
    FROM employees e
    WHERE e.salary >
      (SELECT AVG(salary)
       FROM employees
       WHERE department_id = e.department_id)
  ';

  -- View: EXISTS
  EXECUTE IMMEDIATE '
    CREATE OR REPLACE VIEW v_active_departments AS
    SELECT d.department_name
    FROM departments d
    WHERE EXISTS (
      SELECT 1 FROM employees e
      WHERE e.department_id = d.department_id
    )
  ';

  -- View: Recursive Query
  EXECUTE IMMEDIATE '
    CREATE OR REPLACE VIEW v_hr_hierarchy AS
    SELECT LPAD('' '', LEVEL*2) || first_name AS hierarchy
    FROM employees
    START WITH manager_id IS NULL
    CONNECT BY PRIOR employee_id = manager_id
  ';

  -- Index
  EXECUTE IMMEDIATE '
    CREATE INDEX idx_emp_salary ON employees(salary)
  ';

  -- Partitioned Table
  EXECUTE IMMEDIATE '
    CREATE TABLE hr_audit_log (
      log_id NUMBER,
      action_date DATE,
      description VARCHAR2(100)
    )
    PARTITION BY RANGE (action_date) (
      PARTITION p_2024 VALUES LESS THAN (DATE ''2025-01-01'')
    )
  ';

  -- Procedure
  EXECUTE IMMEDIATE '
    CREATE OR REPLACE PROCEDURE get_employee_salary(p_id NUMBER) IS
      v_sal employees.salary%TYPE;
    BEGIN
      SELECT salary INTO v_sal FROM employees WHERE employee_id = p_id;
      DBMS_OUTPUT.PUT_LINE(''Salary = '' || v_sal);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(''Employee not found'');
    END;
  ';

  -- Function
  EXECUTE IMMEDIATE '
    CREATE OR REPLACE FUNCTION annual_salary(p_id NUMBER)
    RETURN NUMBER IS
      v_sal NUMBER;
    BEGIN
      SELECT salary*12 INTO v_sal FROM employees WHERE employee_id = p_id;
      RETURN v_sal;
    END;
  ';

  -- Trigger
  EXECUTE IMMEDIATE '
    CREATE OR REPLACE TRIGGER trg_no_delete_employee
    BEFORE DELETE ON employees
    BEGIN
      RAISE_APPLICATION_ERROR(-20001, ''Delete not allowed'');
    END;
  ';

  -- PL/SQL Logic 
  DECLARE
    v_bonus CONSTANT NUMBER := 1000;
    v_emp employees%ROWTYPE;
  BEGIN
    SELECT * INTO v_emp FROM employees WHERE employee_id = 101;

    IF v_emp.salary < 5000 THEN
      DBMS_OUTPUT.PUT_LINE('Low Salary Employee');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Bonus = ' || v_bonus);
    END IF;
  END;

  -- Cursor + Loop
  FOR r IN (SELECT first_name FROM employees WHERE department_id = 60) LOOP
    DBMS_OUTPUT.PUT_LINE(r.first_name);
  END LOOP;

  -- User Defined Exception
  DECLARE
    e_low_salary EXCEPTION;
    v_sal NUMBER;
  BEGIN
    SELECT salary INTO v_sal FROM employees WHERE employee_id = 102;
    IF v_sal < 3000 THEN
      RAISE e_low_salary;
    END IF;
  EXCEPTION
    WHEN e_low_salary THEN
      DBMS_OUTPUT.PUT_LINE('Salary below minimum');
  END;

  -- Collections + Bulk Collect
  DECLARE
    TYPE emp_tab IS TABLE OF employees%ROWTYPE;
    emp_list emp_tab;
  BEGIN
    SELECT * BULK COLLECT INTO emp_list
    FROM employees WHERE department_id = 60;

    DBMS_OUTPUT.PUT_LINE('Employees Count = ' || emp_list.COUNT);
  END;

  -- VARRAY
  DECLARE
    TYPE rating_arr IS VARRAY(3) OF NUMBER;
    ratings rating_arr := rating_arr(3,4,5);
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Rating = ' || ratings(1));
  END;

END;
/
