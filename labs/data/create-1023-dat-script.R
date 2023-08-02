URL <- "https://github.com/DS4PS/cpp-527-spr-2020/blob/master/labs/data/f1023ez_approvals_2018.rds?raw=true"
dat <- readRDS(gzcon(url( URL )))

head( dat )



> names( dat )
  [1] "EIN"                         "Case.Number"                
  [3] "Formrevision"                "Eligibilityworksheet"       
  [5] "Orgname1"                    "Orgname2"                   
  [7] "Address"                     "City"                       
  [9] "State"                       "Zip"                        
 [11] "Zippl4"                      "Accountingperiodend"        
 [13] "Primarycontactname"          "Primarycontactphone"        
 [15] "Primarycontactphoneext"      "Primarycontactfax"          
 [17] "Userfeesubmitted"            "Ofcrdirtrust1firstname"     
 [19] "Ofcrdirtrust1lastname"       "Ofcrdirtrust1title"         
 [21] "Ofcrdirtrust1streetaddr"     "Ofcrdirtrust1city"          
 [23] "Ofcrdirtrust1state"          "Ofcrdirtrust1zip"           
 [25] "Ofcrdirtrust1zippl4"         "Ofcrdirtrust2firstname"     
 [27] "Ofcrdirtrust2lastname"       "Ofcrdirtrust2title"         
 [29] "Ofcrdirtrust2streetaddr"     "Ofcrdirtrust2city"          
 [31] "Ofcrdirtrust2state"          "Ofcrdirtrust2zip"           
 [33] "Ofcrdirtrust2zippl4"         "Ofcrdirtrust3firstname"     
 [35] "Ofcrdirtrust3lastname"       "Ofcrdirtrust3title"         
 [37] "Ofcrdirtrust3streetaddr"     "Ofcrdirtrust3city"          
 [39] "Ofcrdirtrust3state"          "Ofcrdirtrust3zip"           
 [41] "Ofcrdirtrust3zippl4"         "Ofcrdirtrust4firstname"     
 [43] "Ofcrdirtrust4lastname"       "Ofcrdirtrust4title"         
 [45] "Ofcrdirtrust4streetaddr"     "Ofcrdirtrust4city"          
 [47] "Ofcrdirtrust4state"          "Ofcrdirtrust4zip"           
 [49] "Ofcrdirtrust4zippl4"         "Ofcrdirtrust5firstname"     
 [51] "Ofcrdirtrust5lastname"       "Ofcrdirtrust5title"         
 [53] "Ofcrdirtrust5streetaddr"     "Ofcrdirtrust5city"          
 [55] "Ofcrdirtrust5state"          "Ofcrdirtrust5zip"           
 [57] "Ofcrdirtrust5zippl4"         "Orgurl"                     
 [59] "Orgemail"                    "Orgtypecorp"                
 [61] "Orgtypeunincorp"             "Orgtypetrust"               
 [63] "Necessaryorgdocs"            "Incorporateddate"           
 [65] "Incorporatedstate"           "Containslimitation"         
 [67] "Doesnotexpresslyempower"     "Containsdissolution"        
 [69] "Nteecode"                    "Orgpurposecharitable"       
 [71] "Orgpurposereligious"         "Orgpurposeeducational"      
 [73] "Orgpurposescientific"        "Orgpurposeliterary"         
 [75] "Orgpurposepublicsafety"      "Orgpurposeamateursports"    
 [77] "Orgpurposecrueltyprevention" "Qualifyforexemption"        
 [79] "Leginflno"                   "Leginflyes"                 
 [81] "Compofcrdirtrustno"          "Compofcrdirtrustyes"        
 [83] "Donatefundsno"               "Donatefundsyes"             
 [85] "Conductactyoutsideusno"      "Conductactyoutsideusyes"    
 [87] "Financialtransofcrsno"       "Financialtransofcrsyes"     
 [89] "Unrelgrossincm1000moreno"    "Unrelgrossincm1000moreyes"  
 [91] "Gamingactyno"                "Gamingactyyes"              
 [93] "Disasterreliefno"            "Disasterreliefyes"          
 [95] "Onethirdsupportpublic"       "Onethirdsupportgifts"       
 [97] "Benefitofcollege"            "Privatefoundation508e"      
 [99] "Seekingretroreinstatement"   "Seekingsec7reinstatement"   
