SELECT * FROM HDZNT169.DWH_CDC.dbo.recurso where id_recurso='015005'

USE MDMHERDEZCI
GO

UPDATE BS_HDZALM_RESMST
SET RMTXCC = 'G00'
WHERE RMRESC = '105014'

GO

TRUNCATE TABLE BS_TMP1_Recurso

GO

INSERT INTO BS_TMP1_Recurso
select 
	CASE 
	   WHEN RTRIM(MST.RMRESC) IN ('475001','475013')
	   THEN 'N'+RTRIM(MST.RMRESC)
	   ELSE RTRIM(MST.RMRESC)
	END  as ID_Recurso, 
	CASE 
	   WHEN RTRIM(MST.RMRESC) IN ('475001','475013')
	   THEN 'N'+RTRIM(MST.RMRESC)
	   ELSE RTRIM(MST.RMRESC)
	END + ' ' + LTRIM(RTRIM(SUBSTRING(MST.RMDESC,1,30))) as Recurso, 
	RTRIM(RMDESC) as Recurso_C, 
	LTRIM(RTRIM(MST.RMUMSR)) as RecursoUMEstandar, 
	CASE 
		WHEN MST.RMMIS1 ='0Q'
		THEN 0
		ELSE convert(int,LTRIM(RTRIM(MST.RMMIS1)))
	END
	 as ID_TipoRecurso, 
	LTRIM(RTRIM(MST.RMABCC)) as ID_RecursoCodigoABC, 
	LTRIM(RTRIM(MST.RMMIS3)) as RecursoPresentacion, 
	LTRIM(RTRIM(RMWTUM)) as RecursoUMPeso, 
	CONVERT(NUMERIC(15,6),MST.RMNETW) as RecursoPesoNeto, 
	CONVERT(NUMERIC(15,6),MST.RMWGHT) as RecursoPesoLogistico, 
	CONVERT(NUMERIC(15,6),MST.RMSTDC) as RecursoCostoUnitario, 
	CONVERT(NUMERIC(15,6),MST.RMSELP) as RecursoPrecioLista,
	--RTRIM(LTRIM(SUBSTRING(LTRIM(RTRIM(MSA.CASA)),1,1)+RIGHT('00' + MST.RMRSSC,3))) AS ID_RecursoLinea,
	RTRIM(LTRIM(SUBSTRING(LTRIM(RTRIM(MSA.CASA)),1,1)+RIGHT('00' + MST.RMMKPL,3))) AS ID_RecursoLinea,
	SPACE(40) AS RecursoLinea,
	SUBSTRING(LTRIM(RTRIM(MSA.CASA)),1,1) AS ID_RecursoMarca,
	SPACE(40) AS RecursoMarca,
	SUBSTRING(LTRIM(RTRIM(MSA.CIAALFA)),1,1) AS ID_RecursoCompania, 
	SPACE(60) AS RecursoCompania,
	CONVERT(INT,LTRIM(RTRIM(MSA.CIA))) AS ID_RecursoCompaniaContable,
	SPACE(60) AS RecursoCompaniaContable,
	CONVERT(NUMERIC(15,6),MST.RMMIS2) AS RecursoCjEq,
	CONVERT(NUMERIC(15,6),MST.RMMIS2) AS RecursoPzEq,
	CONVERT(NUMERIC(15,6),MST.RMMIS2) AS RecursoKgEq,
	CONVERT(NUMERIC(15,6),MST.RMMIS2) AS RecursoTmEq,
	CONVERT(NUMERIC(15,6),MST.RMMIS2) AS RecursoCostoCj,
	CONVERT(NUMERIC(15,6),MST.RMMIS2) AS RecursoCostoPz,
	CONVERT(NUMERIC(15,6),MST.RMMIS2) AS RecursoCostoKg,
	CONVERT(NUMERIC(15,6),MST.RMMIS2) AS RecursoCostoTm,
	ROUND((CONVERT(INT,CASE SUBSTRING(LTRIM(RTRIM(MST.RMTXCC)),2,2) WHEN 'OO' THEN '00' ELSE SUBSTRING(LTRIM(RTRIM(MST.RMTXCC)),2,2) END) /100.0),2) AS RecursoIVA,
	ROUND((CONVERT(INT,CASE SUBSTRING(LTRIM(RTRIM(MSA.CATIMPUESTOS2)),2,2) WHEN 'OO' THEN '00' ELSE SUBSTRING(LTRIM(RTRIM(MSA.CATIMPUESTOS2)),2,2) END)/100.0),2) AS RecursoIEPS,
	0  AS RecursoClave,
	SPACE(75) AS RecursoAgrupacion,
	SPACE(75) AS RecursoTipo,
	MSA.CODBARRASUNCONSUMO AS RecursoCodigoBarras,
	'***Administrado***' AS RecursoCategoriaPlaneacion,
	MST.RMSHLD AS RecursoVidaUtil,
	0 AS ID_RecursoCategoria,
	SPACE(75) AS RecursoCategoria,
	1 AS RecursoDemantra,
	SPACE(5) ID_RecursoCategoria1,
	SPACE(35) RecursoCategoria1,
	SPACE(5) ID_RecursoCategoria2,
	SPACE(35) RecursoCategoria2,
	0 as ID_RecursoGrupoCompania,
	SPACE(75) RecursoGrupoCompania,
	0 ID_RecursoManufactura,
	SPACE(75) RecursoManufactura,
	-1 Recurso_IDSK_SegmentacionRecurso
	,RMRSCL AS RecursoFuenteClase
	,'HDZALM'              AS RecursoEntidad
	,SPACE(10) [RecursoClasificacionLogistica]
	,'***Administrado***' [RecursoFormato]
	,RMSUTR AS RecursoCajasXCama
	,RMSTHT AS RecursoApilabilidad
	,NULL AS ID_Recurso_BuildingBlock
	,NULL AS Recurso_BuildingBlock
	,NULL AS ID_RecursoBase
	,NULL AS RecursoBase
	,NULL  AS [RecursoInnovacion]
	, '-1' ID_SAT
     , '***ADMINISTRADO***'  DescripcionSAT

From BS_HDZALM_RESMST MST
LEFT JOIN BS_HDZALM_RESMSA MSA ON RMRESC = NOPRODUCTO
Where 1=1
AND RMRSCL = 'PT' 
AND ( RTRIM(LTRIM(SUBSTRING(LTRIM(RTRIM(MSA.CASA)),1,1)+RIGHT('00' + MST.RMRSSC,3))) IS NOT NULL
OR SUBSTRING(LTRIM(RTRIM(MSA.CASA)),1,1) IS NOT NULL
OR SUBSTRING(LTRIM(RTRIM(MSA.CIAALFA)),1,1) IS NOT NULL
OR MSA.CODBARRASUNCONSUMO IS NOT NULL)
AND SUBSTRING(LTRIM(RTRIM(MSA.CIAALFA)),1,1) NOT IN ('J','O')
AND SUBSTRING(LTRIM(RTRIM(MSA.CASA)),1,1) !='N'




