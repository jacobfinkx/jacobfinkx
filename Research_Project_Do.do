*Regression components: 
*Score
(PV1MATH, PV1SCIE, and PV1READ)
* ability grouping
gen no_abgroup = 0 if ABGROUP <=3
gen some_abgroup =0 if ABGROUP <=3
gen all_abgroup=0 if ABGROUP <=3
replace no_abgroup = 1 if ABGROUP ==3
replace some_abgroup =1 if ABGROUP ==2
replace all_abgroup=1 if ABGROUP ==1
* Country by grade fixed effect
egen countryxgrade = group (COUNTRY ST01Q01)
* SCHSIZE(School size)
* private (1 if private, 0 if public)
* absent (Student absenteeism 1 Not at all 2 Very little 3 To some extent 4 A lot)
gen abs_notatall =0
replace abs_notatall=1 if absent == 1
gen abs_verylittle =0
replace abs_verylittle=1 if absent ==2
gen abs_someextent =0
replace abs_someextent =1 if absent == 3
gen abs_alot =0
replace abs_alot =1 if absent ==4
* (School funding)
govfunding stufeefunding benefactfunding otherfunding
*studyplace (1 if possesses study place 0 if not)
gen studyplace =0 if SC20Q03 >0 & SC20Q03 <=2
replace studyplace =1 if SC20Q03 ==1
*outofschoollessons (1 if has out of school lessons 0 if not)
gen outofschoollessons =0 if ST32Q01 >0 & ST32Q01 <=5 | ST32Q02 >0 & ST32Q02 <=5 | ST32Q03 >0 & ST32Q03 <=5 | ST32Q04 >0 & ST32Q04 <=5
replace outofschoollessons =1 if  ST32Q01 >1 & ST32Q01 <=5 | ST32Q02 >1 & ST32Q02 <=5 | ST32Q03 >1 & ST32Q03 <=5 | ST32Q04 >1 & ST32Q04 <=5
*parent education( speak to professor about omitting variable)
gen parent_lessthanhs =0 if PARED <=18
replace parent_lessthanhs =1 if PARED <12
gen parent_hs =0 if PARED <=18
replace parent_hs =1 if PARED == 12
gen parent_somecollege =0 if PARED <=18
replace parent_somecollege =1 if PARED >12 & PARED <16
gen parent_collegedegree =0 if PARED <=18
replace parent_collegedegree =1 if PARED ==16
gen parent_graduatedegree =0 if PARED <=18
replace parent_graduatedegree =1 if PARED ==18
*foreignlanghome(1 if language at home is different from test, 0 if not)
drop foreignlanghome
gen foreignlanghome =0 if ST19Q01 <=2
replace foreignlanghome =1 if ST19Q01 ==2
gen nativelanghome =0 if ST19Q01 ==1 & ST19Q01 ==2
replace nativelanghome=1 if ST19Q01 ==1
*shortage of qualified teachers 
gen noshortage =0 if SC11Q04 <=4
replace noshortage =1 if SC11Q04 ==1
gen littleshortage =0 if SC11Q04 <=4
replace littleshortage =1 if SC11Q04 ==2
gen moreshortage =0 if SC11Q04<=4
replace moreshortage=1 if SC11Q04 ==3
gen alotshortage =0 if SC11Q04 <=4
replace alotshortage =1 if SC11Q04 ==4
*Disciplinary climate
DISCLIMA
*Immigration Status
drop firstgen
drop secondgen
drop native
gen firstgen=0 if IMMIG >=1 & IMMIG <=3
replace firstgen=1 if IMMIG ==3
gen secondgen=0 if IMMIG >=1 & IMMIG <=3
replace secondgen=1 if IMMIG ==2
gen native =0 if IMMIG >=1 & IMMIG <=3
replace native =1 if IMMIG ==1
*Quality of schools educational resourses
SCMATEDU
*Student economic, social, and cultural status
ESCS
*Gender
gen female=0 
replace female =1 if SC27Q01 ==1
gen male =0
replace male =1 if SC27Q01 ==2







*Naive Regression
reg PV1MATH all_abgroup some_abgroup

reg PV1READ all_abgroup some_abgroup

