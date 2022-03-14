
//ECON 6645 - Assignment 1

cd "D:\Documents\MA Economics\Courses - Winter 2022\ECON6645 - Applied Econometrics\Assignment 1"

//1
use "D:\Documents\MA Economics\Courses - Winter 2022\ECON6645 - Applied Econometrics\Assignment 1\Birth.dta"

//1a
eststo clear
eststo: reg birth_weight gdp_cap
esttab using tab1.tex

//1b
reg birth_weight gdp_cap
predict y_hat

global infile="D:\Documents\MA Economics\Courses - Winter 2022\ECON6645 - Applied Econometrics\Assignment 1\tex files"
twoway (scatter birth_weight gdp_cap) (line y_hat gdp_cap), ytitle("Birth Weight (grams)") xtitle("GDP per capita (USD)") subtitle("Linear Regression Fit for Predicted Birth Weight on GDP per capita")
graph export "$infile\graph1.pdf", as(pdf)
!epstopdf "$infile\graph1.eps"

//2
use "D:\Documents\MA Economics\Courses - Winter 2022\ECON6645 - Applied Econometrics\Assignment 1\CCHS.dta", clear

//2a
g ln_income = log(income)

eststo clear
eststo: reg health ln_income educ_yrs age

//2b
eststo: reg health ln_income educ_yrs c.age##c.age

//2c
g imm_ysm123=.
replace imm_ysm123=1 if imm==1 & ysm==1 
replace imm_ysm123=1 if imm==1 & ysm==2 
replace imm_ysm123=1 if imm==1 & ysm==3
	replace imm_ysm123=0 if imm_ysm123!=1

eststo: reg health ln_income educ_yrs c.age##c.age imm ysm imm_ysm123
esttab using tab2.tex

//3
use "D:\Documents\MA Economics\Courses - Winter 2022\ECON6645 - Applied Econometrics\Assignment 1\SLID.dta", clear

//3a
tab educ_level, gen(educ_level)
tab region, gen(region)

eststo clear
eststo: reg wage experience union manager big_firm ib4.educ_level ib3.region [pweight=region]
eststo: reg wage experience union manager big_firm ib4.educ_level ib3.region [pweight=educ_level]
esttab using tab3.tex

//3b
eststo clear
eststo: reg wage c.educ_yrs##i.female c.experience##i.female i.union##i.female i.manager##i.female i.big_firm##i.female 
esttab using tab4.tex