SELECT 
	RTRIM(MST.RMRESC) as ID_Recurso, 
	RTRIM(MST.RMRESC) + ' ' + LTRIM(RTRIM(SUBSTRING(MST.RMDESC,1,30))) as Recurso, 
	RTRIM(RMDESC) as Recurso_C, 
	LTRIM(RTRIM(MST.RMUMSR)) as RecursoUMEstandar, 
   CASE 
		WHEN MST.RMMIS1 ='0Q'
		THEN 0
		ELSE convert(int,LTRIM(RTRIM(MST.RMMIS1)))
	END
	 as ID_TipoRecurso, 
	LTRIM(RTRIM(MST.RMABCC)) as ID_RecursoCodigoABC, 
	LTRIM(RTRIM(MST.RMMIS3)) as RecursoPresentacion, 
	LTRIM(RTRIM(RMWTUM)) as RecursoUMPeso, 
	CONVERT(NUMERIC(15,6),MST.RMNETW) as RecursoPesoNeto, 
	CONVERT(NUMERIC(15,6),MST.RMWGHT) as RecursoPesoLogistico, 
	CONVERT(NUMERIC(15,6),MST.RMSTDC) as RecursoCostoUnitario, 
	CONVERT(NUMERIC(15,6),MST.RMSELP) as RecursoPrecioLista,
	--RTRIM(LTRIM(SUBSTRING(LTRIM(RTRIM(MSA.CASA)),1,1)+RIGHT('00' + MST.RMRSSC,3))) AS ID_RecursoLinea,
	RTRIM(LTRIM(SUBSTRING(LTRIM(RTRIM(MSA.CASA)),1,1)+RIGHT('00' + MST.RMMKPL,3))) AS ID_RecursoLinea,
	SPACE(40) AS RecursoLinea,
	SUBSTRING(LTRIM(RTRIM(MSA.CASA)),1,1) AS ID_RecursoMarca,
	SPACE(40) AS RecursoMarca,
	SUBSTRING(LTRIM(RTRIM(MSA.CIAALFA)),1,1) AS ID_RecursoCompania, 
	SPACE(60) AS RecursoCompania,
	CONVERT(INT,LTRIM(RTRIM(MSA.CIA))) AS ID_RecursoCompaniaContable,
	SPACE(60) AS RecursoCompaniaContable,
	CONVERT(NUMERIC(15,6),MST.RMMIS2) AS RecursoCjEq,
	CONVERT(NUMERIC(15,6),MST.RMMIS2) AS RecursoPzEq,
	CONVERT(NUMERIC(15,6),MST.RMMIS2) AS RecursoKgEq,
	CONVERT(NUMERIC(15,6),MST.RMMIS2) AS RecursoTmEq,
	CONVERT(NUMERIC(15,6),MST.RMMIS2) AS RecursoCostoCj,
	CONVERT(NUMERIC(15,6),MST.RMMIS2) AS RecursoCostoPz,
	CONVERT(NUMERIC(15,6),MST.RMMIS2) AS RecursoCostoKg,
	CONVERT(NUMERIC(15,6),MST.RMMIS2) AS RecursoCostoTm,
	--ROUND((CONVERT(INT,CASE SUBSTRING(LTRIM(RTRIM(MST.RMTXCC)),2,2) WHEN 'OO' THEN '00' ELSE SUBSTRING(LTRIM(RTRIM(MST.RMTXCC)),2,2) END) /100.0),2) AS RecursoIVA,
	0.000000 AS RecursoIVA,
	ROUND((CONVERT(INT,CASE SUBSTRING(LTRIM(RTRIM(MSA.CATIMPUESTOS2)),2,2) WHEN 'OO' THEN '00' ELSE SUBSTRING(LTRIM(RTRIM(MSA.CATIMPUESTOS2)),2,2) END)/100.0),2) AS RecursoIEPS,
	0  AS RecursoClave,
	SPACE(75) AS RecursoAgrupacion,
	SPACE(75) AS RecursoTipo,
	ISNULL (MSA.CODBARRASUNCONSUMO, -1) AS RecursoCodigoBarras, --Se detectó registros en NULL, se están registrando en -1
	'***Administrado***' AS RecursoCategoriaPlaneacion,
	MST.RMSHLD AS RecursoVidaUtil,
	0 AS ID_RecursoCategoria,
	SPACE(75) AS RecursoCategoria,
	1 AS RecursoDemantra,
	SPACE(5) ID_RecursoCategoria1,
	SPACE(35) RecursoCategoria1,
	SPACE(5) ID_RecursoCategoria2,
	SPACE(35) RecursoCategoria2,
	0 as ID_RecursoGrupoCompania,
	SPACE(75) RecursoGrupoCompania,
	0 ID_RecursoManufactura,
	SPACE(75) RecursoManufactura,
	-1 Recurso_IDSK_SegmentacionRecurso,
	RMRSCL AS RecursoFuenteClase,
	'HDZGPO'              AS RecursoEntidad
	,SPACE(10) [RecursoClasificacionLogistica]
	,'***Administrado***' [RecursoFormato]
	,RMSUTR AS RecursoCajasXCama
	,RMSTHT AS RecursoApilabilidad
	,NULL AS ID_Recurso_BuildingBlock
	,NULL AS Recurso_BuildingBlock
	,NULL AS ID_RecursoBase
	,NULL AS RecursoBase
	,NULL  AS [RecursoInnovacion]
	, '-1' ID_SAT
	, '***ADMINISTRADO***'  DescripcionSAT
From BS_HDZGPO_RESMST MST
LEFT JOIN BS_HDZGPO_RESMSA MSA ON RMRESC = NOPRODUCTO
WHERE  SUBSTRING(LTRIM(RTRIM(Isnull(MSA.CIAALFA,'-'))),1,1) NOT IN ('J','O')  -- j es Nutrisa O es Olyen Coffee
AND NOT EXISTS (Select 1 from BS_TMP1_Recurso  TMP1 where TMP1.ID_Recurso=MST.RMRESC) 
AND SUBSTRING(LTRIM(RTRIM(Isnull(MSA.CASA,'-'))),1,1) !='N'



--****Nestle****

