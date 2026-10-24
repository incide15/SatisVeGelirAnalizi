USE SatisAnalizi;
GO

-- 1. Tum satis kayitlarini listele
SELECT *
FROM Satislar;
GO

-- 2. Toplam ciroyu hesapla
SELECT
    SUM(adet * birim_fiyat) AS toplam_ciro
FROM Satislar;
GO

-- 3. Urun bazinda gelir analizi
SELECT
    urun_adi,
    SUM(adet) AS toplam_adet,
    SUM(adet * birim_fiyat) AS toplam_gelir
FROM Satislar
GROUP BY urun_adi
ORDER BY toplam_gelir DESC;
GO

-- 4. Aylik ciro analizi
SELECT
    YEAR(satis_tarihi) AS yil,
    MONTH(satis_tarihi) AS ay,
    SUM(adet * birim_fiyat) AS aylik_ciro
FROM Satislar
GROUP BY YEAR(satis_tarihi), MONTH(satis_tarihi)
ORDER BY yil, ay;
GO

-- 5. Sehirlere gore satis analizi
SELECT
    sehir,
    SUM(adet) AS toplam_adet,
    SUM(adet * birim_fiyat) AS toplam_ciro
FROM Satislar
GROUP BY sehir
ORDER BY toplam_ciro DESC;
GO

-- 6. Kategori bazinda gelir analizi
SELECT
    kategori,
    SUM(adet) AS toplam_adet,
    SUM(adet * birim_fiyat) AS toplam_ciro
FROM Satislar
GROUP BY kategori
ORDER BY toplam_ciro DESC;
GO

-- 7. Urunlerin toplam gelirdeki yuzdesi
SELECT
    urun_adi,
    SUM(adet * birim_fiyat) AS toplam_gelir,
    CAST(
        SUM(adet * birim_fiyat) * 100.0 /
        SUM(SUM(adet * birim_fiyat)) OVER ()
        AS DECIMAL(5,2)
    ) AS gelir_yuzdesi
FROM Satislar
GROUP BY urun_adi
ORDER BY toplam_gelir DESC;
GO



