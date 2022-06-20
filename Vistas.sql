--Top 3 de circuitos donde hay mayor cantidad de tiempo en boxes
create view mayorTiempoEnParada as
select top 3 PA.PARADA_BOX_TIEMPO,CA.CIRCUITO_CODIGO,CA_CARRERA_CODIGO
from test.LUSAX2.PARADA as PA
left join test.LUSAX2.CIRCUITO as CA on CA.CARRERA_CODIGO = PA.CARRERA_CODIGO
order by 1 desc