SELECT RTRIM (RN.[ID_Herdez]) AS ID_Recurso
,CAST ( RN.[ID_Herdez] AS VARCHAR (40) ) +' '+ RN.[DescripcionStd]   AS  Recurso
,RN.[DescripcionStd]                             AS Recurso_C
,'CJ' AS RecursoUMEstandar
,'10' AS ID_TipoRecurso
,'-'  AS ID_RecursoCodigoABC
,'-'  AS RecursoPresentacion
,'-'  AS RecursoUMPeso
,'0.000000' AS        RecursoPesoNeto
,'0.000000' AS RecursoPesoLogistico
,'0.000000' AS        RecursoCostoUnitario
,'0.000000' AS RecursoPrecioLista
,RN.[ID_Linea] AS ID_RecursoLinea
,RN.Linea AS RecursoLinea
,RN.[ID_Marca] AS ID_RecursoMarca
,RN.Marca AS RecursoMarca 
,'H' AS ID_RecursoCompania
,'H Compañia Comercial Herdez, S.A. de C.V.'             AS RecursoCompania
,'79' AS ID_RecursoCompaniaContable
,'079 ALIMENTOS BENEFITS S.A. DE C.V.' AS RecursoCompaniaContable
,'1.000000' AS RecursoCjEq
,'1.000000' AS RecursoPzEq
,'1.000000' AS RecursoKgEq
,'1.000000' AS RecursoTmEq
,'1.000000' AS RecursoCostoCj
,'1.000000' AS RecursoCostoPz
,'1.000000' AS RecursoCostoKg
,'1.000000' AS RecursoCostoTm
,'0.000000' AS RecursoIVA
,'0.000000' AS RecursoIEPS
,0 AS RecursoClave
,'-' AS RecursoAgrupacion
,'Descontinuados' AS   RecursoTipo
,'0' AS RecursoCodigoBarras
,'Sin Categoria' AS RecursoCategoriaPlaneacion
,0 AS RecursoVidaUtil
,0 AS ID_RecursoCategoria
,'-' AS RecursoCategoria
,0 AS RecursoDemantra
,'-' AS ID_RecursoCategoria1
,'-' AS RecursoCategoria1
,'-' AS ID_RecursoCategoria2
,'-' AS RecursoCategoria2
,0 AS ID_RecursoGrupoCompania
,'-' AS RecursoGrupoCompania
,0 AS ID_RecursoManufactura
,'-' AS RecursoManufactura
,'-1' AS Recurso_IDSK_SegmentacionRecurso
,'PT' AS RecursoFuenteClase
,RN.RecursoEntidad
,SPACE(10) [RecursoClasificacionLogistica]
,'***Administrado***' [RecursoFormato]
,0 AS RecursoCajasXCama
,0 AS RecursoApilabilidad
,NULL AS ID_Recurso_BuildingBlock
,NULL AS Recurso_BuildingBlock
,NULL AS ID_RecursoBase
,NULL AS RecursoBase
,NULL  AS [RecursoInnovacion]
, '-1' ID_SAT
, '***ADMINISTRADO***'  DescripcionSAT
FROM BS_TMP1_Recurso RH
RIGHT JOIN BS_S0_RecursoHelados RN
ON RH.ID_Recurso = CAST ( RN.[ID_Herdez] AS VARCHAR (15) )
WHERE RH.ID_Recurso IS  NULL

---Recursos Dummies MDM----

SELECT RTRIM(D.[Recurso Dummy]),
       CAST (RTRIM(D.[Recurso Dummy])+' '+UPPER(RTRIM(D.[Descripción Completa Dummy])) AS VARCHAR (100)),
       CAST (UPPER(RTRIM(D.[Descripción Completa Dummy]))AS VARCHAR (100)),
       D.[Recurso UM Estandar],
       '99' AS ID_TipoRecurso,
       '-' AS ID_RecursoCodigoABC,
       D.[Recurso Presentacion],
       D.[Recurso UMPeso],
       --CASE WHEN R.RecursoClasificacionLogistica ='SECOS' THEN D.[Peso Producto] ELSE 1 END,
       D.[Peso Producto],
       D.[RecursoPesoLogistico],
       D.[Recurso Costo Unitario],
       D.[Recurso Precio Lista],
       R.ID_RecursoLinea,
       R.RecursoLinea,
       R.ID_RecursoMarca,
       R.RecursoMarca,
       R.ID_RecursoCompania,
       R.RecursoCompania,
       R.ID_RecursoCompaniaContable,
       R.RecursoCompaniaContable,
       1 RecursoCjEq,
       1 RecursoPzEq,
       1 RecursoKgEq,
       1 RecursoTmEq,
       0 RecursoCostoCj,
       0 RecursoCostoPz,
       0 RecursoCostoKg,
       0 RecursoCostoTm,
       0 RecursoIVA,
       0 RecursoIEPS,
       R.RecursoClave,
       R.RecursoAgrupacion,
       D.[Tipo Iniciativa] AS RecursoTipo,
       0 AS RecursoCodigoBarras,
       R.RecursoCategoriaPlaneacion,
       R.RecursoVidaUtil,
       R.ID_RecursoCategoria,
       R.RecursoCategoria,
       R.RecursoDemantra,
       R.ID_RecursoCategoria1,
       R.RecursoCategoria1,
       R.ID_RecursoCategoria2,
       R.RecursoCategoria2,
       R.ID_RecursoGrupoCompania,
       R.RecursoGrupoCompania,
       R.ID_RecursoManufactura,
       R.RecursoManufactura,
       -1 Recurso_IDSK_SegmentacionRecurso,
       R.RecursoFuenteClase,
       R.RecursoEntidad,
       R.RecursoClasificacionLogistica,
       R.RecursoFormato,
       R.RecursoCajasXCama,
       R.RecursoApilabilidad,
	   NULL ID_Recurso_BuildingBlock,
	   NULL Recurso_BuildingBlock
		 ,NULL AS ID_RecursoBase
	   ,NULL AS RecursoBase
	   ,NULL  AS [RecursoInnovacion]
	   , '-1' ID_SAT
        , '***ADMINISTRADO***'  DescripcionSAT
FROM BS_RecursosDummies D
INNER JOIN BS_TMP1_Recurso R ON D.[Recurso Base] COLLATE Modern_Spanish_CI_AS 
     = R.ID_Recurso COLLATE Modern_Spanish_CI_AS
WHERE NOT EXISTS
(
    SELECT 1
    FROM BS_TMP1_Recurso T1
    WHERE T1.ID_Recurso = D.[Recurso Dummy]	  COLLATE Modern_Spanish_CI_AS
);

-- Actualiza Marca (Casa)
Update BS_TMP1_Recurso --Agregado SMAP 04102011
	SET Recurso = RTRIM(LTRIM(ID_Recurso)) + ' ' + '***Administrado***'
	WHERE Recurso = '' OR Recurso = '0'

Update BS_TMP1_Recurso
SET RecursoMarca = UPPER(RTRIM(ST2) + ' ' + RTRIM(Cat.ST3))
FROM BS_HDZMEN_FF01 Cat
	WHERE 	Cat.APL = 'EST'			
	AND 	Cat.ST1 = '102'
	AND     SUBSTRING(Cat.ST2,1,1) = ID_RecursoMarca 
	AND     SUBSTRING(Cat.ST2,2,1) <> '*' 

--SE MODIFICA  LOS CAMPOS NULOS  DE MARCA	
Update BS_TMP1_Recurso
	SET RecursoMarca = CASE ISNULL(RecursoMarca,'')
	WHEN '' THEN '***' ELSE RecursoMarca END

