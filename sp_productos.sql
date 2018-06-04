USE [MDMHERDEZCI]
GO
/****** Object:  StoredProcedure [dbo].[sp_get_all_fields_mdm_pt]    Script Date: 06/04/2018 10:33:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[sp_get_all_fields_mdm_pt]
     @BANDERA CHAR(1),@RecursoID nvarchar(15)

AS
BEGIN
    DECLARE @KnProduct NVARCHAR(15)
    DECLARE @SQL NVARCHAR(MAX)
    DECLARE @FILTRO NVARCHAR(50)
/*
Creado por : Benito Sánchez
    Fecha de Creación     : 18-05-2018
    Fecha de Revision AVA : 21-05-2018 // -- QUITAR Se revisó y se comentaros algunos campos
    Fecha últimos Cambios: 21-05-2018 17:00 p.m. // Cambios: se agregó tabla pos nutrisa

Modo de ejecición:

EXEC [sp_get_all_fields_mdm_pt] 'P','615001' -- 'P' Para filtrar sólo un producto
EXEC [sp_get_all_fields_mdm_pt] 'T','615001' -- 'T' Para Mostrar Todos los productos

*/

SET @SQL = 
'
SELECT    
P.ID
, P.[Número de Recurso]
, P.[Descripción Hérdez]
, TDP.[Código de Tipo de Producto],  TDP.[Nombre de Tipo de Producto]
, O.[Código de Origen] 
, O.[Nombre de Origen]
, M.[Código de Marca Armado Clave ME], M.[Nombre de Marca Armado Clave ME]
, C.[Codigo de Clase],C.Descripción as ''Nombre de Clase''
, P.[Peso Bruto]      
, TE.[Código de Tipo de Envase],TE.[Nombre de Tipo de Envase]
, SC.[Clave de Subclase],SC.[Descripción Subclase]
, P.[Peso Neto]
, UDM_P.[Código de Unidad de Medida] AS ''Codigo de Unidad de Medida Peso''    ,UDM_P.[Nombre de Unidad de Medida] AS ''Nombre de Unidad de Medida Peso''
, UDM_E.[Código de Unidad de Medida] AS ''Codigo de Unidad de Medida Estandar'', UDM_E.[Nombre de Unidad de Medida] AS ''Nombre de Unidad de Medida Estandar''
, P.[Piezas P Unidad de Venta]
, UDM_M.[Código de Unidad de Medida], UDM_M.[Nombre de Unidad de Medida]
, C_ABC.[Código de ABC],C_ABC.[Nombre de ABC]
, P.[Empaque Contenido]
-- QUITAR --, P.[Control de Lote]
, MRCD.[Código de Mercado], MRCD.[Nombre de Mercado]   
-- QUITAR --, P.[Consumo en Lote]
, TPO.[Código de Tipo], TPO.[Nombre de Tipo]
, LN.[Clave de Línea],ln.[Descripción de la Línea]
-- QUITAR --, P.[Indicador insuficiencia]
-- QUITAR --, P.[Código Saldo Recurso]
-- QUITAR --, P.[Consumo Teórico]
-- QUITAR --, P.[Clase Producto Producción]      
-- QUITAR --, P.[Recurso Potente]
-- QUITAR --, P.[Factor de Potencia]
-- QUITAR --, P.[Fecha Efectividad Inicial]
-- QUITAR --, P.[Fecha Efectividad Final]
-- QUITAR --, P.[Factor Merma]
-- QUITAR --, P.[Justo a Tiempo]
-- QUITAR --, P.[Peligro BOL]-
-- QUITAR --, P.[Línea Prod Producción]
, I.[Codigo de Categoria Impuesto],I.[Descripcion del Impuesto]
, ST.[Código de Status],ST.[Nombre de Status]
, P.Consecutivo
-- QUITAR --, P.Descripción
, SHMT.[Código de Sabor], SHMT.[Nombre de Sabor]
--- QUITAR --, PA_CLV.[Código de Planta Armado Clave ME] AS ''Código de Planta Armado'' , PA_CLV.[Nombre de Planta Armado Clave ME] AS ''Nombre de Planta Armado Clave''                
, P.[Descripción del Recurso]
, P.[Contenido Neto]
, PA.[Cantidad Estiba x Hilera]
, PA.[Cantidad Estiba x Unidad]
, PA.[Cantidad de Camas x Tarima]
, PA.[Altura de Estiba]
-- QUITAR --, PA.[Días Antigüedad 1]
, PA.[Caja Altura]      
, PA.[Caja Ancho]
, PA.[Caja Profundidad]
, PA.[Tarima Altura]
, PA.[Tarima Ancho]
, PA.[Tarima Profundidad]
-- QUITAR --, PA.[Recurso en Planta]
-- QUITAR --, PA.[Rotación Inventario]
-- QUITAR --, PA.[Ventana de Envío Directo]
-- QUITAR --, PC.[Código Nivel Costeo Fijo]
, TACSTO.[Código de Tipo Acum Costo],TACSTO.[Nombre de Tipo Acum Costo]
, PC.[Costo Estándar]
-- QUITAR --, PC.[Fecha Última Acumulación]
-- QUITAR --, PC.[Código Nivel Costeo]
-- QUITAR --, CUS.[Código de Costo Unitario Seleccionado],CUS.[Nombre de Costo Unitario Seleccionado]
-- QUITAR --, PC.[Costo Última Acumulación]
-- QUITAR --, PC.[Uso Valor Neto Realiz]
-- QUITAR --, CNACSTO.[Código de Clase Nivel Acum Costo],CNACSTO.[Nombre de Clase Nivel Acum Costo]
-- QUITAR --, PC.[Nuevo Costeo]
-- QUITAR --, CACSTO.[Código de Método Costeo Acum Costo],CACSTO.[Nombre de Método Costeo Acum Costo]
-- QUITAR --, PC.Entidad
-- QUITAR --, PC.[Tipo MP Prim p Costo]      
-- QUITAR --, PC.[Nmb MP Prim p Costo]
, PAC.[Vida Útil]
, PAC.[Vida Útil Días]
-- QUITAR --, PAC.[Recep Misc Cód Clasific Localiz Predet]
-- QUITAR --, PAC.[Recep Prod Cód Clasific Localiz Predet]
-- QUITAR --, PCA.[Tiempo de seguridad]
-- QUITAR --, PCA.[Clase de reporte]  
-- QUITAR --, PCA.[Cód de localiz docum]
-- QUITAR --, PCA.[Línea Prod Mercadeo]
-- QUITAR --, PCA.[Cls Recurso Mercadeo]
-- QUITAR --, PCA.[Cód clase inven est]
-- QUITAR --, PCA.[Cambio Sobre Costo]
-- QUITAR --, PCA.[Tasa GI Variable]
-- QUITAR --, PCA.[Byte GI Variable]
-- QUITAR --, PCA.[Tabla Tasa GI Varibl]
-- QUITAR --, PCA.[Tasa GI Fija]
-- QUITAR --, PCA.[Valor Tabla GI Fija]
-- QUITAR --, PCA.[Byte GI Fijo]
-- QUITAR --, PCA.[Tabla Tasa GI Fijo]
-- QUITAR --, PCA.[Valor Neto Reablizab]
-- QUITAR --, PCA.[Costo Fijo]
-- QUITAR --, PCA.[Ctro Trabajo X Omis]
-- QUITAR --, PCA.[Grupo Turno X Omisi]
-- QUITAR --, PCA.[N Veces Recurs Usado]
-- QUITAR --, PCA.[TE Acum MP Cst Prim]
-- QUITAR --, PCA.[TE Acum MP Cst Pr hr]
-- QUITAR --, PCA.[TE Acum MP Cst Pr mn]
-- QUITAR --, PCA.[Nmb Tarea Escand rl]
-- QUITAR --, PCA.[Nmb Tarea Escand Sim]
-- QUITAR --, PCA.[N Secuencia Planif]
-- QUITAR --, PCA.[Loc Omis p Consumo]
-- QUITAR --, PCA.[Alm Omis p Consumo]
-- QUITAR --, PCA.[Código de mercancía]
-- QUITAR --, PCA.[Nivel Revisión Actl]
-- QUITAR --, PCA.[Ultimo Nivel Aceptab]
-- QUITAR --, PCA.[Número de comprador]
-- QUITAR --, PCA.[Nivel Servicio A]
-- QUITAR --, PCA.[Multiplic Capacidad]
-- QUITAR --, PCA.[Rqd De Cd Clsif Lclz]
-- QUITAR --, PCA.[TE 1 de OC]
-- QUITAR --, PCA.[TE 1 OC hrs]
-- QUITAR --, PCA.[TE 1 OC mns]
-- QUITAR --, PCA.[TE 2 OC]
-- QUITAR --, PCA.[TE 2 OC hrs]
-- QUITAR --, PCA.[TE 2 OC mns]
-- QUITAR --, PCA.[TE OC p Nva Versión]
-- QUITAR --, PCA.[TE OC Nva Ver hrs]
-- QUITAR --, PCA.[TE 1 MO]
-- QUITAR --, PCA.[TE 1 MO hrs]
-- QUITAR --, PCA.[TE 1 MO mns]
-- QUITAR --, PCA.[TE 2 MO]
-- QUITAR --, PCA.[TE 2 MO hrs]
-- QUITAR --, PCA.[TE 2 MO mns]
-- QUITAR --, PCA.[Ajustar TE OC Day]
-- QUITAR --, PCA.[Ajustar TE OC hrs]
-- QUITAR --, PCA.[Ajustar TE OC mns]
-- QUITAR --, PCA.[Ajustar TE MO day]
-- QUITAR --, PCA.[Ajustar TE MO hrs]
-- QUITAR --, PCA.[Ajustar TE OM mns]
-- QUITAR --, PCA.[Cnt Máxima TE OC]
-- QUITAR --, PCA.[Cnt Máxima TE MO]
-- QUITAR --, PCA.[TE Ventas]
-- QUITAR --, PCA.[TE Ventas hrs]
-- QUITAR --, PCA.[TE Ventas mns]
-- QUITAR --, PCA.[Código de gráficos]
-- QUITAR --, PCA.[Loc Omis p Bolt Prd]
-- QUITAR --, PCA.[Alm Omis p Bolt Prd]
-- QUITAR --, PCA.[Código 1 Cmt Omis]
-- QUITAR --, PCA.[Código 2 Cmt Omis]
-- QUITAR --, PCA.[Código 3 Cmt Omis]
-- QUITAR --, PCA.[Acept Var Cnt Inv]
-- QUITAR --, PCA.[Var Cnt Inv Omis]
-- QUITAR --, PCA.[Var Cnt Bol Cmplt]
-- QUITAR --, PCA.[Var Dflt Cnt Bol Cmplt]
-- QUITAR --, PCA.[Acept Var Preci Inv]
-- QUITAR --, PCA.[Var Cnt Défic Oms]
-- QUITAR --, PCA.[Var Precio Inv Omi]
-- QUITAR --, PCA.[Var Cnt Défct Acep]
-- QUITAR --, PCA.[Var Cnt sbr recp]
-- QUITAR --, PCA.[Var Cnt SR Oms]
-- QUITAR --, PCA.[Días Zona Firme]
-- QUITAR --, PCA.[Precio Unit Omisión]
-- QUITAR --, PCA.[Tabla Fch Rotación]
-- QUITAR --, PCA.[Clasif de transp]
-- QUITAR --, PCA.[Reclasif Automática]
-- QUITAR --, PCA.[Loclzcn Planta]
-- QUITAR --, PCA.[Fórmula química]
-- QUITAR --, PCA.[Imprim C A]
-- QUITAR --, PCA.[Núm caja]
-- QUITAR --, PCA.[Categoría reglamet]
-- QUITAR --, PCA.[Trans DI Grp Substit]
-- QUITAR --, PCA.[Trans RC Grp Substit]
, PCA.[Recurso Universal]
-- QUITAR --, PCA.[N Días Adel Cons DAC]
-- QUITAR --, PCA.[Familia Programas]
-- QUITAR --, PCA.CODIGODEBARRAS3
-- QUITAR --, PCA.CODIGODEBARRAS4
-- QUITAR --, PCA.CODIGODEBARRAS5
-- QUITAR --, PCA.CODIGODEBARRAS6
-- QUITAR --, PCA.CODIGODEBARRAS7
-- QUITAR --, PCA.CODIGODEBARRAS9
-- QUITAR --, PCA.CODIGODEBARRAS10
-- QUITAR --, PCA.UNIDADMEDIDAUNIDADLOGISTICA03
-- QUITAR --, PCA.UNIDADMEDIDAUNIDADLOGISTICA04
-- QUITAR --, PCA.UNIDADMEDIDAUNIDADLOGISTICA05
-- QUITAR --, PCA.UNIDADMEDIDAUNIDADLOGISTICA06
-- QUITAR --, PCA.UNIDADMEDIDAUNIDADLOGISTICA07
-- QUITAR --, PCA.UNIDADMEDIDAUNIDADLOGISTICA09
-- QUITAR --, PCA.UNIDADMEDIDAUNIDADLOGISTICA10
-- QUITAR --, PCA.[NÚMERO DE PROVEEDOR]
-- QUITAR --, PCA.[CAM TEMP ZONA]
-- QUITAR --, PCA.[UM CNT ABAS CAJA REC]
-- QUITAR --, PCA.[PTO ABAST CAJA RECOL]
-- QUITAR --, PCA.[UM PTO ABAS CAJA REC]
-- QUITAR --, PCA.[INDI MÍNI WM]
-- QUITAR --, PCA.[CNT DEMAN MÍNI WM]
-- QUITAR --, PCA.[UM DEMAND MÍN WM]
-- QUITAR --, PCA.[Ingrese el Almacén]
-- QUITAR --, PCA.[Ingrese Localización]
-- QUITAR --, PCA.[Ingrese Proveedor]
-- QUITAR --, PCA.[Unidad Medida Origen]
-- QUITAR --, PCA.[Unidad Medida Dest]
-- QUITAR --, PCA.Almacén
-- QUITAR --, PCA.[Núm de localización]
-- QUITAR --, PCA.[Número Proveedor]
-- QUITAR --, PCA.[Cantidad Origen 1]
-- QUITAR --, PCA.[Cantidad Destino 1]
-- QUITAR --, PCA.[Cantidad Origen 2]
-- QUITAR --, PCA.[Cantidad Destino 2]
-- QUITAR --, PCA.[Cantidad Origen 3]
-- QUITAR --, PCA.[Cantidad Destino 3]
-- QUITAR --, PCA.[Cantidad Origen 4]
-- QUITAR --, PCA.[Cantidad Destino 4]
-- QUITAR --, PCA.[Cantidad Origen 5]
-- QUITAR --, PCA.[Cantidad Destino 5]
-- QUITAR --, PCA.[TE OC Nva Ver mns]
-- QUITAR --, PCA.[Valor Tabla GI Var]
-- QUITAR --, PCA.[Días Antigüedad 2]
-- QUITAR --, PCA.[Días Antigüedad 3]
-- QUITAR --, PCA.[Días Antigüedad 4]
-- QUITAR --, PCA.[Días Antigüedad 5]
-- QUITAR --, PCA.[RECUR RASTR UNID]
-- QUITAR --, UDM_CMPRS.[Código de Unidad de Medida],UDM_CMPRS.[Nombre de Unidad de Medida]
-- QUITAR --, PCOMPRAS.[Cód Aprob Proveedor Y N]
-- QUITAR --, PCOMPRAS.[Código Imponible]
, CAT_CMPRS.[Código de Categoría de Compras], CAT_CMPRS.[Nombre de Categoría de Compras]
, SUBCAT_CMPRS.[Código de Subcategoría de Compras],SUBCAT_CMPRS.[Nombre de Subcategoría de Compras]
, CAT_NEG.[Código de Categoría de Negociación],CAT_NEG.[Nombre de Categoría de Negociación]
, PEXT.[Descripción Larga del Producto]
-- QUITAR --, PEXT.[Número del Producto]
, PEXT.[Número Ficha Técnica]
, PEXT.[Unidad Empaque]
, T_ENV.[Código de Tipo de Envase],T_ENV.[Nombre de Tipo de Envase]
, CLV_MRCA.[Código de Clave de Marca],CLV_MRCA.[Nombre de Clave de Marca]
, CMPNIA_ALF.[Código de Compañia Alfabetica],CMPNIA_ALF.[Nombre de Compañia Alfabetica]
, CMPNIA_GS1.[Código de Compañia GS1],CMPNIA_GS1.[Nombre de Compañia GS1]
-- QUITAR --, PEXT.[Código de Barras GS1 8]
-- QUITAR --, PEXT.[Consecutivo EAN 13]
-- QUITAR --, PEXT.[Consecutivo DUN14]
-- QUITAR --, PEXT.[Consecutivo DUN14T]
-- QUITAR --, PEXT.[Cambio EAN 13]
-- QUITAR --, PEXT.[Cambio DUN14]
-- QUITAR --, PEXT.[Cambio DUN14T]
, CMPNIA_NUM.[Código de Compañia Numérica],CMPNIA_NUM.[Nombre de Compañia Numérica]
-- QUITAR --, PEXT.[Compañía AMECE]
, PEXT.[Precio de Venta]
, PEXT.[EAN 13]
, PEXT.DUN14
, PEXT.DUN14T
, PEXT.[ID de Origen]
, IMPSTS.[Codigo de Categoria Impuesto],IMPSTS.[Nombre de Impuestos]
, COMEN.[Código de Comentarios CB],COMEN.[Nombre de Comentarios CB]
, PEXT.[Componentes de la OF Pack]
, TDALMAC.[Código de Tipo de Almacenaje],TDALMAC.[Nombre de Tipo de Almacenaje]
, PDO.[Código de Politica de Orden],PDO.[Nombre de Politica de Orden]
, CDO.[Código de Origen],CDO.[Nombre de Origen]
-- QUITAR --, PPLAN.[Número de Planificador]
-- QUITAR --, PPLAN.[Cantidad Orden Prog Fijo]
-- QUITAR --, PPLAN.[Indicador Nueva Planif]
-- QUITAR --, PPLAN.[Ctn Orden Progr Min]
, PPLAN.[Inventario de Seguridad]
, COD_PMP.[Código de PMP],COD_PMP.[Nombre de PMP]
-- QUITAR --, PPLAN.[Ctn Orden Progr Máx]
, TMP_PLAN.[Código de Tipo MP Planificación],TMP_PLAN.[Nombre de Tipo MP Planificación]
-- QUITAR --, PPLAN.[Nombre MP Planif Prima]
-- QUITAR --, PPLAN.[Ctn Orden Progr Mul]
-- QUITAR --, PPLAN.[Cód Nivel Planif Fijo]
-- QUITAR --, PPLAN.[Cód Nivel Planificación]
-- QUITAR --, PPLAN.[Código Plazo Corto]
-- QUITAR --, PPLAN.[Código Plazo Largo]
-- QUITAR --, PPLAN.[Calc de Nvo Tiempo Espera]
-- QUITAR --, PPLAN.[Código Plazo Intermedio]
-- QUITAR --, PPLAN.[Código de Identificación]
-- QUITAR --, PPLAN.[Días de Abastecimiento]
, FH.[Código de Formato Helados],FH.[Nombre de Formato Helados]
, C_H.[Código de CAT Helados],C_H.[Nombre de CAT Helados]
, C_P_H.[Código de Presentación Helados],C_P_H.[Nombre de Presentación Helados]
, PH.DSD
, PCDB.[Peso Neto EAN 13]
, PCDB.[Peso Bruto EAN 13]
, UDM_EAN13_PESO.[Código de Unidad de Medida] AS ''Código de Unidad de Medida Peso EAN13'',UDM_EAN13_PESO.[Nombre de Unidad de Medida] as ''Nombre de Unidad de Medida Peso EAN13''
, UDM_EAN13_STD.[Código de Unidad de Medida] ''Código de Unidad de Medida Estandar EAN13'',UDM_EAN13_STD.[Nombre de Unidad de Medida]  as ''Nombre de Unidad de Medida Estandar EAN13''
, UDM_EAN13_DIM.[Código de Unidad de Medida] AS ''Código de Unidad de Medida Dimension EAN13'', UDM_EAN13_DIM.[Nombre de Unidad de Medida] as ''Nombre de Unidad de Medida Dimension EAN13''
, PCDB.[Volúmen Exterior EAN 13]
, PCDB.[Dimensión Interior Alto EAN 13]
, PCDB.[Dimensión Ext Alto EAN 13]
, PCDB.[Dimensión Interior Ancho EAN 13]
, PCDB.[Dimensión Ext Ancho EAN 13]
, PCDB.[Dimensión Interior Profundo EAN 13]
, PCDB.[Dimensión Ext Profundo EAN 13]
, UDM_DUN14_PESO.[Código de Unidad de Medida] AS ''Código de Unidad de Medida Peso DUN14'',UDM_DUN14_PESO.[Nombre de Unidad de Medida] as ''Nombre de Unidad de Medida Peso DUN14''
, UDM_DUN14_STD.[Código de Unidad de Medida] ''Código de Unidad de Medida Estandar DUN14'',UDM_DUN14_STD.[Nombre de Unidad de Medida]  as ''Nombre de Unidad de Medida Estandar DUN14''
, UDM_DUN14_DIM.[Código de Unidad de Medida] AS ''Código de Unidad de Medida Dimension DUN14'', UDM_DUN14_DIM.[Nombre de Unidad de Medida] as ''Nombre de Unidad de Medida Dimension DUN14''
, PCDB.[Peso Neto DUN14]
, PCDB.[Peso Bruto DUN14]
, PCDB.[Volúmen Exterior DUN14]
, PCDB.[Dimensión Interior Alto DUN14]
, PCDB.[Dimensión Ext Alto DUN14]
, PCDB.[Dimensión Interior Ancho DUN14]
, PCDB.[Dimensión Ext Ancho DUN14]
, PCDB.[Dimensión Interior Profundo DUN14]
, PCDB.[Dimensión Ext Profundo DUN14]
, UDM_DUN14T_PESO.[Código de Unidad de Medida] AS ''Código de Unidad de Medida Peso DUN14T'',UDM_DUN14T_PESO.[Nombre de Unidad de Medida] as ''Nombre de Unidad de Medida Peso DUN14T''
, UDM_DUN14T_STD.[Código de Unidad de Medida] ''Código de Unidad de Medida Estandar DUN14T'',UDM_DUN14T_STD.[Nombre de Unidad de Medida]  as ''Nombre de Unidad de Medida Estandar DUN14T''
, UDM_DUN14T_DIM.[Código de Unidad de Medida] AS ''Código de Unidad de Medida Dimension DUN14T'', UDM_DUN14T_DIM.[Nombre de Unidad de Medida] as ''Nombre de Unidad de Medida Dimension DUN14T''
, PCDB.[Peso Neto DUN14T]                        
, PCDB.[Peso Bruto DUN14T]
, PCDB.[Volúmen Exterior DUN14T]                        
, PCDB.[Dimensión Interior Alto DUN14T]
, PCDB.[Dimensión Ext Alto DUN14T]
, PCDB.[Dimensión Interior Ancho DUN14T]
, PCDB.[Dimensión Ext Ancho DUN14T]
, PCDB.[Dimensión Interior Profundo DUN14T]                        
, PCDB.[Dimensión Ext Profundo DUN14T]
, PDLD.[Tipo Producto Demantra]  
,POSN.[Precio de Venta C Impuesto],
 POSN.CostoF,
 POSN.[Clave Tipo_Name],
 POSN.[Clave Area_Name],
 POSN.[Clave de Uso_Code],
 POSN.[Clave de Uso_Name],
 POSN.[Tipo Nutrisa_Code],
 POSN.[Tipo Nutrisa_Name],
 POSN.Sabor_Name,
 POSN.[Código de Impuesto_Name],
 POSN.Unidades,
