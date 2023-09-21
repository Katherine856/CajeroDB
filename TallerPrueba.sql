INSERT INTO SUCURSAL VALUES (1, 'VIRTUAL', 'N/A', 5555555);

INSERT INTO CLIENTE VALUES (1, 'CEDULA', 'LINDSEY', 'CAMARGO', 'LC@CORREO,COM', 111, 'CALLE 52 SUR', 'TechCamp7', 1);
INSERT INTO CLIENTE VALUES (2, 'CEDULA', 'ALEJANDRO', 'FIESCO', 'AF@CORREO,COM', 222, 'CARRERA 54 SUR', 'TechCamp7', 1);

INSERT INTO TIPO_CUENTA VALUES (1, 'CA', 0.24);
INSERT INTO TIPO_CUENTA VALUES (2, 'CC', 0.50);
INSERT INTO TIPO_CUENTA VALUES (3, 'CDT', 0.71);

INSERT INTO CUENTA VALUES (01234, 1, 1, 10000, 1234);
INSERT INTO CUENTA VALUES (56789, 2, 2, 10000, 1234);

CREATE OR REPLACE FUNCTION OBTENER_SALDO (ID_CUENTA NUMBER) RETURN NUMBER IS SALDO_ACTUAL NUMBER;
BEGIN
   SELECT SALDO INTO SALDO_ACTUAL FROM CUENTA WHERE NUMERO_CUENTA = ID_CUENTA;
   RETURN SALDO_ACTUAL;
END;

SELECT OBTENER_SALDO(56789) FROM DUAL;

CREATE OR REPLACE PROCEDURE CONSIGNAR (ID_CUENTAO NUMBER, ID_CUENTAD NUMBER, MONTO NUMBER) IS SALDO_CUENTAO NUMBER; 
BEGIN 
    SALDO_CUENTAO := OBTENER_SALDO(ID_CUENTAO);
    IF SALDO_CUENTAO >= MONTO THEN 
        UPDATE CUENTA SET SALDO = SALDO - MONTO WHERE NUMERO_CUENTA = ID_CUENTAO;
        DECLARE
            SALDO_CUENTAD NUMBER;
            BEGIN
            SALDO_CUENTAD := OBTENER_SALDO(ID_CUENTAD);
            IF SALDO_CUENTAD IS NOT NULL THEN
                UPDATE CUENTA SET SALDO = SALDO + MONTO WHERE NUMERO_CUENTA = ID_CUENTAD;
            ELSE
                DBMS_OUTPUT.put_line ('La cuenta es de otro banco');
            END IF;
            END;
        COMMIT;
    ELSE
        DBMS_OUTPUT.put_line ('Saldo insuficiente');
        ROLLBACK;
    END IF;
END;

BEGIN 
    CONSIGNAR(56789, 1234, 2000);
END;

CREATE OR REPLACE PROCEDURE RETIRAR (ID_CUENTA NUMBER, MONTO NUMBER) IS SALDO_CUENTAO NUMBER; 
BEGIN 
    SALDO_CUENTAO := OBTENER_SALDO(ID_CUENTA);
    IF SALDO_CUENTAO >= MONTO THEN 
        UPDATE CUENTA SET SALDO = SALDO - MONTO WHERE NUMERO_CUENTA = ID_CUENTA;
        COMMIT;
    ELSE
        DBMS_OUTPUT.put_line ('Saldo insuficiente');
        ROLLBACK;
    END IF;
END;

BEGIN 
    RETIRAR(1234, 2000);
END;

CREATE OR REPLACE PROCEDURE CAL_INTERES AS CURSOR TABLA_CUENTA_INTERES IS
SELECT NUMERO_CUENTA, SALDO, INTERES FROM CUENTA C, TIPO_CUENTA TP WHERE TP.ID_TIPO_CUENTA = C.ID_TIPO_CUENTA;
BEGIN
    FOR CUENTAFOR IN TABLA_CUENTA_INTERES LOOP
        UPDATE CUENTA SET SALDO = ( CUENTAFOR.SALDO + (CUENTAFOR.SALDO * CUENTAFOR.INTERES / 100)) WHERE NUMERO_CUENTA = CUENTAFOR.NUMERO_CUENTA;
        COMMIT;
    END LOOP;
END;

BEGIN 
    CAL_INTERES;
END;