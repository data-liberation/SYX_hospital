--insert into PD_ST_DETAIL
select
	replace(sys_guid(), '-', '') PK_PDSTDT,
	'a41476368e2943f48c32d0cb1179dab8' PK_ORG,
	'a85ef98483a742acb4de1924c146c93b' PK_PDST,
	--该主键是申请单的
	ROWNUM+3 SORT_NO,  ----
	PK_PD,
	PK_UNIT_PACK,
	PACK_SIZE,
	'10000'/PACK_SIZE QUAN_PACK,
	'10000' QUAN_MIN,
	'0' QUAN_OUTSTORE,
	price PRICE_COST,
	price* ('10000'/PACK_SIZE)/pdpacksize AMOUNT_COST, --零售金额= 零售单价*零售包装
	price PRICE,
	price* ('10000'/PACK_SIZE)/pdpacksize AMOUNT,
	'0' DISC,
	concat('A',ROWNUM+3) BATCH_NO,
	null DATE_FAC,
	to_date('2020-11-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss') DATE_EXPIRE,
	null INV_NO,
	null RECEIPT_NO,
	'0' FLAG_CHK_RPT,
	null DATE_CHK_RPT,
	null PK_EMP_CHK_RPT,
	null NAME_EMP_CHK_RPT,
	null PK_PDPAY,
	'0' AMOUNT_PAY,
	'0' FLAG_PAY,
	null PK_PDPUDT,
	'0' FLAG_FINISH,
	null NOTE,
	'be5bc85ea2584965b6e033b1c5f92050' CREATOR,
	to_date('2019-02-21 08:49:11', 'yyyy-mm-dd hh24:mi:ss') CREATE_TIME,
	null MODIFIER,
	null MODITY_TIME,
	'0' DEL_FLAG,
	null TS,
	null PK_SUPPLYER,
	null PK_PDSTDT_RL,
	null FLAG_CG,
	null PK_CG,
	null PK_PV from (
  SELECT store.PK_PD,PK_UNIT PK_UNIT_PACK,PRICE price,pd.PACK_SIZE pdpacksize,store.PACK_SIZE,NAME,store.DEL_FLAG FROM BD_PD_STORE store
  INNER JOIN BD_PD pd on pd.PK_PD = store.PK_PD
  WHERE PK_DEPT = '3E6F13C8B5F44204B852C83928A51307' and store.FLAG_STOP <> 1
  --仓库科室的主键
  and NAME not LIKE '%(自%' AND NAME not LIKE '%（自%' and NAME not LIKE '%氯化钠注射液%' and NAME not LIKE '%葡萄糖%'
  --过滤掉自备药,还有基数药
and not exists(SELECT * from PD_STOCK stock where PK_DEPT = '3E6F13C8B5F44204B852C83928A51307' and store.PK_PD = stock.PK_PD));