-- Actualiza Linea
Update BS_TMP1_Recurso
	SET ID_RecursoLinea = 'H999' --Agregado SMAP 04102011
	WHERE ID_RecursoLinea = '' OR ID_RecursoLinea = '0'

UPDATE R
SET R.RecursoLinea = RIGHT('00' + CAST(L.NUMEROLINEA AS VARCHAR(30)) , 3) + ' '+ L.NOMBRELINEA
FROM BS_TMP1_Recurso R
INNER JOIN BS_HDZMEN_MLINF L
	ON R.ID_RecursoLinea = MARCAREC + RIGHT('00' + CAST(NUMEROLINEA AS VARCHAR(30)) , 3)

Update BS_TMP1_Recurso --Agregado SMAP 04102011
SET RecursoLinea = SUBSTRING ( RTRIM(LTRIM(ID_RecursoLinea)),2,LEN(ID_RecursoLinea)) + ' ' + '***Administrado***'
WHERE RecursoLinea = '' OR RecursoLinea = '0' 

--SE ACTUALIZA LA COMPAÑIA
Update BS_TMP1_Recurso
SET RecursoCompania= RTRIM(ST2) + ' ' + RTRIM(Cat.ST3)
FROM BS_HDZMEN.FF01 Cat
WHERE 	Cat.APL = 'GR2'			
AND 	Cat.ST1 = '41'
AND     SUBSTRING(Cat.ST2,1,1) = ID_RecursoCompania

--SE MODIFICA LOS CAMPOS NULOS DE COMPAÑIA	
Update BS_TMP1_Recurso 
SET RecursoCompania = CASE	ISNULL(RecursoCompania,'') WHEN '' THEN '***' ELSE RecursoCompania END

--SE ACTUALIZA CAMPO CLAVE DE AGRUPACION
Update BS_TMP1_Recurso
SET RecursoClave = 5
,   RecursoAgrupacion = 'Otros'
,   ID_RecursoGrupoCompania = 3 
,   RecursoGrupoCompania  = 'Otros'

Update BS_TMP1_Recurso
SET RecursoClave = AG.ID_AgrupacionGerencial,
RecursoAgrupacion = AG.AgrupacionGerencialAgrupacion,
ID_RecursoGrupoCompania = AG.ID_AgrupacionGerencialGrupoCompania,
RecursoGrupoCompania  = AG.AgrupacionGerencialGrupoCompania
FROM BS_W1_AgrupacionGerencial AS AG
WHERE AG.AgrupacionGerencialMarca = BS_TMP1_Recurso.ID_RecursoMarca
and isnull(AG.ID_LineaAgrupacionGerencial,'') = ''

--SE ACTUALIZA CAMPO IDGrupo Compania
Update BS_TMP1_Recurso
SET RecursoClave = AG.ID_AgrupacionGerencial
,   RecursoAgrupacion = AG.AgrupacionGerencialAgrupacion
,   ID_RecursoGrupoCompania = AG.ID_AgrupacionGerencialGrupoCompania
,   RecursoGrupoCompania  = AG.AgrupacionGerencialGrupoCompania
FROM BS_W1_AgrupacionGerencial AS AG
WHERE AG.AgrupacionGerencialMarca = BS_TMP1_Recurso.ID_RecursoMarca
and right(BS_TMP1_Recurso.ID_RecursoLinea,2) = AG.ID_LineaAgrupacionGerencial
and isnull(AG.ID_LineaAgrupacionGerencial,'') <> ''


Update BS_TMP1_Recurso
SET ID_RecursoCategoria = 35, RecursoCategoria = 'Sin Categoría'

----drop table #Categoria
IF OBJECT_ID('tempdb..#Categoria') IS NOT NULL DROP TABLE #Categoria
GO

SELECT PROD, DCAT, RTRIM(LEFT(ST3,39)) AS ST3
INTO #Categoria
FROM BS_HDZPC_EF803
INNER JOIN BS_TMP1_Recurso ON PROD = ID_Recurso
INNER JOIN BS_HDZMEN_FF01 ON DCAT = ST2
WHERE APL = 'EST' AND ST1 = 224



Update BS_TMP1_Recurso
SET ID_RecursoCategoria = DCAT,
RecursoCategoria = ST3
FROM #Categoria
WHERE PROD = ID_Recurso

UPDATE BS_TMP1_Recurso
SET RecursoTipo = P.ST3
FROM BS_HDZMEN_FF01 AS P
WHERE	ID_TipoRecurso = P.ST2
AND	P.APL = 'GR2'
AND P.ST1 = 77

Update BS_TMP1_Recurso
SET RecursoTipo = '* AdministraTipo'
WHERE ID_Recurso = '999999'
AND ID_TipoRecurso = 0 
	
Update BS_TMP1_Recurso
SET RecursoTipo = '* AdministraTipo'
WHERE ID_TipoRecurso = 0 
AND RecursoTipo IS NULL

Update BS_TMP1_Recurso
SET RecursoCompaniaContable = '001 HERDEZ, S.A. DE C.V.', ID_RecursoCompaniaContable = 1
WHERE ID_RecursoCompaniaContable = 0

Update BS_TMP1_Recurso
SET RecursoCompaniaContable = RIGHT('000'+CONVERT(VARCHAR,CIA),3) + ' ' + NCIA
FROM BS_HDZGR2_HF01
WHERE ID_RecursoCompaniaContable = CIA

Update BS_TMP1_Recurso
SET RecursoDemantra=0
FROM BS_HDZMEN_FF01
WHERE APL='EST'
AND ST1=137 
AND RTRIM(LTRIM(ID_Recurso))=RTRIM(LTRIM(ST2))

Update BS_TMP1_Recurso
SET RecursoDemantra=1
FROM BS_Demantra_T_SRC_ITEM_NW
WHERE Demantra.T_SRC_ITEM_NW.IDRecurso = BS_TMP1_Recurso.ID_Recurso

Update BS_TMP1_Recurso
SET		ID_RecursoManufactura = CASE WHEN RMWHFM = 'M' THEN 1 ELSE 2 END,
RecursoManufactura = CASE WHEN RMWHFM = 'M' THEN 'Producción'  ELSE 'Compra' END
FROM	BS_HDZALM_RESMST
WHERE	RMRESC = ID_Recurso

Update BS_TMP1_Recurso
Set RecursoCategoriaPlaneacion=Isnull(RecursoCategoria,'***Administrado***')

Update BS_TMP1_Recurso
Set RecursoCategoria=Isnull(RecursoCategoria1, '***Administrado***'), ID_RecursoCategoria=ID_RecursoCategoria1


/****************    Categoria MK 20130628  ****************/
Update BS_TMP1_Recurso
SET ID_RecursoCategoria1 = '000',
RecursoCategoria1 = '000 Otros',
ID_RecursoCategoria2     = '000',
RecursoCategoria2 = '000 Otros'

