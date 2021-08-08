select * from covid_19_us;

-- select distinct current_status from covid_19_us limit 2;
-- select distinct sex from covid_19_us limit 6;
-- select distinct age_group from covid_19_us limit 11;
-- select distinct `Race and ethnicity (combined)` from covid_19_us limit 8;

-- select * from us_covid_daily;
-- select * from us_covid_weekly;

select cdc_report_dt, count(*) as total_cases from covid_19_us 
group by cdc_report_dt;

select onset_dt, count(*) as case_onset from covid_19_us 
where onset_dt != "0000-00-00"
group by onset_dt;

select cdc_report_dt, count(*) as confirmed_cases from covid_19_us
where current_status = "Laboratory-confirmed case"
group by cdc_report_dt;

select cdc_report_dt, count(*) as male from covid_19_us
where sex = "Male"
group by cdc_report_dt;

select cdc_report_dt, count(*) as age_0_9 from covid_19_us
where age_group = "0 - 9 Years"
group by cdc_report_dt;

select cdc_report_dt, count(*) as age_10_19 from covid_19_us
where age_group = "10 - 19 Years"
group by cdc_report_dt;

select cdc_report_dt, count(*) as age_20_29 from covid_19_us
where age_group = "20 - 29 Years"
group by cdc_report_dt;

select cdc_report_dt, count(*) as age_30_39 from covid_19_us
where age_group = "30 - 39 Years"
group by cdc_report_dt;

select cdc_report_dt, count(*) as age_40_49 from covid_19_us
where age_group = "40 - 49 Years"
group by cdc_report_dt;

select cdc_report_dt, count(*) as age_50_59 from covid_19_us
where age_group = "50 - 59 Years"
group by cdc_report_dt;

select cdc_report_dt, count(*) as age_60_69 from covid_19_us
where age_group = "60 - 69 Years"
group by cdc_report_dt;

select cdc_report_dt, count(*) as age_70_79 from covid_19_us
where age_group = "70 - 79 Years"
group by cdc_report_dt;

select cdc_report_dt, count(*) as age_80_up from covid_19_us
where age_group = "80+ Years"
group by cdc_report_dt;

select cdc_report_dt, count(*) as race_asian from covid_19_us
where `Race and ethnicity (combined)` = "Asian, Non-Hispanic"
group by cdc_report_dt;

select cdc_report_dt, count(*) as race_multiple from covid_19_us
where `Race and ethnicity (combined)` = "Multiple/Other, Non-Hispanic"
group by cdc_report_dt;

select cdc_report_dt, count(*) as race_black from covid_19_us
where `Race and ethnicity (combined)` = "Black, Non-Hispanic"
group by cdc_report_dt;

select cdc_report_dt, count(*) as race_hispanic from covid_19_us
where `Race and ethnicity (combined)` = "Hispanic/Latino"
group by cdc_report_dt;

select cdc_report_dt, count(*) as race_amer_indian from covid_19_us
where `Race and ethnicity (combined)` = "American Indian/Alaska Native, Non-Hispanic"
group by cdc_report_dt;

select cdc_report_dt, count(*) as race_island from covid_19_us
where `Race and ethnicity (combined)` = "Native Hawaiian/Other Pacific Islander, Non-Hispanic"
group by cdc_report_dt;

select cdc_report_dt, count(*) as race_white from covid_19_us
where `Race and ethnicity (combined)` = "White, Non-Hispanic"
group by cdc_report_dt;

select cdc_report_dt, count(*) as hosp from covid_19_us
where hosp_yn = "Yes"
group by cdc_report_dt;

select cdc_report_dt, count(*) as icu from covid_19_us
where icu_yn = "Yes"
group by cdc_report_dt;

select cdc_report_dt, count(*) as medcond from covid_19_us
where medcond_yn = "Yes"
group by cdc_report_dt;

select cdc_report_dt, count(*) as deaths from covid_19_us
where death_yn = "Yes"
group by cdc_report_dt;

