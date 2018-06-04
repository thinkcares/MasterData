-- Tipo de Producto
SELECT 
    [Código de Tipo de Producto]
,	[Nombre de Tipo de Producto]
FROM HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_TipoDeProducto
WHERE [Código de Tipo de Producto] IS NOT NULL
order by 1
-- ORIGEN
select 
    [Código de Origen]
,	[Nombre de Origen]
from 
HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Origen
WHERE [Código de Origen] IS NOT NULL
order by 1
-- MARCA
SELECT 	[Código de Marca Armado Clave ME],[Nombre de Marca Armado Clave ME]
FROM HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_MarcaPDescripción
WHERE [Código de Marca Armado Clave ME]IS NOT NULL
order by 1

-- CLASE
SELECT [Codigo de Clase],[Descripción]
FROM HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_Clase
order by 1

-- TIPO ENVASE
SELECT [Código de Tipo de Envase],	[Nombre de Tipo de Envase]
FROM HSVDMDDBPPSQL.MDMHERDEZ.mdm.vmMDM_PD_Tipo_De_Envase 
ORDER BY 1

-- SUBCLASE
SELECT [Clave de Subclase],	[Descripción Subclase]
FROM HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_SubClase
ORDER BY 1

-- UNIDAD DE MEDIDA

select [Código de Unidad de Medida],	[Nombre de Unidad de Medida]
from HSVDMDDBPPSQL.MDMHERDEZ.mdm.vwMDM_UnidadesDeMedida
ORDER BY 1
