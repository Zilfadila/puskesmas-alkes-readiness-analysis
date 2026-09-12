**Puskesmas Medical Equipment Readiness Analysis: National Ranking to District-Level Deep Dive** (English)

1. Project Overview

This project analyzes Puskesmas (community health center) medical equipment readiness across Indonesia, using publicly available data from the ASPAK (Aplikasi Sarana Prasarana dan Alat Kesehatan) dashboard. The analysis moves through three levels of depth: a national overview, a drill-down into Sumatera Selatan province, and a trend analysis across 8 reporting periods (2023-2024).

This project has a personal connection: the author previously worked as an Administrative Intern at Dinas Kesehatan Kabupaten Ogan Ilir, auditing healthcare equipment completeness through the ASPAK system - direct hands-on experience with the same data infrastructure this project analyzes.

2. Objectives

* Rank all Indonesian provinces by Puskesmas medical equipment readiness (Indicator F.02).
* Identify where Sumatera Selatan stands nationally, and drill down to district/city (kabupaten/kota) level within the province.
* Track readiness trends across 8 periods (2023 P1 - 2024 P4) to identify districts that are improving, declining, or volatile.
* Provide actionable findings to support equipment readiness "strengthening" efforts at the district level.

3. Dataset

* Source: ASPAK public dashboard (Ministry of Health, Indonesia)
* Indicator used: F.02 - "Pemenuhan Standar Alat Kesehatan di Puskesmas" (Compliance with Medical Equipment Standards at Puskesmas), based on Permenkes 43
* Scope: National level (all provinces) + Sumatera Selatan province (all districts/cities)
* Period: 2023-2024, 8 consecutive reporting periods, manually downloaded (16 files total)
* Note on scope consistency: only F.02 (Puskesmas-specific) is used throughout the analysis - the broader F.01 indicator (covering all facility types: hospitals, clinics, etc.) was deliberately excluded to avoid mixing populations with different scope in the same decomposition.

4. Methodology

* Data Collection - 16 files manually downloaded from the ASPAK public dashboard (8 national, 8 Sumatera Selatan), following a consistent naming convention.
* Data Combination (Excel/Power Query) - all 16 files combined via Power Query's "Combine & Transform Data" from folder, with metadata header rows stripped and file names parsed into structured columns (indicator, level, year, period).
* Data Cleaning & Validation (SQL/PostgreSQL) - column type correction (Indonesian decimal comma format), missing value checks, duplicate checks (verified 0 duplicates across ~440 rows).
* Categorization & Ranking (SQL Views) - CASE WHEN logic to categorize each record as "Baik" (>80%), "Perlu Perhatian" (60-80%), or "Kritis" (<60%); window function (RANK() OVER) for national provincial ranking.
* Dashboard & Advanced Analysis (Power BI/DAX) - period-over-period growth, volatility (STDEV.P), and long-term trend classification built as DAX measures, connected live to PostgreSQL.

5. Key Findings

**National Level**
* Sumatera Selatan ranks below the national average in Puskesmas medical equipment readiness (national average ~46-50%, depending on period).
* This finding is consistent across both the national ranking view and the province-level drill-down, reinforcing its reliability rather than being an artifact of one specific view.

**Sumatera Selatan Drill-down**
* 12 of 17 districts/cities in Sumatera Selatan fall into the "Kritis" (Critical) category for medical equipment readiness - a substantial majority, indicating this is a province-wide concern rather than isolated cases.
* Kota Palembang and Kab. Musi Rawas are the strongest performers within the province.

**Trend Analysis (2023-2024)**
* Most districts show a "Membaik" (Improving) trend from 2023 P1 to 2024 P4, alongside relatively stable performance within 2024.
* One data quality caveat (see Section 6) affects the interpretation of Kab. Empat Lawang's improvement figure specifically.

6. Data Quality Notes (Documented Transparently)