Update BS_TMP1_Recurso
SET ID_RecursoCategoria = right('000'+rtrim(convert(char,A.IDCategoria)),3),
RecursoCategoria = right('000'+rtrim(convert(char,A.IDCategoria)),3)+' '+RTRIM(A.Categoria),
 ID_RecursoCategoria1 = right('000'+rtrim(convert(char,A.IDCategoria)),3),
RecursoCategoria1 = right('000'+rtrim(convert(char,A.IDCategoria)),3)+' '+RTRIM(A.Categoria),
ID_RecursoCategoria2     = right('000'+rtrim(convert(char,A.IDPlataforma)),3),
RecursoCategoria2 = right('000'+rtrim(convert(char,A.IDPlataforma)),3)+' '+RTRIM(A.Plataforma)
FROM BS_W1_RecursoCategoriaMercadotecnia A
WHERE RIGHT(BS_TMP1_Recurso.ID_RecursoLinea,3) = A.IDLinea

/*********************************************************************************
-                                       Nutrisa
***********************************************************************************/
UPDATE TMP
   SET   TMP.Recurso=S0.Recurso
	   ,TMP.Recurso_C=S0.Recurso_C
	   ,TMP.RecursoUMEstandar=S0.RecursoUMEstandar
	   ,TMP.ID_TipoRecurso=S0.ID_TipoRecurso
	   ,TMP.ID_RecursoCodigoABC=S0.ID_RecursoCodigoABC
	   ,TMP.RecursoPresentacion=S0.RecursoPresentacion
	   ,TMP.RecursoUMPeso=S0.RecursoUMPeso
	   ,TMP.RecursoPesoNeto=S0.RecursoPesoNeto
	   ,TMP.RecursoPesoLogistico=S0.RecursoPesoLogistico
	   ,TMP.RecursoCostoUnitario=S0.RecursoCostoUnitario
	   ,TMP.RecursoPrecioLista=S0.RecursoPrecioLista
	   ,TMP.ID_RecursoLinea=S0.ID_RecursoLinea
	   ,TMP.RecursoLinea=S0.RecursoLinea
	   ,TMP.ID_RecursoMarca=S0.ID_RecursoMarca
	   ,TMP.RecursoMarca=S0.RecursoMarca
	   ,TMP.ID_RecursoCompania=S0.ID_RecursoCompania
	   ,TMP.RecursoCompania=S0.RecursoCompania
	   ,TMP.ID_RecursoCompaniaContable=S0.ID_RecursoCompaniaContable
	   ,TMP.RecursoCompaniaContable=S0.RecursoCompaniaContable
	   ,TMP.RecursoCjEq=S0.RecursoCjEq
	   ,TMP.RecursoPzEq=S0.RecursoPzEq
	   ,TMP.RecursoKgEq=S0.RecursoKgEq
	   ,TMP.RecursoTmEq=S0.RecursoTmEq
	   ,TMP.RecursoCostoCj=S0.RecursoCostoCj
	   ,TMP.RecursoCostoPz=S0.RecursoCostoPz
	   ,TMP.RecursoCostoKg=S0.RecursoCostoKg
	   ,TMP.RecursoCostoTm=S0.RecursoCostoTm
	   ,TMP.RecursoIVA=S0.RecursoIVA
	   ,TMP.RecursoIEPS=S0.RecursoIEPS
	   ,TMP.RecursoClave=S0.RecursoClave
	   ,TMP.RecursoAgrupacion=S0.RecursoAgrupacion
	   ,TMP.RecursoTipo=S0.RecursoTipo
	   ,TMP.RecursoCodigoBarras=S0.RecursoCodigoBarras
	   ,TMP.RecursoCategoriaPlaneacion=S0.RecursoCategoriaPlaneacion
	   ,TMP.RecursoVidaUtil=S0.RecursoVidaUtil
	   ,TMP.ID_RecursoCategoria=S0.ID_RecursoCategoria
	   ,TMP.RecursoCategoria=S0.RecursoCategoria
	   ,TMP.RecursoDemantra=S0.RecursoDemantra
	   ,TMP.ID_RecursoCategoria1=S0.ID_RecursoCategoria1
	   ,TMP.RecursoCategoria1=S0.RecursoCategoria1
	   ,TMP.ID_RecursoCategoria2=S0.ID_RecursoCategoria2
	   ,TMP.RecursoCategoria2=S0.RecursoCategoria2
	   ,TMP.ID_RecursoGrupoCompania=S0.ID_RecursoGrupoCompania
	   ,TMP.RecursoGrupoCompania=S0.RecursoGrupoCompania
	   ,TMP.ID_RecursoManufactura=S0.ID_RecursoManufactura
	   ,TMP.RecursoManufactura=S0.RecursoManufactura
	   ,TMP.Recurso_IDSK_SegmentacionRecurso=S0.Recurso_IDSK_SegmentacionRecurso
	   ,TMP.RecursoFuenteClase=S0.RecursoFuenteClase
	   ,TMP.RecursoEntidad=S0.RecursoEntidad
	   ,TMP.RecursoClasificacionLogistica=S0.RecursoClasificacionLogistica
	   ,TMP.RecursoFormato=S0.RecursoFormato
	   ,TMP.RecursoCajasXCama=S0.RecursoCajasXCama

	   FROM BS_TMP1_Recurso TMP
	   INNER JOIN BS_Nutrisa_S0_Recurso S0
	   ON TMP.ID_Recurso =  S0.[ID_Recurso]
					   



SELECT                 A.ID_Recurso
					   ,A.Recurso
					   ,A.Recurso_C
					   ,A.RecursoUMEstandar
					   ,A.ID_TipoRecurso
					   ,A.ID_RecursoCodigoABC
					   ,A.RecursoPresentacion
					   ,A.RecursoUMPeso
					   ,A.RecursoPesoNeto
					   ,A.RecursoPesoLogistico
					   ,A.RecursoCostoUnitario
					   ,A.RecursoPrecioLista
					   ,A.ID_RecursoLinea
					   ,A.RecursoLinea
					   ,A.ID_RecursoMarca
					   ,A.RecursoMarca 
					   ,A.ID_RecursoCompania
					   ,A.RecursoCompania
					   ,A.ID_RecursoCompaniaContable
					   ,A.RecursoCompaniaContable
					   ,A.RecursoCjEq
					   ,A.RecursoPzEq
					   ,A.RecursoKgEq
					   ,A.RecursoTmEq
					   ,A.RecursoCostoCj
					   ,A.RecursoCostoPz
					   ,A.RecursoCostoKg
					   ,A.RecursoCostoTm
					   ,A.RecursoIVA
					   ,A.RecursoIEPS
					   ,A.RecursoClave
					   ,A.RecursoAgrupacion
					   ,A.RecursoTipo
					   ,A.RecursoCodigoBarras
					   ,A.RecursoCategoriaPlaneacion
					   ,A.RecursoVidaUtil
					   ,A.ID_RecursoCategoria 
					   ,CAST (A.ID_RecursoCategoria AS VARCHAR(80)) +' '+A.RecursoCategoria RecursoCategoria
					   ,A.RecursoDemantra
					   ,A.ID_RecursoCategoria1
					   ,CAST (A.ID_RecursoCategoria1 AS VARCHAR(80)) +' '+A.RecursoCategoria1 RecursoCategoria1
					   ,A.ID_RecursoCategoria2
					   ,CAST (A.ID_RecursoCategoria2 AS VARCHAR(80))+' '+A.RecursoCategoria2 RecursoCategoria2
					   ,A.ID_RecursoGrupoCompania
					   ,A.RecursoGrupoCompania
					   ,A.ID_RecursoManufactura
					   ,A.RecursoManufactura
					   ,A.Recurso_IDSK_SegmentacionRecurso
					   ,A.RecursoFuenteClase
					   ,A.RecursoEntidad
					   ,A.[RecursoClasificacionLogistica]
					   ,A.[RecursoFormato]
					   ,A.RecursoCajasXCama
					   ,A.RecursoApilabilidad
					   ,NULL AS ID_Recurso_BuildingBlock
					   ,NULL AS Recurso_BuildingBlock
					   ,NULL AS ID_RecursoBase
					   ,NULL AS RecursoBase
					   ,NULL  AS [RecursoInnovacion]
					   , '-1' ID_SAT
					   , '***ADMINISTRADO***'  DescripcionSAT
