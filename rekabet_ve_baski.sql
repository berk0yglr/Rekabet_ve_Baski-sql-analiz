USE Students;
GO

-- 1. Çalışma ortamının ev ve akran baskısına etkisini inceleme
SELECT 
    Study_Environment,
    COUNT(*) AS Ogrenci_Sayisi,
    CAST(AVG(Academic_pressure_from_your_home) AS INT) AS Ort_Ev_Baskisi,
    CAST(AVG(Peer_pressure) AS INT) AS Ort_Akran_Baskisi
FROM dbo.[academic Stress level - maintainance 1]
WHERE Study_Environment IS NOT NULL  
GROUP BY Study_Environment
ORDER BY Ort_Ev_Baskisi DESC;

-- 2. Risk gruplarını sınıflandırma 
SELECT 
    Your_Academic_Stage,
    Study_Environment,
    Peer_pressure,
    Academic_pressure_from_your_home,
    CASE 
        WHEN Peer_pressure + Academic_pressure_from_your_home >= 8 THEN 'Cok Yuksek Risk'
        WHEN Peer_pressure + Academic_pressure_from_your_home >= 5 THEN 'Orta Risk'
        ELSE 'Dusuk Risk'
    END AS Mental_Saglik_Durumu
FROM dbo.[academic Stress level - maintainance 1]
ORDER BY (Peer_pressure + Academic_pressure_from_your_home) DESC; -- Toplam baskıya göre sıralamak daha mantıklı olabilir

-- 3. Kötü alışkanlığı olmayan öğrencilerin başa çıkma stratejileri
SELECT 
    What_coping_strategy_you_use_as_a_student AS Strateji,
    COUNT(*) AS Kisi_Sayisi
FROM dbo.[academic Stress level - maintainance 1]
WHERE Do_you_have_any_bad_habits_like_smoking_drinking_on_a_daily_basis = 'No'
GROUP BY What_coping_strategy_you_use_as_a_student
ORDER BY Kisi_Sayisi DESC;

-- 4. Akademik rekabet algısı yüksek olanlarda ev baskısı ortalaması
SELECT 
    What_would_you_rate_the_academic_competition_in_your_student_life AS Rekabet_Algisi,
    AVG(Academic_pressure_from_your_home) AS Ev_Baskisi_Ortalamasi
FROM dbo.[academic Stress level - maintainance 1]
GROUP BY What_would_you_rate_the_academic_competition_in_your_student_life
HAVING AVG(Academic_pressure_from_your_home) > 2 
ORDER BY Rekabet_Algisi DESC;
