SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: p_venda FOR zvendas_05-venda,
                p_prod FOR zvendas_05-produto,
                p_data FOR zvendas_05-data.
SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN SKIP 1.