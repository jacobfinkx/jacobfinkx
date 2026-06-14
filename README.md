## Hi there, I'm Jacob 👋

I'm an aspiring data analyst with experience in R, Python, SQL, and econometric modeling.  
I enjoy turning messy data into clear insights and building clean, reproducible workflows.

🎓 BBA in Economics  
📊 Interests: econometrics, data visualization, and analytics projects  
🚀 Currently building my data analytics portfolio here on GitHub

---

## 📄 Econometric Research Paper

**Title:** The Impact of Ability Grouping on Academic Performance   
**Topic:** An analysis of how ability grouping affects school-wide performance.

👉 [**Read the Full Research Paper (PDF)**](./Econometric%20Research%20Paper.pdf)

### Abstract
This paper investigates the impact of ability grouping on student performance using both 
student level and school level data from the PISA (Program for International Student 
Assessment) in 2009. A series of regression models were used to show a naive comparison, a 
comparison involving school level controls, and a comparison using school level controls, 
student level controls, and a country-by-grade fixed effect. My findings suggest that ability 
grouping does lead to a slight increase in PV1 scores, therefore an increase in academic 
performance, but not by as much as expected. Controlling for school-level, student-level, 
country-level, and grade-level effects shows a minor effect of ability grouping. Instead, PV1 
assessment scores are impacted by many underlying differences between schools and students. 
The results suggest that broader socioeconomic and educational conditions play a more decisive 
role in student performance.

## 📊 Key Charts & Visuals

### Chart 1: [Pre Treatment Comparability]
![Chart 1](./Pre_Treatment_Comparability)

### Chart 2: [Results]
![Chart 2](./Graphical_Results)

## 🧮 Stata Code Used in This Analysis

This project includes the full Stata `.do` file used to clean the data, run regressions, and generate the statistical outputs for the research paper.

👉 [**View the Full Stata Code (.do)**](./Research_Project_Do.do)

### Code Preview
```stata
* Example snippet
reg PV1MATH all_abgroup some_abgroup i.countryxgrade SCHSIZE govfunding stufeefunding benefactfunding  private littleshortage moreshortage alotshortage DISCLIMA SCMATEDU firstgen secondgen abs_verylittle abs_someextent abs_alot studyplace outofschoollessons parent_hs parent_somecollege parent_collegedegree parent_graduatedegree ESCS foreignlanghome female, cl(SCHOOLID)

---