[101] "Correctnessdeclaration"      "Mission"                    
[103] "Gamingactyno.1"              "Gamingactyyes.1"            
[105] "HospitalOrChurchNo"          "HospitalOrChurchYes"        
[107] "EZVersionNumber"             "Signaturename"              
[109] "Signaturetitle"              "Signaturedate"              
[111] "ID"     

dput( names( dat ) )


dat$orgname <- paste0( dat$Orgname1, dat$Orgname2 ) 

keep <- c( "EIN", "orgname", "Mission", 
"Nteecode", "Orgpurposecharitable", "Orgpurposereligious", "Orgpurposeeducational", 
"Orgpurposescientific", "Orgpurposeliterary", "Orgpurposepublicsafety", 
"Orgpurposeamateursports", "Orgpurposecrueltyprevention", 
"Leginflno", "Leginflyes", 
"Donatefundsno", "Donatefundsyes",
"Conductactyoutsideusno", "Conductactyoutsideusyes", 
"Compofcrdirtrustno", "Compofcrdirtrustyes", 
"Financialtransofcrsno", "Financialtransofcrsyes", 
"Unrelgrossincm1000moreno", "Unrelgrossincm1000moreyes", 
"Gamingactyno", "Gamingactyyes", 
"Disasterreliefno", "Disasterreliefyes", 
"Onethirdsupportpublic", "Onethirdsupportgifts", 
"Benefitofcollege", "Privatefoundation508e", 
"HospitalOrChurchNo", "HospitalOrChurchYes" )

d2 <- dat[ keep ]

names( d2 ) <- tolower( names( d2 ) )

head( d2 )



ntee <- read.csv( "ntee-codes.csv", stringsAsFactors = FALSE )
head( ntee )

d2$nteeprimary <- substr( d2$nteecode, 1, 1 )


ntee2 <- ntee
names( ntee2 ) <- c( "id", "nteeprimdesc" )

d3 <- merge( d2, ntee2, by.x="nteeprimary", by.y="id", all.x=T, sort=FALSE )


names( ntee ) <- c( "id", "nteesecdesc" )
d4 <- merge( d3, ntee, by.x="nteecode", by.y="id", all.x=T, sort=FALSE )


names( d4 )

keep <- 
c("ein", "orgname", "mission", 
"nteeprimary", "definition", "nteecode", "nteesecdesc",
"orgpurposecharitable", 
"orgpurposereligious", "orgpurposeeducational", "orgpurposescientific", 
"orgpurposeliterary", "orgpurposepublicsafety", "orgpurposeamateursports", 
"orgpurposecrueltyprevention", "leginflno", "leginflyes", "donatefundsno", 
"donatefundsyes", "conductactyoutsideusno", "conductactyoutsideusyes", 
"compofcrdirtrustno", "compofcrdirtrustyes", "financialtransofcrsno", 
"financialtransofcrsyes", "unrelgrossincm1000moreno", "unrelgrossincm1000moreyes", 
"gamingactyno", "gamingactyyes", "disasterreliefno", "disasterreliefyes", 
"onethirdsupportpublic", "onethirdsupportgifts", "benefitofcollege", 
"privatefoundation508e", "hospitalorchurchno", "hospitalorchurchyes"  )

d4 <- d4[ keep ]

names( d4 ) <-
c("ein", "orgname", "mission", "code01", "codedef01", "code02", 
"codedef02", "orgpurposecharitable", "orgpurposereligious", 
"orgpurposeeducational", "orgpurposescientific", "orgpurposeliterary", 
"orgpurposepublicsafety", "orgpurposeamateursports", "orgpurposecrueltyprevention", 
"leginflno", "leginflyes", "donatefundsno", "donatefundsyes", 
"conductactyoutsideusno", "conductactyoutsideusyes", "compofcrdirtrustno", 
"compofcrdirtrustyes", "financialtransofcrsno", "financialtransofcrsyes", 
"unrelgrossincm1000moreno", "unrelgrossincm1000moreyes", "gamingactyno", 
"gamingactyyes", "disasterreliefno", "disasterreliefyes", "onethirdsupportpublic", 
"onethirdsupportgifts", "benefitofcollege", "privatefoundation508e", 
"hospitalorchurchno", "hospitalorchurchyes")


saveRDS( d4, "IRS-1023-EZ-MISSIONS.rds" )


cat( paste0( "\n* **", names(d4), "**: " ) )

     