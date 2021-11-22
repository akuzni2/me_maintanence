-- https://www.aafp.org/dam/AAFP/documents/patient_care/clinical_recommendations/cps-recommendations.pdf
-- https://www.uspreventiveservicestaskforce.org/uspstf/recommendation-topics/uspstf-and-b-recommendations
INSERT INTO recommended_preventative_services (id, search_term, title, description, gender, age_range_min, age_range_max, smoking_history, recurring, annual_interval)
VALUES
(1, 'Womans Imaging', 'Breast Cancer Mammography', 'The USPSTF recommends biennial screening mammography for women aged 50 to 74 years.', 'female', 50, 74, false, true, 1),
(2, 'Primary Care Doctor', 'Abdominal Aortic Aneurysm Screening', 'The USPSTF recommends 1-time screening for abdominal aortic aneurysm (AAA) with ultrasonography in men aged 65 to 75 years who have ever smoked.', 'male', 65, 75, true, false, null),
(3, 'Primary Care Doctor', 'Basic Physical Exam', 'Exam covering the Basics · Neurological Exam. Nerves, muscle strength, reflexes, balance, and mental state may be assessed. As well as assessing risk for cardiovascular health by performing blood pressure measurements and taking blood samples to assess cholesterol.', 'all', 1, null, false, true, 1),
(4, 'Oncology', 'Cervical Cancer Screening', 'The USPSTF recommends screening for cervical cancer depending on your age range with 3 years being the average.', 'female', 21, 65, false, true, 3),
(5, 'Oncology', 'Colorectal Cancer Screening', 'The USPSTF recommends screening for colorectal cancer in all adults aged 50 to 75 years.', 'all', 50, 75, false, true, 5),
(6, 'Primary Care Doctor', 'Depression Screening', 'The USPSTF found convincing evidence that screening improves the accurate identification of adult patients with depression in primary care settings, including pregnant and postpartum women.', 'all', 12, 75, false, false, null),
(7, 'Primary Care Doctor', 'HIV Infection Screening', 'CDC recommends that everyone between the ages of 13 and 64 get tested for HIV at least once as part of routine health care.', 'all', 13, 65, false, false, null),
(8, 'osteoporosis', 'Osteoporosis Screening', 'A bone density test determines if you have osteoporosis — a disorder characterized by bones that are more fragile and more likely to break.', 'female', 65, null, false, false, null),
(9, 'Dentist', 'Dental Cleaning', 'The American Dental Association recommends that you visit your dentist at least once a year to get a routine examination and cleaning', 'all', 1, null, false, true, 1),
(10, 'Flu Shot', 'Immunization - Flu', 'The CDC recommends an annual flu vaccination for anyone 6 months of age and older.', 'all', 65, null, false, true, 1),
(11, 'Covid 19 Vaccine', 'Immunization - COVID-19', 'The CDC recommends all eligible adults receive the Covid-19 vaccine. Additionally the CDC now recommends that children between the ages of 5-11 receive the Pfizer vaccine.', 'all', 18, null, false, false, null),
(12, 'Primary Care Doctor', 'Immunization - Tetanus', 'CDC recommends tetanus vaccination for all babies and children, preteens and teens, and adults to protect against tetanus.', 'all', 10, null, false, true, 10),
(13, 'Optometrist', 'Eye Exam', 'It is recommended that patients receive regular recurring eye exams.', 'all', 5, null, false, true, 5);