FROM 
(
						SELECT                        
									   RH.ID_Recurso ID_Recurso
		  							   ,ISNULL(RH.Recurso,RN.[Recurso] )  AS  Recurso
									   ,ISNULL(RH.Recurso_C,RN.Recurso_C)   AS Recurso_C
									   ,ISNULL(RH.RecursoUMEstandar,RN.RecursoUMEstandar) AS RecursoUMEstandar
									   ,ISNULL(RH.ID_TipoRecurso,RN.ID_TipoRecurso) AS ID_TipoRecurso
									   ,ISNULL(RH.ID_RecursoCodigoABC,RN.ID_RecursoCodigoABC)  AS ID_RecursoCodigoABC
									   ,ISNULL(RH.RecursoPresentacion,RN.RecursoPresentacion ) AS RecursoPresentacion
									   ,ISNULL(RH.RecursoUMPeso,RN.RecursoUMPeso) AS RecursoUMPeso
									   ,ISNULL(RH.RecursoPesoNeto,RN.RecursoPesoNeto)AS        RecursoPesoNeto
									   ,ISNULL(RH.RecursoPesoLogistico,RN.RecursoPesoLogistico) AS RecursoPesoLogistico
									   ,ISNULL(RH.RecursoCostoUnitario,RN.RecursoCostoUnitario) AS        RecursoCostoUnitario
									   ,ISNULL(RH.RecursoPrecioLista,RN.RecursoPrecioLista )AS RecursoPrecioLista
									   ,ISNULL(RH.[ID_RecursoLinea],RN.[ID_RecursoMarca]+RIGHT (RN.[ID_RecursoLinea],3)) [ID_RecursoLinea]
									   ,ISNULL(REPLACE (RH.RecursoLinea,'  ',' '),RN.RecursoLinea )AS RecursoLinea
									   ,ISNULL(RH.ID_RecursoMarca,RN.[ID_RecursoMarca]) AS ID_RecursoMarca
									   ,ISNULL(RH.RecursoMarca,RN.RecursoMarca) AS RecursoMarca 
									   ,ISNULL(RH.ID_RecursoCompania,RN.ID_RecursoCompania) AS ID_RecursoCompania
									   ,ISNULL(RH.RecursoCompania,RN.RecursoCompania)            AS RecursoCompania
									   ,ISNULL(RH.ID_RecursoCompaniaContable,RN.ID_RecursoCompaniaContable) AS ID_RecursoCompaniaContable
									   ,ISNULL(RH.RecursoCompaniaContable,RN.RecursoCompaniaContable) AS RecursoCompaniaContable
									   ,ISNULL(RH.RecursoCjEq,RN.RecursoCjEq)	 RecursoCjEq
									   ,ISNULL(RH.RecursoPzEq,RN.RecursoPzEq )	 RecursoPzEq
									   ,ISNULL(RH.RecursoKgEq,RN.RecursoKgEq)	 RecursoKgEq
									   ,ISNULL(RH.RecursoTmEq,RN.RecursoTmEq)	 RecursoTmEq
									   ,ISNULL(RH.RecursoCostoCj,RN.RecursoCostoCj) RecursoCostoCj
									   ,ISNULL(RH.RecursoCostoPz,RN.RecursoCostoPz) RecursoCostoPz
									   ,ISNULL(RH.RecursoCostoKg,RN.RecursoCostoKg )RecursoCostoKg
									   ,ISNULL(RH.RecursoCostoTm,RN.RecursoCostoTm )RecursoCostoTm
									   ,ISNULL(RH.RecursoIVA,RN.RecursoIVA)	 RecursoIVA
									   ,ISNULL(RH.RecursoIEPS,RN.RecursoIEPS)	RecursoIEPS
									   ,ISNULL(RH.RecursoClave,RN.RecursoClave)	RecursoClave
									   ,ISNULL(RH.RecursoAgrupacion,RN.RecursoAgrupacion)RecursoAgrupacion
									   ,ISNULL(RH.RecursoTipo,RN.RecursoTipo )	 RecursoTipo
									   ,ISNULL(RH.RecursoCodigoBarras,RN.RecursoCodigoBarras) RecursoCodigoBarras
									   ,ISNULL(RH.RecursoCategoriaPlaneacion,RN.RecursoCategoriaPlaneacion)	RecursoCategoriaPlaneacion
									   ,ISNULL(RH.RecursoVidaUtil,RN.RecursoVidaUtil)  RecursoVidaUtil
									   ,ISNULL(RH.ID_RecursoCategoria,RN.ID_RecursoCategoria ) ID_RecursoCategoria
									   ,ISNULL(RH.RecursoCategoria,RN.RecursoCategoria )	    RecursoCategoria
									   ,ISNULL(RN.RecursoDemantra,RH.RecursoDemantra  )	  RecursoDemantra
									   ,ISNULL(RH.ID_RecursoCategoria1,RN.ID_RecursoCategoria1 ) ID_RecursoCategoria1
									   ,ISNULL(RH.RecursoCategoria1,RN.RecursoCategoria1)	 RecursoCategoria1
									   ,ISNULL(RH.ID_RecursoCategoria2,RN.ID_RecursoCategoria2 )ID_RecursoCategoria2
									   ,ISNULL(RH.RecursoCategoria2,RN.RecursoCategoria2)	  RecursoCategoria2
									   ,ISNULL(RH.ID_RecursoGrupoCompania,RN.ID_RecursoGrupoCompania)  ID_RecursoGrupoCompania
									   ,ISNULL(RH.RecursoGrupoCompania,RN.RecursoGrupoCompania)	    RecursoGrupoCompania
									   ,ISNULL(RH.ID_RecursoManufactura,RN.ID_RecursoManufactura )   ID_RecursoManufactura
									   ,ISNULL(RH.RecursoManufactura,RN.RecursoManufactura  ) RecursoManufactura
									   ,ISNULL(RH.Recurso_IDSK_SegmentacionRecurso,RN.Recurso_IDSK_SegmentacionRecurso)   Recurso_IDSK_SegmentacionRecurso
									   ,ISNULL(RH.RecursoFuenteClase,RN.RecursoFuenteClase )  RecursoFuenteClase
									   ,ISNULL(RN.RecursoEntidad,RH.RecursoEntidad)	 RecursoEntidad
									   ,ISNULL(RH.[RecursoClasificacionLogistica],RN.[RecursoClasificacionLogistica]) [RecursoClasificacionLogistica]
									   ,ISNULL(RH.[RecursoFormato],RN.[RecursoFormato] )	[RecursoFormato]
									   ,ISNULL( RH.RecursoCajasXCama,RN.RecursoCajasXCama)	 RecursoCajasXCama
									   ,ISNULL( RH.RecursoApilabilidad,  RN.RecursoApilabilidad )	   RecursoApilabilidad
		  FROM          BS_Nutrisa_S0_HerdezRecurso RH
		  LEFT  JOIN    BS_Nutrisa_S0_Recurso RN
		  ON               RH.ID_Recurso = RN.ID_Recurso	
		  --LEFT JOIN    BS_TMP1_Recurso       R 
		  --ON               RH.ID_Recurso = R.ID_Recurso	
		  WHERE  		RN.ID_Recurso	 IS NULL
		  --AND 			 R.ID_Recurso	 IS NULL
		  --AND  RH.ID_RecursoNutrisa =   '475002'
		  AND               RH.ID_Recurso NOT IN  
		  (
			 SELECT ID_RecursoHerdez
			 FROM BS_Nutrisa_RecursosAutoservicio
		  )
		    UNION	    
		  SELECT    DISTINCT     
														  RN.[ID_Recurso]
														  ,RN.[Recurso]   AS  Recurso
														  ,RN.Recurso_C   AS Recurso_C
														  ,RN.RecursoUMEstandar AS RecursoUMEstandar
														  ,RN.ID_TipoRecurso AS ID_TipoRecurso
														  ,RN.ID_RecursoCodigoABC  AS ID_RecursoCodigoABC
														  ,RN.RecursoPresentacion  AS RecursoPresentacion
														  ,RN.RecursoUMPeso AS RecursoUMPeso
														  ,RN.RecursoPesoNeto AS        RecursoPesoNeto
														  ,RN.RecursoPesoLogistico AS RecursoPesoLogistico
														  ,RN.RecursoCostoUnitario AS        RecursoCostoUnitario
														  ,RN.RecursoPrecioLista AS RecursoPrecioLista
														  ,CASE 
																WHEN  RIGHT (RN.[ID_RecursoLinea],3)  IN ( '107','108','100','101')
																THEN    RIGHT (RN.[ID_RecursoLinea],3)
																ELSE     RN.[ID_RecursoMarca]+RIGHT (RN.[ID_RecursoLinea],3)
														  END  [ID_RecursoLinea]
														  ,RN.RecursoLinea AS RecursoLinea
														  ,RN.[ID_RecursoMarca] AS ID_RecursoMarca
														  ,RN.RecursoMarca AS RecursoMarca 
														  ,RN.ID_RecursoCompania AS ID_RecursoCompania
														  ,RN.RecursoCompania            AS RecursoCompania
														  ,RN.ID_RecursoCompaniaContable AS ID_RecursoCompaniaContable
														  ,RN.RecursoCompaniaContable AS RecursoCompaniaContable
														  ,RN.RecursoCjEq
														  ,RN.RecursoPzEq
														  ,RN.RecursoKgEq
														  ,RN.RecursoTmEq
														  ,RN.RecursoCostoCj
														  ,RN.RecursoCostoPz
														  ,RN.RecursoCostoKg
														  ,RN.RecursoCostoTm
														  ,RN.RecursoIVA
														  ,RN.RecursoIEPS
														  ,RN.RecursoClave
														  ,RN.RecursoAgrupacion
														  ,RN.RecursoTipo
														  ,RN.RecursoCodigoBarras
														  ,RN.RecursoCategoriaPlaneacion
														  ,RN.RecursoVidaUtil
														  ,RN.ID_RecursoCategoria 
														  ,RN.RecursoCategoria
														  ,RN.RecursoDemantra
														  ,RN.ID_RecursoCategoria1
														  ,RN.RecursoCategoria1
														  ,RN.ID_RecursoCategoria2
														  ,RN.RecursoCategoria2
														  ,RN.ID_RecursoGrupoCompania
														  ,RN.RecursoGrupoCompania
														  ,RN.ID_RecursoManufactura
														  ,RN.RecursoManufactura
														  ,RN.Recurso_IDSK_SegmentacionRecurso
														  ,RN.RecursoFuenteClase
														  ,RN.RecursoEntidad
														  ,RN.[RecursoClasificacionLogistica]
														  ,RN.[RecursoFormato]
														  ,RN.RecursoCajasXCama
														  ,RN.RecursoApilabilidad
		  FROM            BS_Nutrisa_S0_Recurso RN 
		  LEFT  JOIN  BS_Nutrisa_S0_HerdezRecurso RH
		  ON                 RH.ID_RecursoNutrisa = RN.ID_Recurso	
		  --LEFT JOIN    BS_TMP1_Recurso       R 
		  --ON               RH.ID_Recurso = R.ID_Recurso	
		  WHERE 		 RH.ID_RecursoNutrisa IS NULL
		  --AND 			 R.ID_Recurso	 IS NULL
		  --AND   RN.[ID_Recurso] =   '475002'
)A
		  LEFT JOIN    BS_TMP1_Recurso       R 
		  ON               A.ID_Recurso = R.ID_Recurso	