reg PV1SCIE all_abgroup some_abgroup


*Regression with school controls
reg PV1MATH all_abgroup some_abgroup SCHSIZE govfunding stufeefunding benefactfunding  private littleshortage moreshortage alotshortage DISCLIMA SCMATEDU

reg PV1READ all_abgroup some_abgroup SCHSIZE govfunding stufeefunding benefactfunding  private littleshortage moreshortage alotshortage DISCLIMA SCMATEDU

reg PV1SCIE all_abgroup some_abgroup SCHSIZE govfunding stufeefunding benefactfunding  private littleshortage moreshortage alotshortage DISCLIMA SCMATEDU


*Final Regression:
reg PV1MATH all_abgroup some_abgroup i.countryxgrade SCHSIZE govfunding stufeefunding benefactfunding  private littleshortage moreshortage alotshortage DISCLIMA SCMATEDU firstgen secondgen abs_verylittle abs_someextent abs_alot studyplace outofschoollessons parent_hs parent_somecollege parent_collegedegree parent_graduatedegree ESCS foreignlanghome female, cl(SCHOOLID)

reg PV1READ all_abgroup some_abgroup i.countryxgrade SCHSIZE govfunding stufeefunding benefactfunding  private littleshortage moreshortage alotshortage DISCLIMA SCMATEDU firstgen secondgen abs_verylittle abs_someextent abs_alot studyplace outofschoollessons parent_hs parent_somecollege parent_collegedegree parent_graduatedegree ESCS foreignlanghome female, cl(SCHOOLID)

reg PV1SCIE all_abgroup some_abgroup i.countryxgrade SCHSIZE govfunding stufeefunding benefactfunding  private littleshortage moreshortage alotshortage DISCLIMA SCMATEDU firstgen secondgen abs_verylittle abs_someextent abs_alot studyplace outofschoollessons parent_hs parent_somecollege parent_collegedegree parent_graduatedegree ESCS foreignlanghome female, cl(SCHOOLID)

* Omitted=noshortage, abs_notatall, no_abgroup, parent_lessthanhs, native

ssc install eststo

	est clear
	eststo: reg PV1MATH all_abgroup some_abgroup i.countryxgrade SCHSIZE govfunding stufeefunding benefactfunding  private littleshortage moreshortage alotshortage DISCLIMA SCMATEDU firstgen secondgen abs_verylittle abs_someextent abs_alot studyplace outofschoollessons parent_hs parent_somecollege parent_collegedegree parent_graduatedegree ESCS foreignlanghome female, cl(SCHOOLID)
		estadd ysumm
	eststo: reg PV1READ all_abgroup some_abgroup i.countryxgrade SCHSIZE govfunding stufeefunding benefactfunding  private littleshortage moreshortage alotshortage DISCLIMA SCMATEDU firstgen secondgen abs_verylittle abs_someextent abs_alot studyplace outofschoollessons parent_hs parent_somecollege parent_collegedegree parent_graduatedegree ESCS foreignlanghome female, cl(SCHOOLID)
		estadd ysumm
	eststo: reg PV1SCIE all_abgroup some_abgroup i.countryxgrade SCHSIZE govfunding stufeefunding benefactfunding  private littleshortage moreshortage alotshortage DISCLIMA SCMATEDU firstgen secondgen abs_verylittle abs_someextent abs_alot studyplace outofschoollessons parent_hs parent_somecollege parent_collegedegree parent_graduatedegree ESCS foreignlanghome female, cl(SCHOOLID)
		estadd ysumm
#d;
		esttab est1 est2 est3 using 
"C:\Users\jacob\OneDrive\Documentos\Metrics_project\working\Student09merge.dta", replace 
cells(b(fmt(a2) star) se(fmt(a2) par))

stats(ymean N, fmt(2 0) labels("Mean of Dependent Variable" "Sample Size"))			
		label																										
		legend
		collabels( ,none)
		numbers
		starlevels(* 0.10 ** 0.05 *** 0.01)
		gaps
		compress;
		
		#d cr

	esttab
	estpost summarize
	
gen treatment =0
replace treatment =1 if all_abgroup ==1 | some_abgroup ==1
drop treatment
	

	
	
