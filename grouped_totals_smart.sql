select * from covid_19_us;

-- select distinct current_status from covid_19_us limit 2;
-- select distinct sex from covid_19_us limit 6;
-- select distinct age_group from covid_19_us limit 11;
-- select distinct `Race and ethnicity (combined)` from covid_19_us limit 8;
select `Race and ethnicity (combined)`, count(*) from covid_19_us
group by `Race and ethnicity (combined)`;

select sex, count(*) from covid_19_us
group by sex;

-- select * from us_covid_daily;
-- select * from us_covid_weekly;

-- select * from covid_19_us
-- where ;

create temporary table if not exists `temp_cases1` (
	`date` DATE default NULL,
	`hosp` INT default NULL,
	`icu` INT default NULL,
    `medcond` INT default NULL,
	`deaths` INT default NULL,
	`onset` INT default NULL
) engine=InnoDB;

insert into `temp_cases1`
select med.*, onset from
	(select cdc_report_dt, 
		sum(case hosp_yn when "Yes" then 1 else 0 end) as hosp,
		sum(case icu_yn when "Yes" then 1 else 0 end) as icu,
		sum(case medcond_yn when "Yes" then 1 else 0 end) as medcond,
		sum(case death_yn when "Yes" then 1 else 0 end) as deaths
	from covid_19_us 
	group by cdc_report_dt) as med
join
	(select onset_dt, count(*) as onset from covid_19_us 
	where onset_dt != "0000-00-00"
	group by onset_dt) as onset
on cdc_report_dt = onset_dt;

create temporary table if not exists `temp_cases2` (
	`date` DATE default NULL,
	`total_rep` INT default NULL,
	`conf` INT default NULL,
	`male` INT default NULL
) engine=InnoDB;

insert into `temp_cases2`
select cdc_report_dt, 
	count(*) as total_cases,
	sum(case current_status when "Laboratory-confirmed case" then 1 else 0 end) as confirmed_cases,
    sum(case sex when "Male" then 1 else 0 end) as male
from covid_19_us
group by cdc_report_dt;

create temporary table if not exists `temp_cases3` (
	`date` DATE default NULL,
    `age0_29` INT default NULL,
    `age30_39` INT default NULL,
    `age40_49` INT default NULL,
    `age50_59` INT default NULL,
    `age60_69` INT default NULL,
    `age70_79` INT default NULL,
    `age80_up` INT default NULL
) engine=InnoDB;

insert into `temp_cases2`
select cdc_report_dt, 
    sum(case age_group when "0 - 9 Years" then 1
		when "10 - 19 Years" then 1
        when "20 - 29 Years" then 1
		else 0 end) as age0_29, 
    sum(case age_group when "30 - 39 Years" then 1 else 0 end) as age30_39, 
	sum(case age_group when "40 - 49 Years" then 1 else 0 end) as age40_49, 
    sum(case age_group when "50 - 59 Years" then 1 else 0 end) as age50_59, 
    sum(case age_group when "60 - 69 Years" then 1 else 0 end) as age60_69, 
    sum(case age_group when "70 - 79 Years" then 1 else 0 end) as age70_79, 
    sum(case age_group when "80+ Years" then 1 else 0 end) as age80_up
from covid_19_us
group by cdc_report_dt;

create temporary table if not exists `temp_cases4` (
	`date` DATE default NULL,
    `r_asian` INT default NULL,
    `r_black` INT default NULL,
    `r_mult` INT default NULL,
    `r_hisp` INT default NULL
) engine=InnoDB;

insert into `temp_cases2`
select cdc_report_dt,
    sum(case `Race and ethnicity (combined)` when "Asian, Non-Hispanic" then 1 else 0 end) as r_asian,
    sum(case `Race and ethnicity (combined)` when "Multiple/Other, Non-Hispanic" then 1 else 0 end) as r_mult,
    sum(case `Race and ethnicity (combined)` when "Black, Non-Hispanic" then 1 else 0 end) as r_black, 
    sum(case `Race and ethnicity (combined)` when "Hispanic/Latino" then 1 else 0 end) as r_hisp
from covid_19_us
group by cdc_report_dt;