/****************    Categoria MK Nutrisa  ****************/
Update BS_TMP1_Recurso
SET
ID_RecursoCategoria = right('000'+rtrim(convert(char,A.IDCategoria)),3),
RecursoCategoria = right('000'+rtrim(convert(char,A.IDCategoria)),3)+' '+RTRIM(A.Categoria),
 ID_RecursoCategoria1 = right('000'+rtrim(convert(char,A.IDCategoria)),3),
RecursoCategoria1 = right('000'+rtrim(convert(char,A.IDCategoria)),3)+' '+RTRIM(A.Categoria),
ID_RecursoCategoria2     = right('000'+rtrim(convert(char,A.IDPlataforma)),3),
RecursoCategoria2 = right('000'+rtrim(convert(char,A.IDPlataforma)),3)+' '+RTRIM(A.Plataforma)
FROM BS_W1_RecursoCategoriaMercadotecnia A
WHERE RIGHT(BS_TMP1_Recurso.ID_RecursoLinea,3) = A.IDLinea
AND BS_TMP1_Recurso.ID_RecursoLinea in('N100','N101','100')

--SE ACTUALIZA LOS COSTOS
Update BS_TMP1_Recurso
SET RecursoCjEq = 1
   ,RecursoPzEq = 1
   ,RecursoKgEq = 1
   ,RecursoTmEq = 1
   ,RecursoCostoCj = 1
   ,RecursoCostoPz = 1
   ,RecursoCostoKg = 1
   ,RecursoCostoTm = 1