* **DKI Jakarta anomaly**: DKI Jakarta shows a readiness score exceeding 100% (as high as ~400%) in the 2024 data, as found directly in the ASPAK source dashboard. Since a compliance percentage logically cannot exceed 100%, this is documented as an open question rather than silently corrected - it may reflect equipment counts far exceeding the minimum standard (over-provisioning), or a data entry/calculation anomaly at the source system. This was capped visually at 100 for chart readability, without altering the underlying reported value.
* **Kab. Empat Lawang data gap**: this district has no reported data for 2023 P1-P3, imputed as 0 for calculation purposes. As a result, its "Membaik" (Improving) trend status likely reflects the start of reporting rather than a genuine improvement in equipment readiness, and should not be read as a confirmed positive trend without further verification against the source system.

7. Business Recommendations

* Prioritize the 12 "Kritis" districts in Sumatera Selatan for equipment procurement/allocation review, starting with those showing declining or highly volatile scores across periods.
* Investigate the DKI Jakarta anomaly with the ASPAK data owner before using it as a national benchmark.
* Establish a data completeness check as part of the reporting pipeline, to catch gaps like Kab. Empat Lawang's before they affect trend calculations.

8. Tech Stack

* Data preparation: Excel (Power Query)
* Database: PostgreSQL (via DBeaver / Beekeeper Studio)
* Visualization: Power BI (DAX measures, drill-through, multi-page navigation)

---

**Analisis Kesiapan Alat Kesehatan Puskesmas: Ranking Nasional hingga Drill-down Tingkat Kabupaten** (Indonesia)

1. Project Overview

Project ini menganalisis kesiapan alat kesehatan Puskesmas di seluruh Indonesia, menggunakan data publik dari dashboard ASPAK (Aplikasi Sarana Prasarana dan Alat Kesehatan). Analisis dilakukan dalam 3 lapis kedalaman: gambaran nasional, drill-down ke Provinsi Sumatera Selatan, dan analisis tren sepanjang 8 periode pelaporan (2023-2024).

Project ini punya keterkaitan personal: penulis pernah bekerja sebagai Administrative Intern di Dinas Kesehatan Kabupaten Ogan Ilir, mengaudit kelengkapan alat kesehatan melalui sistem ASPAK - pengalaman langsung dengan infrastruktur data yang sama dengan yang dianalisis di project ini.

2. Objectives

* Meranking seluruh provinsi di Indonesia berdasarkan kesiapan alat kesehatan Puskesmas (Indikator F.02).
* Mengidentifikasi posisi Sumatera Selatan secara nasional, dan drill-down ke level kabupaten/kota dalam provinsi tersebut.
* Melacak tren kesiapan sepanjang 8 periode (2023 P1 - 2024 P4) untuk mengidentifikasi kabupaten yang membaik, memburuk, atau fluktuatif.
* Memberikan temuan yang actionable untuk mendukung upaya "penguatan" (strengthening) kesiapan alat kesehatan di tingkat kabupaten.

3. Dataset

* Sumber: Dashboard publik ASPAK (Kementerian Kesehatan RI)
* Indikator yang dipakai: F.02 - "Pemenuhan Standar Alat Kesehatan di Puskesmas", berdasarkan Permenkes 43
* Cakupan: Level nasional (semua provinsi) + Provinsi Sumatera Selatan (semua kabupaten/kota)
* Periode: 2023-2024, 8 periode pelaporan berturut-turut, didownload manual (total 16 file)
* Catatan konsistensi scope: hanya F.02 (khusus Puskesmas) yang dipakai di seluruh analisis - indikator F.01 yang lebih luas (mencakup semua jenis fasilitas: RS, klinik, dll) sengaja tidak diikutsertakan untuk menghindari pencampuran populasi dengan scope berbeda dalam satu dekomposisi.

4. Methodology

