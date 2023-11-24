REPORT ZPROG_011_05.
"**************************************************************
"Atividade de Abap List Viewer (ALV)
" Zvendas: Venda , Item , Cod_Prod , Quant , Preço , Data , Hora
" ZprodutosDesc_prod
"
"Tela de seleção: venda cod_prod , data
"**************************************************************
INCLUDE zprog_011_05_top.  "Declaração das variáveis

INCLUDE zprog_011_05_src.  "Tela de seleção

INCLUDE zprog_011_05_f.  "Rotinas

"--------- Evento INITIALIZATION para inicializar algumas variáveis---------
INITIALIZATION.
  gv_repid = sy-repid.

  START-OF-SELECTION.

PERFORM z_select.

"A instrução SELECT acima recupera dados de tabelas de vendas e produtos com base em determinadas condições.
" Os campos selecionados são então armazenados na tabela interna gt_saida.

  PERFORM z_fieldcat_init USING gt_fieldcat.   " Indicação dos campos para exibição

end-of-SELECTION.
 PERFORM z_list_display.