--SE ACTUALIZA LAS CAJAS EQUIVALENTES
Update BS_TMP1_Recurso
SET RecursoCjEq = UMCONF 
FROM BS_HDZALM_UMCONV CONV 
WHERE ID_Recurso = CONV.UMRESR
AND RecursoUMEstandar = CONV.UMFR 
AND CONV.UMTO = 'CJ'
	
--SE ACTUALIZA LAS PIEZAS EQUIVALENTES
Update BS_TMP1_Recurso
SET  RecursoPzEq = UMCONF
FROM BS_HDZALM_UMCONV CONV 
WHERE ID_Recurso = CONV.UMRESR
AND RecursoUMEstandar = CONV.UMFR 
AND CONV.UMTO = 'PZ'
--SE ACTUALIZA LAS TONELADAS EQUIVALENTES
Update BS_TMP1_Recurso
SET  RecursoTmEq = UMCONF 
FROM BS_HDZALM_UMCONV CONV 
WHERE ID_Recurso = CONV.UMRESR
AND RecursoUMEstandar = CONV.UMFR 
AND CONV.UMTO = 'PL'
/**************************************************************************************************/
--ActualIza Atributos Id_Linea Y RecursoLineas de productos especificos
/**************************************************************************************************/
UPDATE R
SET ID_RecursoLinea = RL.ID_RecursoLineaAct
  , RecursoLinea = RL.RecursoLineaAct
FROM BS_TMP1_Recurso R
INNER JOIN BS_S0_RecursoLinea RL
ON R.ID_RECURSO= RL.ID_RECURSO

UPDATE R 
SET	 R.RecursoFormato =  RF.RecursoFormato
FROM BS_S0_RecursoFormato RF
INNER JOIN  BS_TMP1_Recurso R
ON RF.ID_Recurso = R.ID_Recurso

/*********************************************/
--INSERTA DATOS DE BULDING BLOCKS A TABLA D1--
/*********************************************/
UPDATE
  BS_TMP1_Recurso
SET
  BS_TMP1_Recurso.ID_RECURSO_BUILDINGBLOCK  =  S0_Producto_BuildingBlocks.ID_BUILDINGBLOCK
 ,BS_TMP1_Recurso.RECURSO_BUILDINGBLOCK     =  S0_Producto_BuildingBlocks.RECURSO_BUILDINGBLOCK
 ,BS_TMP1_Recurso.ID_RecursoBase            =  S0_Producto_BuildingBlocks.ID_RecursoBase
 ,BS_TMP1_Recurso.RecursoBase               =  S0_Producto_BuildingBlocks.RecursoBase
 ,BS_TMP1_Recurso.RecursoInnovacion        =   S0_Producto_BuildingBlocks.[RecursoInnovacion]
FROM
  BS_TMP1_Recurso
 ,BS_S0_Producto_BuildingBlocks
WHERE
  BS_TMP1_Recurso.ID_RECURSO = S0_Producto_BuildingBlocks.ID_RECURSO;

UPDATE  BS_TMP1_Recurso
SET     RecursoInnovacion = '***ADMINISTRADO***'
WHERE   RecursoInnovacion IS NULL

UPDATE  BS_TMP1_Recurso
SET     ID_RECURSO_BUILDINGBLOCK = '-1'
WHERE   ID_RECURSO_BUILDINGBLOCK IS NULL

UPDATE   BS_TMP1_Recurso
SET      RECURSO_BUILDINGBLOCK = '***Administrado***'
WHERE    RECURSO_BUILDINGBLOCK IS NULL


UPDATE   BS_TMP1_Recurso
SET      ID_RecursoBase = '999999'
WHERE    ID_RecursoBase IS NULL

UPDATE   BS_TMP1_Recurso
SET      RecursoBase = '-1 ***Administrado***'
WHERE    RecursoBase  IS NULL


    ------Estandariza Companias
UPDATE BS_TMP1_Recurso SET  ID_RecursoCompania = 	CASE 
																			 WHEN  RecursoMarca ='5 HELADOS NESTLE'
																			 THEN 	'A'
																			 WHEN  RecursoMarca ='N NUTRISA'
																			 THEN 	'J'
																			 ELSE 	ID_RecursoCompania
																		  END 
										  ,   [RecursoCompania] = CASE 
																			 WHEN  RecursoMarca ='5 HELADOS NESTLE'
																			 THEN 	'***'
																			 WHEN  RecursoMarca ='N NUTRISA'
																			 THEN 	'J NUTRISA S.A. DE C.V.'
																			 ELSE 	[RecursoCompania]
																		  END 
										  ,ID_RecursoCompaniaContable = CASE 
												    									   WHEN  RecursoMarca ='5 HELADOS NESTLE'
												    									   THEN 	'79'
												    									   WHEN  RecursoMarca ='N NUTRISA'
												    									   THEN 	'77'
												    									   ELSE 	ID_RecursoCompaniaContable
												    								    END 
										      ,[RecursoCompaniaContable]  =  CASE 
																					   WHEN  RecursoMarca ='5 HELADOS NESTLE'
																					   THEN 	'079 ALIMENTOS BENEFITS S.A. DE C.V.'
																					   WHEN  RecursoMarca ='N NUTRISA'
																					   THEN 	'077 NUTRISA SA DE CV'
																					   ELSE 	[RecursoCompaniaContable]
																				    END 


UPDATE BS_TMP1_Recurso 
SET 	RecursoClasificacionLogistica =	  
CASE 
	WHEN ID_RecursoCompaniaContable IN ('77','79','92') 
		THEN   'CONGELADOS' 
			ELSE	  'CONSERVAS'
END 


UPDATE BS_TMP1_Recurso 
SET  ID_RecursoCategoria	='0'
,RecursoCategoria	='0 ***ADMINISTRADO***'
,ID_RecursoCategoria1 ='0'
,RecursoCategoria1	='0 ***ADMINISTRADO***'
,ID_RecursoCategoria2	 ='0'
,RecursoCategoria2	 ='0 ***ADMINISTRADO***'
WHERE ID_RecursoCompania IN ('O','J')
AND 	SUBSTRING(ID_RECURSO,1,1) = 'N'

UPDATE TMP1 
SET TMP1.ID_SAT  = MS.ID_SAT 
 ,  TMP1.DescripcionSAT = MS.DescripcionSAT
FROM BS_TMP1_Recurso TMP1
INNER JOIN BS_S0_RecursoMapeoSAT MS
on TMP1.ID_Recurso = MS. ID_Recurso