POSN.Compuesto,
 POSN.[Unidad de Medida Estándar POS_Name],
 POSN.[CEN Recurso Agrupacion_Name],
 POSN.[CEN Recurso Categoria_Name],
 POSN.[CEN Recurso Categoria 1_Name],
 POSN.[CEN Recurso Categoria 2_Name],
 POSN.[CEN Recurso Sabor_Name],
 POSN.[CEN Recurso Origen_Name]


FROM                  HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Productos AS P 
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Productos_Almacenes AS PA ON PA.[Codigo de Producto_ID] = P.ID 
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vWMDM_Productos_Costos AS PC ON PC.[Codigo de Producto_ID] = P.ID AND PC.Entidad = ''ALMACENES'' 
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_ProductosAseguramientoCalidad AS PAC ON PAC.[Codigo de Producto_ID] = P.ID 
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_ProductosCampos_Adicionales AS PCA ON PCA.[Codigo de Producto_ID] = P.ID 
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_ProductosCompras AS PCOMPRAS ON PCOMPRAS.[Codigo de Producto_ID] = P.ID 
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_ProductosExtendido AS PEXT ON PEXT.[Codigo de Producto_ID] = P.ID 
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_ProductosPlaneacion AS PPLAN ON PPLAN.[Codigo de Producto_ID] = P.ID 
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_ModeloProductosHelados AS PH ON PH.[Codigo de Producto_ID] = P.ID 
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Productos_Codigo_de_Barras AS PCDB ON PCDB.[Codigo de Producto_ID] = P.ID 
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_PlandeDemanda AS PDLD ON PDLD.[Codigo de Producto_ID] = P.ID 
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Sabor_Helados AS SHMT ON PH.Sabor_ID = SHMT.ID 
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Origen O on  O.ID=P.Origen_ID
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_TipoDeProducto  TDP ON TDP.ID=P.[Tipo de Producto_ID] 
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_MarcaPDescripción M on M.ID=P.[Marca P Descripción_ID]
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Clase C on C.ID=P.Clase_ID
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vmMDM_PD_Tipo_De_Envase TE ON TE.ID=P.[Tipo de Envase_ID]
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_SubClase SC ON SC.ID=P.[Sub Clase_ID]
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_UnidadesDeMedida UDM_P ON UDM_P.ID=P.[Unidad de Medida de Peso_ID]
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_UnidadesDeMedida UDM_E ON UDM_E.ID=P.[Unidad de Medida Estándar_ID]
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_UnidadesDeMedida UDM_M ON UDM_M.ID=P.[Unidad de Medida P Descripción_ID]
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_CódigoABC  AS C_ABC ON C_ABC.ID=P.[Código ABC_ID]
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_PD_Mercado AS MRCD ON MRCD.ID=P.Mercado_ID
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Tipo AS TPO ON TPO.ID=P.Tipo_ID
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Linea LN on LN.ID=p.Linea_ID
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Impuestos  I on I.ID=P.[Catégoria de Impuesto_ID]
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Miscelaneos1 ST  on ST.ID=P.Status_ID
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_PlantaArmadoClaveMe PA_CLV on PA_CLV.ID=P.[Planta Armado Clave_ID]
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Tipo_Acum_Costo TACSTO                   ON TACSTO.ID      = PC.[Código Tipo Acum Costo_ID] 
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Costo_Unitario_Seleccionado CUS ON CUS.ID=PC.[Costo Unitario Seleccionado_ID] AND PC.Entidad=''ALMACENES''
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Clase_Nivel_Acum_Costo CNACSTO ON CNACSTO.ID=PC.[Cód Clase Nivel Acum Cost_ID] AND PC.Entidad=''ALMACENES''
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Metodo_Costeo_Acum_Costo CACSTO ON CACSTO.ID=PC.[Mét Costeo Acum Costo_ID] AND PC.Entidad=''ALMACENES''
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_UnidadesDeMedida UDM_CMPRS ON UDM_CMPRS.ID = PCOMPRAS.[UM Compras_ID]
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.viw_SYSTEM_21_1280_CHILDATTRIBUTES CAT_CMPRS on CAT_CMPRS.ID= PCOMPRAS.[Categoría de Compras_ID]
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.viw_SYSTEM_21_1338_CHILDATTRIBUTES SUBCAT_CMPRS ON SUBCAT_CMPRS.ID=PCOMPRAS.[Subcategoría de Compras_ID]
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_CategoriaDeNegociacion CAT_NEG  on CAT_NEG.ID=PCOMPRAS.[Categoría de Negociación_ID]
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_TipoDeEnvase T_ENV ON T_ENV.ID=PEXT.[Tipo Empaque Primario_ID]
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_ClaveDeMarca CLV_MRCA ON CLV_MRCA.ID = PEXT.[Clave de Marca_ID]
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_CompaniaAlfabetica CMPNIA_ALF ON CMPNIA_ALF.ID=PEXT.[Clave Compañía Alfanum_ID]
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_PD_CompaniasGS1 CMPNIA_GS1 on CMPNIA_GS1.ID = PEXT.[Compañía GS1_ID]
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_PD_CompaniasNumerica CMPNIA_NUM ON CMPNIA_NUM.ID= PEXT.[Número de Compañía_ID]
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Impuestos IMPSTS ON IMPSTS.ID=PEXT.[Categoría de Impuestos_ID]
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_PD_ComentariosCB COMEN ON COMEN.ID=PEXT.Comentarios_ID
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vmMDM_Tipo_De_Almacenaje TDALMAC on TDALMAC.ID=PEXT.[Tipo de Almacenaje_ID]
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_PoliticaDeOrden PDO ON PDO.ID= PPLAN.[Cód Política Orden Programa_ID]
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_CódigoDeOrigen CDO ON CDO.ID=PPLAN.[Código Origen M P_ID]
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_CodigoPMP COD_PMP ON  COD_PMP.ID=PPLAN.[Código PMP_ID]
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_TipoMPPlanificacion TMP_PLAN ON TMP_PLAN.ID=PPLAN.[Tipo MP Planificación Prima_ID]
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Formato_Helados FH on FH.ID=PH.[Codigo de Producto_ID]
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_PD_CATHelados C_H ON C_H.ID= PH.CAT_ID
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Presentacion_Helados C_P_H on C_P_H.ID =PH.Presentación_ID
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_UnidadesDeMedida UDM_EAN13_PESO ON  UDM_EAN13_PESO.ID = PCDB.[Unidad Medida Peso EAN 13_ID]
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_UnidadesDeMedida UDM_EAN13_STD ON  UDM_EAN13_STD.ID = PCDB.[Unidad Medida Estándar EAN 13_ID]
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_UnidadesDeMedida UDM_EAN13_DIM ON  UDM_EAN13_DIM.ID = PCDB.[Unidad Medida Dimensión EAN 13_ID]
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_UnidadesDeMedida UDM_DUN14_PESO ON  UDM_DUN14_PESO.ID = PCDB.[Unidad Medida Peso DUN14_ID]
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_UnidadesDeMedida UDM_DUN14_STD ON  UDM_DUN14_STD.ID = PCDB.[Unidad Medida Estándar DUN14_ID]
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_UnidadesDeMedida UDM_DUN14_DIM ON  UDM_DUN14_DIM.ID = PCDB.[Unidad Medida Dimensión DUN14_ID]
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_UnidadesDeMedida UDM_DUN14T_PESO ON  UDM_DUN14T_PESO.ID = PCDB.[Unidad Medida Peso DUN14T_ID]
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_UnidadesDeMedida UDM_DUN14T_STD ON  UDM_DUN14T_STD.ID = PCDB.[Unidad Medida Estándar DUN14T_ID]
LEFT OUTER JOIN      HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_UnidadesDeMedida UDM_DUN14T_DIM ON  UDM_DUN14T_DIM.ID = PCDB.[Unidad Medida Dimensión DUN14T_ID]
LEFT OUTER JOIN     HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_PosNutrisa AS POSN ON P.ID = POSN.[Código de Producto_ID]

WHERE 1=1 '


IF @BANDERA = 'T' 
    BEGIN
        EXEC sp_executesql @SQL
    END
ELSE IF  @BANDERA = 'P' 
    BEGIN
        select @KnProduct=ID from HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Productos WHERE [Número de Recurso]=@RecursoID
        SET @FILTRO = 'AND P.ID='+@KnProduct
        SET @SQL= @SQL+@FILTRO
        EXEC sp_executesql @SQL
    END
ELSE 
    BEGIN
            Select 'Revise los parametros que ingresaron'
    END


END