* Pengumpulan Data - 16 file didownload manual dari dashboard publik ASPAK (8 nasional, 8 Sumatera Selatan), mengikuti konvensi penamaan yang konsisten.
* Penggabungan Data (Excel/Power Query) - seluruh 16 file digabung lewat "Combine & Transform Data" Power Query dari folder, dengan baris metadata header dihapus dan nama file di-parse jadi kolom terstruktur (indikator, level, tahun, periode).
* Cleaning & Validasi Data (SQL/PostgreSQL) - perbaikan tipe data kolom (format koma desimal Indonesia), pengecekan missing value, pengecekan duplikasi (terverifikasi 0 duplikasi dari ~440 baris).
* Kategorisasi & Ranking (SQL View) - logika CASE WHEN untuk kategorisasi tiap record jadi "Baik" (>80%), "Perlu Perhatian" (60-80%), atau "Kritis" (<60%); window function (RANK() OVER) untuk ranking provinsi nasional.
* Dashboard & Analisis Lanjutan (Power BI/DAX) - growth period-over-period, volatilitas (STDEV.P), dan klasifikasi tren jangka panjang dibangun sebagai DAX measure, terhubung langsung (live) ke PostgreSQL.

5. Key Findings

**Level Nasional**
* Sumatera Selatan berada di bawah rata-rata nasional untuk kesiapan alat kesehatan Puskesmas (rata-rata nasional ~46-50%, tergantung periode).
* Temuan ini konsisten baik dari tampilan ranking nasional maupun drill-down level provinsi, memperkuat keandalannya - bukan sekadar kebetulan dari satu sudut pandang saja.

**Drill-down Sumatera Selatan**
* 12 dari 17 kabupaten/kota di Sumatera Selatan masuk kategori "Kritis" untuk kesiapan alat kesehatan - mayoritas besar, mengindikasikan ini masalah se-provinsi, bukan kasus terisolasi.
* Kota Palembang dan Kab. Musi Rawas jadi yang berkinerja terbaik dalam provinsi.

**Analisis Tren (2023-2024)**
* Sebagian besar kabupaten menunjukkan tren "Membaik" dari 2023 P1 ke 2024 P4, dengan performa relatif stabil di sepanjang 2024.
* Ada 1 catatan kualitas data (lihat Bagian 6) yang mempengaruhi interpretasi angka perbaikan khusus Kab. Empat Lawang.

6. Catatan Kualitas Data (Didokumentasikan Secara Transparan)

* **Anomali DKI Jakarta**: DKI Jakarta menunjukkan skor kesiapan melebihi 100% (mencapai ~400%) di data 2024, sebagaimana ditemukan langsung dari dashboard sumber ASPAK. Karena persentase kepatuhan secara logis tidak mungkin melebihi 100%, ini didokumentasikan sebagai open question, bukan diam-diam dikoreksi - kemungkinan mencerminkan jumlah alat yang jauh melebihi standar minimum (over-provisioning), atau anomali input/perhitungan di sistem sumber. Untuk keterbacaan chart, nilai ini dibatasi visual di 100, tanpa mengubah nilai yang dilaporkan aslinya.
* **Data gap Kab. Empat Lawang**: kabupaten ini tidak memiliki data terlapor untuk 2023 P1-P3, diimputasi sebagai 0 untuk keperluan kalkulasi. Akibatnya, status tren "Membaik" untuk kabupaten ini kemungkinan besar mencerminkan mulainya pelaporan, bukan perbaikan kesiapan alat kesehatan yang sesungguhnya, dan sebaiknya tidak dibaca sebagai tren positif yang terkonfirmasi tanpa verifikasi lebih lanjut ke sistem sumber.

7. Business Recommendations

* Prioritaskan 12 kabupaten "Kritis" di Sumatera Selatan untuk peninjauan pengadaan/alokasi alat, dimulai dari yang menunjukkan skor menurun atau paling fluktuatif sepanjang periode.
* Investigasi anomali DKI Jakarta bersama pengelola data ASPAK sebelum dipakai sebagai benchmark nasional.
* Bangun pengecekan kelengkapan data sebagai bagian dari pipeline pelaporan, untuk menangkap gap seperti kasus Kab. Empat Lawang sebelum mempengaruhi perhitungan tren.

8. Tech Stack

* Persiapan data: Excel (Power Query)
* Database: PostgreSQL (via DBeaver / Beekeeper Studio)
* Visualisasi: Power BI (DAX measures, drill-through, navigasi multi-halaman)
