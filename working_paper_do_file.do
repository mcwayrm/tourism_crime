### 61 variables, 242 observations pasted into data editor
reshape long zillow_price_ airbnb_count_ misdemeanor_count_ felony_count_ violation_count_, i(neighbourhood) j(month) string 
encode neighbourhood, generate(neighbourhood_numeric)
encode month, generate(month_numeric)
tsset neighbourhood_numeric month_numeric
sum zillow_price_ airbnb_count_ misdemeanor_count_ felony_count_ violation_count_
reg zillow_price_ airbnb_count_ misdemeanor_count_ felony_count_ violation_count_
xtreg zillow_price_ airbnb_count_ misdemeanor_count_ felony_count_ violation_count_,fe
eststo fe
xtreg zillow_price_ airbnb_count_ misdemeanor_count_ felony_count_ violation_count_
eststo re
hausman fe re
encode borough, generate(borough_numeric)
tab borough_numeric, gen(dum)
gen lzillow=log(zillow_price_)
xtreg lzillow dum1 dum2 dum3 dum4 dum5 c.airbnb_count_##c.airbnb_count_ c.misdemeanor_count_##c.misdemeanor_count_ c.felony_count_##c.felony_count_ c.violation_count_##c.violation_count_ c.airbnb_count_#c.felony_count_ i.dum3#c.airbnb_count_ i.dum1#c.felony_count_
gen airbnbsq = c.airbnb_count_*c.airbnb_count_
gen misdemsq = c.misdemeanor_count_*c.misdemeanor_count_
gen felonysq = c.felony_count_*c.felony_count_
gen violsq = c.violation_count_*c.violation_count_
gen airbnbfel = c.airbnb_count_*c.felony_count_
gen manhattairbnb = dum3*c.airbnb_count_
gen bxfelony = dum1*c.felony_count_
xi: xthtaylor lzillow dum1 dum2 dum3 dum4 dum5 airbnb_count_ airbnbsq misdemeanor_count_ misdemsq felony_count_ felonysq violation_count_ violsq airbnbfel manhattairbnb bxfelony, endog(misdemeanor_count_ felony_count_ violation_count_)
xthtaylor lzillow dum1 dum2 dum3 dum4 dum5 airbnb_count_ airbnbsq misdemeanor_count_ misdemsq felony_count_ felonysq violation_count violsq airbnbfel manhattairbnb bxfelony, endog(misdemeanor_count_ felony_count_ violation_count_)
