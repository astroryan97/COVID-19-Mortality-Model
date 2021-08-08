# COVID-19-Mortality-Model
# DATA 603 Final Project

**Authors:**
Ryan Johnston (https://github.com/astroryan97) <br>
Jacob Greenbow (https://github.com/jgreenbow) <br>
Troy Stolz (https://github.com/Salsasharkz) <br>

## Introduction

The coronavirus (COVID-19) pandemic is one of the most globally disruptive events in decades. 
It first appeared in Wuhan, China during December of 2019 and quickly spread across the entire world in a matter of months (World Health Organisation 2019). Currently, there are approximately 48 million cases and 1.2 million deaths globally, and several countries in Europe are already experiencing a second wave of the virus (Johns Hopkins University 2020, Cacciapaglia et al. 2020).

There has been an extensive amount of research that has been done over the past year on COVID-19, including the origin and cause, the spread of the virus, treatment, and  a possible cure or vaccination (An-dersen et al. 2020, van Doremalen et al. 2020, Xu & Li 2020). Additionally, there has also been a large number of studies investigating non-medial aspects related to COVID-19 such as it's impact on the economy, the role of politics, religion, and how it has changed human culture  (McKibbin & Fernando 2020). However, there are still plenty of unknowns that remain as the COVID-19 pandemic continues into 2021 and possibly 2022. In this project we will explore the statistical modelling of COVID-19 data in the United States to predict the number of deaths caused by COVID-19 infections.

This readme is a summary of our work. **Please read the final report for a full breakdown.**

## Methodology
### The Data

Our dataset, COVID-19 Case Surveillance Public Use Data (https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf), is a compilation of all cases shared with the CDC. The data collection process is multistage. First the data produced by public health sources such as laboratories and hospitals is reported to local health authorities. These include U.S. states and autonomous reporting entities, such as New York City and the District of Columbia, as well as U.S. territories. From there, the data is shared with the CDC.

Each case provided in the dataset includes gender, age group, race, hospitalization and ICU admission, date of onset, date of testing positive, the presence of comorbidities, and death status. Not every case has complete information as the focus of the dataset is inclusion rather than completeness. All data is included in a single file that occupies 594MB on disk. The CSV table contains about 5.7 million rows and 11 columns. 

The dataset is intended for public access and use. No license information was provided. Since it was most likely prepared by an officer or employee of the United States government as part of their official duties it is considered a U.S. Government Work. 

### Variable Explanations and Data Assumptions
Our goal was to use our dataset to predict the number of deaths caused by COVID-19 infections. To accomplish this we used 7 independent variables, three are categorical, and the other fourare integers. The variables are described as follows:
1. **Rolling Death Rate** – The two week rolling average death rate. **Dependent Variable**
2. **Age Group** – Age range of the person, 10 year resolution (e.g.  50-59 years old) **Independent Categorical Variable**
3. **Race and Ethnicity Combined** – The ethnicity of the individual (e.g.  Black, White, His-panic/Latino, Asian, Native, Hawaiian, or mixed/other).  **Independent Categorical Variable**
4. **Sex** – The sex of the individual, male or female. **Independent Categorical Variable**
5. **Cases** – The number of cases recorded over 2 weeks grouped by age **Independent Variable**
6. **Hospitalization** – The number of cases that required hospitalization. **Independent Variable**
7. **ICU Admission** – The number of cases that required ICU admission **Independent Variable**
8. **Medical Condition** – The number of cases where a separate medical condition was present.**Independent Variable**
 
Our modelling process relies on several assumptions about our data. If they are not met our results may not be trustworthy. Therefore, we will provide a thorough analysis of the following assumptions:
1. **Linearity Assumption** – Observe if there are no patterns in residual plots
2. **Independence Assumption** – This is particularly concerning for us as we are using time-series data. Checked by observing any trends or clumping behaviour in residuals.
3. **Equal Variance Assumption** – Can use the Breusch-Pagan test for heteroscedasticity.
4. **Normality Assumption** – Can check for normality using histograms and Q-Q plots. We can also use the Kolmogorov-Smirnov or Shapiro-Wilk tests.
5. **Multicollinearity** – We will test for multicollinearity with Variance Inflation Factors (VIF)
6. **Outliers** – Can check using residuals vs leverage plot, Cooks distance, and leverage points.

### Modelling

We are modelling our data using a multiple linear regression.  It should be noted that we are using an inappropriate choice of model for time-series data such as this.  However, we will still be able to gain some insights into the nature of factors that influence COVID-19 mortality.

The first step in our plan to model the data is to create a first order model using all seven of ourvariables defined earlier. Since multicollinearity is a potential problem with our dataset we first select variables using VIF.

After the initial predictor variable selection by VIF we then use t-testing to determine the significance of of each predictor. Using these predictors we will create an interaction model and asecond-order model. Both are again evaluated using the F-statistic and t-test to select our bestmodel going forward.

The best model will then be picked which we will test for the assumptions presented above. If the model does not satisfy all of our assumptions we will attempt to to perform a Box-Cox or logarithmic transformation on the model. From these we will retest our models assumptions todetermine the best possible model to predict COVID-19 deaths

## Conclusions 

From  our  results, we find  that the best fitted model includes the main effects of *age_group,race_ethnicity*, *sex*, *cases*, *hosp*, and *icu*. But severe pre-existing medical conditions was not found to be a significant predictor (P−value > 0.05). This was based on the individual t−test and confirmed by the all-possible-regressions selection procedure. Additionally, the best fitted model also includes 9 significant interaction  terms such as *age_group−race_ethnicity*, *age_group−sex*, *age_group−cases*, *race_ethnicity−sex*, *sex−hosp*, *sex−icu*, *cases−hosp*, *cases−icu*, and *hosp−icu*. Furthermore, we also find that the higher order quadratic terms ofthe cases, hosp, and icu variables are also significant enough to be included in the model.

Finally, a Box-Cox transformation of 0.040 on the model led to an increase in the model’s effectiveness. Our final model provides us with adjusted r-squared of 0.892, and an RMSE of 0.627. This means that the model that was constructed in this project can explain 89.20% of the variance present inthe data. This is a significant increase from the first order model that only gave us an adjusted r-squared of 0.451 or 45.05% and RMSE = 14.56. 

The RMSE is a measure of how far from the regression the data points are. So, in the final model,the data points are on average 0.627 units away from the predicted regression compared to thefirst order model of 14.56 units away from the regression. When undoing our Box-Cox trans-formation, that means that our estimate of the rolling average is typically off by 1.872 deaths. Our final model is stated in the final report

According to the individual t−tests the most significant predictors of the chosen model werefound to be the number of patients in hospital, the number of ICU patients, and the numberof active cases. Likewise, the category of a person’s age was also significant. For example, if an individual was 80 years or older, the death count would increase by 27.51 and decreases by −1.570 if a person is 30−39 years of age, all else being equal. Furthermore, people with certain ethnicity’s were found to affect the death count more than others. We found that people of Asian descent would increase the death count by 4.337.

## Caveats

There are many factors that play a part in the severity of COVID-19 infections. Thus, it can beincredibly difficult to create a complete and robust model for data that involves the virus. Our main concern going into the project was that our independent variables were largely time dependent. This had the potential to cause massive collinearity in our model. On initial attempts we had that exact problem with some values showing VIF values to the order of hundreds orthousands. We were able to overcome this problem for the most part by grouping our data byweek and summing our case counts, hospitalizations, and ICU admission over that period oftime. This was a welcome surprise that we were able to remove most of the collinearity fromour data.

Perhaps in our efforts to remove the collinearity from the model we were too zealous with ourdata processing. As we found that even the best fitted model failed all of the assumption checksboth before and after the Box-cox transformation was applied, meaning that the steps one would ordinarily take to deal with heteroscedasticity and non-normality did not work in this case. The only exception to this was the multicollinearity check as it did pass. Normality was not found to hold based on the Shapiro–Wilk test, and heteroscedasticity was found to still be present according to the Breusch–Pagan test. We also find that the condition of linearity may be highly suspect due to the artifacts of diagonal lines present on the left side of the graph. Even removing outliers and leverage points seems to have only a marginal effect on the improvementof the model. 

A large surprise to us was that medical conditions other than COVID-19 seemingly had no effect on negative outcomes for cases that were included in our model. We all have surely heard that a variety of health conditions could lead to more serious complications of the virus, such as diabetes, high blood pressure, and cancer (https://www.cdc.gov/coronavirus/2019-ncov/need-extra-precautions/evidence-table.html23). Perhaps a lot of the the cases with medical conditions were suppressed by the CDC when reporting the data to protect the identities of the cases included in the data. The model is naive in many ways, including to developments in time-series modelling. In the data processing phase, we did not account for the overall clinical course of COVID-19 as the dataset made it challenging to estimate. Most recorded cases only had one date to work with,but ideally we would have been able to know the dates of symptom onset, hospitalization, ICU admission and death if relevant. The day of hospitalization could have been shifted back 5-8 days, the day of ICU admission 9-12 days, and the day of death 15-22 days to model the expected progression of the illness.

Instead, we had to infer the relevant date given the information we had. As a result, a large amount of noise was introduced by variance in dating the actual events concerned. Ideally, we would have found a dataset which was already aggregated into daily totals. 

As a point of learning, it would also have been prudent to make smaller groupings for the cate-gorical variables. There was little need to distinguish between 9 different age categories when 3 or 4 would have sufficed. This contributed to the complexity and over-fitting of the model. Separate models for age and race may have also been a positive choice as the interaction betweenthose terms created a very large amount of overhead.

Some of the interesting results come from seeing which interaction terms were significant andwhat their impact was. For instance:
1. The risk factor for males is more pronounced for Latino and Black racial backgrounds. 
2. The risk factor for males is most pronounced in young to middle age groups, between 20-50 years.
3. White racial background has a much higher expected death rate in the model. This is likely an artifact of a disproportionate sample given that it is the most common racial background in the U.S. Unfortunately, while these results are interesting, they cannot be relied upon. 

Despite our best efforts, this model was unable to satisfy the necessary conditions for reliable usage. To some extent, it was never going to be successful due to the inherit flaws of modelling time-series datawith a multiple linear regression.

## References
Berry, I., Soucy, J.-P. R., Tuite, A. & Fisman, D. (2020a), ‘Covid-19 canada open data working group’,"GitHub".https://github.com/ishaberry/Covid19CanadaLast Accessed: 11-20-2020.

Berry, I., Soucy, J.-P. R., Tuite, A. & Fisman, D. (2020b), ‘Open access epidemiologic data and an interactive dashboard to monitor the COVID-19 outbreak in canada’,Canadian Medical Association Journal 192(15), E420–E420. https://doi.org/10.1503/cmaj.75262.

Cacciapaglia, G., Cot, C. & Sannino, F. (2020), ‘Second wave COVID-19 pandemics in europe: a tem-poral playbook’,Scientific Reports 10(1). https://doi.org/10.1038/s41598-020-72611-5.

Centers for Disease Control and Prevention (2020), ‘Covid-19 case surveillance publicuse data’, U.S. Government’s Open Data.https://catalog.data.gov/dataset/covid-19-case-surveillance-public-use-data, Last Accessed: 11-06-2020.

Johns Hopkins University (2020), ‘Covid-19 dashboard by the center for systems science and engi-neering (csse) at johns hopkins university (jhu)’.https://gisanddata.maps.arcgis.com/apps/opsdashboard/index.html#/bda7594740fd40299423467b48e9ecf6, Last accessed on 2020-04-11.

McKibbin, W. J. & Fernando, R. (2020), ‘The global macroeconomic impacts of COVID-19: Sevenscenarios’,SSRN Electronic Journal.https://doi.org/10.2139/ssrn.3547729.van 

Doremalen, N. et al. (2020), ‘Aerosol and surface stability of SARS-CoV-2 as compared with SARS-CoV-1’, New England Journal of Medicine 382(16), 1564–1567. https://doi.org/10.1056/nejmc2004973.

World Health Organisation (2019), ‘Coronavirus (covid-19) outbreak’. http://www.who.int/mediacentre/factsheets/fs282/fr/, Last accessed on 2020-04-11.

Xu, S. & Li, Y. (2020), ‘Beware of the second wave of COVID-19’, The Lancet 395(10233), 1321–1322.https://doi.org/10.1016/s0140-6736(20)30845-x.

