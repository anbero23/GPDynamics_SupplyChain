SELECT * FROM (

Select		g1.Serie
			,g1.Numero
			,g1.FechaEmision Fecha_guia
			,g1.HoraEmision Hora_guia
			,g1.OrigenDocID GuiaSOP
			,Dest_Documento RUC_Cliente
			,Dest_Nombre Cliente
			,g1.ptolle_ubigeoid Ubigeo_cliente
			,g3.nombre Motivo_traslado
			,g1.Envio_PesoBrutoTot Peso_Total
			,g2.ArticuloID Itemnmbr
			,g2.Descripcion 
			,g2.Cantidad
			,g2.Peso Peso_Item
			,g5.Documento DNI_Conductor
			,g5.Nombre Conductor
			,g5.Licencia Licencia_Conductor
			,g7.Documento RUC_Transportista
			,g7.Nombre Transportista
			,g8.Placa
			,g9.CapacidadM3
			,g8.Marca Marca_Vehiculo
			,ub.dep_desc Departamento
			,ub.prov_desc Provincia
			,ub.Distrito
from [dbo].[neIVGrmTb_Guia] g1 --guía encabezados
		left join [dbo].[neIVGrmTb_GuiaDet] g2 --detalle de la guía por ítem
on g1.guiaid=g2.guiaid
		left join [dbo].[neIVGrmTb_MotivoTraslado] g3 --maestro de motivos de traslado
on g1.envio_motivotrasladoid=g3.motivotrasladoid
		left join [dbo].neIVGrmTb_GuiaCnd g4 --une guía con conductor
on g1.guiaid=g4.guiaid
		left join [dbo].neIVGrmTb_Conductor g5 --tabla conductor
on g4.conductorid=g5.conductorid
		left join [dbo].neIVGrmTb_GuiaTrm g6 --une guiá con transportista
on g1.guiaid=g6.guiaid and g1.FechaEmision=g6.FechaTraslado
		left join [dbo].neIVGrmTb_Transportista g7 --maestro de transportistas
on g7.transportistaid=g6.transportistaid
		left join [TANGO\GP2016].[GPUDL].[dbo].[neIVGrmTb_vehiculo] g8 --maestro de vehículos
on g8.vehiculoid=g6.vehiculoid
		left join jazz.gestion_udl.dbo.ubigeos ub
on		ub.ubigeo=g1.ptolle_ubigeoid
		left join jazz.[GESTION_UDL].[dbo].[neIVGrmTb_Vehiculo] g9
on g9.VehiculoID=g8.vehiculoid

) A
where GuiaSOP = 'T053-00000007'
