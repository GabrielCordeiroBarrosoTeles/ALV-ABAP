"---------------------------------------------------------------------*
"  Include -> ZPROG_011_05_TOP
"  Declaração das variáveis
"---------------------------------------------------------------------*
"  Tabelas
TABLES: zvendas_05,
        zprodutos_05.

" Declarar o tipo de pool SLIS que contém as definições
" necessárias para interagir com as funções ALV:
TYPE-POOLS: slis.

TYPES: BEGIN OF ty_saida,
         venda        TYPE zvendas_05-venda,
         item         TYPE zvendas_05-item,
         produto      TYPE zvendas_05-produto,
         desc_produto TYPE zprodutos_05-desc_produto,
         quantidade   TYPE zvendas_05-quantidade,
         preco        TYPE zvendas_05-preco,
         data         TYPE zvendas_05-data,
         hora         TYPE zvendas_05-hora,
       END OF ty_saida.

* Variáveis globais
DATA: gt_saida    TYPE STANDARD TABLE OF ty_saida,
      ls_saida    LIKE LINE OF gt_saida,
      gt_fieldcat TYPE slis_t_fieldcat_alv,
      gv_repid    TYPE sy-repid.