-- full combined query
select med.*, onset from
	(select cdc_report_dt, 
	count(*) as total_cases,
	sum(case current_status when "Laboratory-confirmed case" then 1 else 0 end) as confirmed_cases,
    sum(case sex when "Male" then 1 else 0 end) as male, 
    sum(case age_group when "0 - 9 Years" then 1
		when "10 - 19 Years" then 1
        when "20 - 29 Years" then 1
		else 0 end) as age0_29, 
    sum(case age_group when "30 - 39 Years" then 1 else 0 end) as age30_39, 
	sum(case age_group when "40 - 49 Years" then 1 else 0 end) as age40_49, 
    sum(case age_group when "50 - 59 Years" then 1 else 0 end) as age50_59, 
    sum(case age_group when "60 - 69 Years" then 1 else 0 end) as age60_69, 
    sum(case age_group when "70 - 79 Years" then 1 else 0 end) as age70_79, 
    sum(case age_group when "80+ Years" then 1 else 0 end) as age80_up,
    sum(case `Race and ethnicity (combined)` when "Asian, Non-Hispanic" then 1 else 0 end) as r_asian,
    sum(case `Race and ethnicity (combined)` when "Multiple/Other, Non-Hispanic" then 1 else 0 end) as r_mult,
    sum(case `Race and ethnicity (combined)` when "Black, Non-Hispanic" then 1 else 0 end) as r_black, 
    sum(case `Race and ethnicity (combined)` when "Hispanic/Latino" then 1 else 0 end) as r_hisp,
    sum(case hosp_yn when "Yes" then 1 else 0 end) as hosp,
    sum(case icu_yn when "Yes" then 1 else 0 end) as icu,
    sum(case medcond_yn when "Yes" then 1 else 0 end) as medcond,
    sum(case death_yn when "Yes" then 1 else 0 end) as deaths
from covid_19_us
group by cdc_report_dt) as med
join
	(select onset_dt, count(*) as onset from covid_19_us 
	where onset_dt != "0000-00-00"
	group by onset_dt) as onset
on cdc_report_dt = onset_dt;

-- group by age
select med.*, onset from
	(select cdc_report_dt, 
    age_group,
	count(*) as total_cases,
	sum(case current_status when "Laboratory-confirmed case" then 1 else 0 end) as confirmed_cases,
    sum(case sex when "Male" then 1 else 0 end) as male, 
    sum(case `Race and ethnicity (combined)` when "Asian, Non-Hispanic" then 1 else 0 end) as r_asian,
    sum(case `Race and ethnicity (combined)` when "Multiple/Other, Non-Hispanic" then 1 else 0 end) as r_mult,
    sum(case `Race and ethnicity (combined)` when "Black, Non-Hispanic" then 1 else 0 end) as r_black, 
    sum(case `Race and ethnicity (combined)` when "Hispanic/Latino" then 1 else 0 end) as r_hisp,
    sum(case hosp_yn when "Yes" then 1 else 0 end) as hosp,
    sum(case icu_yn when "Yes" then 1 else 0 end) as icu,
    sum(case medcond_yn when "Yes" then 1 else 0 end) as medcond,
    sum(case death_yn when "Yes" then 1 else 0 end) as deaths
from covid_19_us
group by cdc_report_dt, age_group) as med
join
	(select onset_dt, count(*) as onset from covid_19_us 
	where onset_dt != "0000-00-00"
	group by onset_dt, age_group) as onset
on cdc_report_dt = onset_dt
where cdc_report_dt > "2020-03-15";

-- group by race

-- group by age, race, and sex
select cdc_report_dt, 
    age_group,
    `Race and ethnicity (combined)`,
    sex,
	count(*) as reported_cases,
	sum(case current_status when "Laboratory-confirmed case" then 1 else 0 end) as confirmed_cases,
    sum(case hosp_yn when "Yes" then 1 else 0 end) as hosp,
    sum(case icu_yn when "Yes" then 1 else 0 end) as icu,
    sum(case medcond_yn when "Yes" then 1 else 0 end) as medcond,
    sum(case death_yn when "Yes" then 1 else 0 end) as deaths
from covid_19_us
where cdc_report_dt >= "2020-04-01"
and age_group != "NA"
and age_group != "Unknown"
and `Race and ethnicity (combined)` != "NA"
and `Race and ethnicity (combined)` != "Unknown"
and (sex = "Male" or sex = "Female")
group by cdc_report_dt, `Race and ethnicity (combined)`, age_group, sex;

