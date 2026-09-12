-- PROJECT   : Puskesmas Medical Equipment Readness Analysis
-- Indicator : F.02 - Pemenuhan Standar Alat Kesehatan di Puskesmas
-- Sourse 	 : ASPAK Public Dashboard Period 2023- 2024
-- =====================================================================================

--This script is organized into 3 section:
-- 1. SETUP
-- 2. CLEANING and VALIDATION
-- 3. VIEWS


-- SECTION 1: SETUP
-- Data was combined from 16 raw files ( 8 national + 8 province, 2023-2024, 4 periods)
-- using Excel Power Query, then imported into yhis table via DBeaver's Import Data wizard


-- Check coolumn names and data types after import
select column_name, data_type
from information_schema."columns" 
where table_name = 'alkes';


-- SECTION 2: CLEANING and VALIDATION

-- 2.1. Check Missing Value
select 
COUNT(*) as total_baris,
COUNT(*) - COUNT("Kode_Wilayah") as missing_kode_wilayah,
COUNT(*) - COUNT("Nama_Wilayah") as missing_nama_wilayah,
COUNT(*) - COUNT("Level") as missing_level,
COUNT(*) - COUNT("Tahun") as missing_tahun,
COUNT(*) - COUNT("Periode") as missing_periode,
COUNT(*) - COUNT("Jumlah") as missing_jumlah,
COUNT(*) - COUNT("Nilai") as missing_nilai,
COUNT(*) - COUNT("Persentase") as missing_persentase
from alkes;


-- 2.2 Check Duplicate
select "Kode_Wilayah","Nama_Wilayah", "Level","Tahun", "Periode", COUNT(*)
from alkes 
group by "Kode_Wilayah", "Nama_Wilayah", "Level","Tahun","Periode"
having COUNT(*) > 1;



-- 2.3. Sanity check - row cunts by level and Year
select "Level","Tahun", COUNT(*), AVG("Persentase")
from alkes 
group by "Level","Tahun" 
order by "Level","Tahun";



-- 3. VIEWS 

--3.1. Categorization View

create view v_kategorisasi as 
select 
	"Kode_Wilayah",
	"Nama_Wilayah",
	"Level",
	"Tahun",
	"Periode",
	"Jumlah",
	"Nilai",
	"Persentase",
	case 
		when "Persentase" > 80.00 then 'Baik'
		when "Persentase" >= 60.00 then 'Perlu Perhatian'
		else 'Kritis'
	end as Kategori
from alkes;



-- 3.2 National Ranking View

create view v_ranking_nasional as 
select 
	"Kode_Wilayah",
	"Nama_Wilayah",
	"Tahun",
	"Periode",
	"Persentase",
	RANK() over (partition by "Tahun","Periode" order by "Persentase" desc) as ranking
from alkes 
where "Level" = 'Nasional'



-- 3.3 Example Usage 
select * from v_ranking_nasional 
where "Nama_Wilayah" = 'Sumatera Selatan'
order by "Tahun", "Periode";
