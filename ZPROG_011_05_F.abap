FORM z_fieldcat_init USING pt_fieldcat TYPE slis_t_fieldcat_alv.

" Estruturas
  DATA: ls_fieldcat TYPE slis_fieldcat_alv.
" Limpar tabela
  CLEAR pt_fieldcat[].

" Cód. doc. venda
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'VENDA'.
  ls_fieldcat-ref_tabname = 'ZVENDAS_05'.
  APPEND ls_fieldcat TO pt_fieldcat.

" Item da Venda
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'ITEM'.
  ls_fieldcat-ref_tabname = 'ZVENDAS_05'.
  APPEND ls_fieldcat TO pt_fieldcat.

" Produto
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'PRODUTO'.
  ls_fieldcat-ref_tabname = 'ZVENDAS_05'.
  APPEND ls_fieldcat TO pt_fieldcat.

" Descrição Produto
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'DESC_PRODUTO'.
  ls_fieldcat-ref_tabname = 'ZPRODUTOS_05'.
  APPEND ls_fieldcat TO pt_fieldcat.

" Quantidade
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'QUANTIDADE'.
  ls_fieldcat-ref_tabname = 'ZVENDAS_05'.
  APPEND ls_fieldcat TO pt_fieldcat.

" Preço
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'PRECO'.
  ls_fieldcat-ref_tabname = 'ZVENDAS_05'.
  APPEND ls_fieldcat TO pt_fieldcat.

" Data da venda
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'DATA'.
  ls_fieldcat-ref_tabname = 'ZVENDAS_05'.
  APPEND ls_fieldcat TO pt_fieldcat.

" Hora da venda
  CLEAR ls_fieldcat.
  ls_fieldcat-fieldname = 'HORA'.
  ls_fieldcat-ref_tabname = 'ZVENDAS_05'.
  APPEND ls_fieldcat TO pt_fieldcat.

ENDFORM.

FORM z_sapgui_progress_indicator using value(pv_text).
CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
EXPORTING
TEXT = pv_text.
ENDFORM.

FORM z_select.
    PERFORM z_sapgui_progress_indicator
    USING 'selecionando'.
SELECT zven~venda
       zven~item
       zven~produto
       zprod~desc_produto
       zven~quantidade
       zven~preco
       zven~data
       zven~hora
  INTO CORRESPONDING FIELDS OF TABLE gt_saida
  FROM zvendas_05 AS zven
  INNER JOIN zprodutos_05 AS zprod ON zprod~produto = zven~produto
  WHERE zven~venda IN p_venda
  AND zven~produto IN p_prod
  AND zven~data IN p_data. " Filtrar com base em vendas, produto e data

ENDFORM.

FORM z_list_display.

  PERFORM z_sapgui_progress_indicator
    USING 'Estruturando a lista. Aguarde...'.

  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
    EXPORTING
      i_callback_program = gv_repid
      it_fieldcat        = gt_fieldcat
      i_save             = 'A'
    TABLES
      t_outtab           = gt_saida
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
* Verificar processamento da função
  IF sy-subrc NE 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM. " Z_LIST_DISPLAY