tabstat SCHSIZE, by(treatment) stat(mean sd n)
tabstat STRATIO, by(treatment) stat(mean sd n)
tabstat foreignlanghome, by(treatment) stat(mean sd n)
tabstat female, by(treatment) stat(mean sd n)
tabstat AGE, by(treatment) stat(mean sd n)
tabstat ESCS, by(treatment) stat(mean sd n)
tabstat ST01Q01, by(treatment) stat(mean sd n)
tabstat DISCLIMA, by(treatment) stat(mean sd n)
tabstat private, by(treatment) stat(mean sd n)




sum ESCS
replace ESCS = . if ESCS == 9997| ESCS == 9998| ESCS == 9999

sum DISCLIMA
tab DISCLIMA
replace DISCLIMA = . if DISCLIMA == 9997 | DISCLIMA == 9999
sum STRATIO
tab STRATIO
replace STRATIO = . if STRATIO == 9997 | STRATIO ==9998 | STRATIO == 9999
tab SCMATEDU
replace SCMATEDU =. if SCMATEDU ==9997 | SCMATEDU ==9999
tab PARED 
replace PARED = . if PARED ==97 | PARED ==99
tab ABGROUP
replace ABGROUP = . if ABGROUP == 7 | ABGROUP ==9
tab ST01Q01
replace ST01Q01 = . if ST01Q01 ==13| ST01Q01 ==96| ST01Q01 ==99
tab SCHSIZE
replace SCHSIZE =. if SCHSIZE == 99997| SCHSIZE == 99999
tab govfunding
replace govfunding =. if govfunding == 9997| govfunding ==9998 | govfunding ==9999
tab benefactfunding
replace benefactfunding =. if benefactfunding ==9997| benefactfunding==9998|benefactfunding ==9999
tab stufeefunding
replace stufeefunding =. if stufeefunding==9997| stufeefunding ==9998| stufeefunding ==9999
tab otherfunding
replace otherfunding =. if otherfunding ==  9997|otherfunding ==9998| otherfunding ==9999
tab ST19Q01
replace ST19Q01 =. if ST19Q01 ==7 | ST19Q01 ==8| ST19Q01==9
tab IMMIG
replace IMMIG =. if IMMIG ==7|  IMMIG ==8|  IMMI ==9

* clear
* set obs 6

*gen model = .
*gen group = .
*gen coef  = .


*replace model = 1 in 1/2
*replace model = 2 in 3/4
*replace model = 3 in 5/6

*label define model 1 "Naive" 2 "School Controls" 3 "Full Controls"
*label values model model



*replace group = 1 in 1
*replace group = 1 in 3
*replace group = 1 in 5

*replace group = 2 in 2
*replace group = 2 in 4
*replace group = 2 in 6

*label define group 1 "All Subjects Grouped" 2 "Some Subjects Grouped"
*label values group group


* Naive
*est restore naive
*replace coef = _b[all_abgroup]  in 1
*replace coef = _b[some_abgroup] in 2

* School controls
*est restore school
*replace coef = _b[all_abgroup]  in 3
*replace coef = _b[some_abgroup] in 4

* Full controls
*est restore full
*replace coef = _b[all_abgroup]  in 5
*replace coef = _b[some_abgroup] in 6




*label define grouplab 1 "" 2 "", replace
*label values group grouplab




*graph bar coef, ///
    over(group) ///
    over(model, label(angle(20))) ///
    bargap(30) ///
    title("Effect of Ability Grouping on PV1 Math Scores Across Models") ///
    ytitle("Effect on PV1 Math Score") ///
    legend(label(1 "All Subjects Grouped") label(2 "Some Subjects Grouped") position(6))
	
	
gen grouped = (all_abgroup == 1 | some_abgroup == 1)

label define grouplab 0 "No Ability Grouping" 1 "Any Ability Grouping"
label values grouped grouplab

collapse (mean) ESCS SCHSIZE STRATIO, by(SCHOOLID grouped)



graph bar (mean) ESCS SCHSIZE STRATIO, ///
    over(grouped) ///
    title("Pre-Treatment Comparability of Schools") ///
    ytitle("Mean Value") ///
    legend(position(6)) ///
    bargap(25)


	
	
	
