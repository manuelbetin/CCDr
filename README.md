
-   [TextMiningCrisis](#textminingcrisis)
-   [Description](#description)
-   [Author](#author)
-   [Current version:](#current-version)
-   [Installation](#installation)
-   [Usage](#usage)
    -   [LEXICON: Browse lexicon of economic crisis](#lexicon-browse-lexicon-of-economic-crisis)
    -   [CORPUS: Download IMF reports](#corpus-download-imf-reports)
    -   [CORPUS: Aggregate the pdf files into a dataset in text format](#corpus-aggregate-the-pdf-files-into-a-dataset-in-text-format)
    -   [CORPUS: Explore the reports](#corpus-explore-the-reports)
    -   [TERM FREQUENCIES: compute the indexes](#term-frequencies-compute-the-indexes)

<!-- README.md is generated from README.Rmd. Please edit that file -->
# TextMiningCrisis

------------------------------------------------------------------------

------------------------------------------------------------------------

last update: 30/01/2020

# Description

Perform a supervised text mining (Natural Language Processing) using an add hoc lexicon of economic crisis and a corpus of economic reports from the International Monetary Fund (IMF)

# Author

-   Manuel Betin
-   Umberto Collodel

# Current version:

1.4.0

see NEWS.md for more details on new features

# Installation

The current version of the package is available on github and can be installed using the devtools package.

    #> Loading required package: dplyr
    #> 
    #> Attaching package: 'dplyr'
    #> The following objects are masked from 'package:stats':
    #> 
    #>     filter, lag
    #> The following objects are masked from 'package:base':
    #> 
    #>     intersect, setdiff, setequal, union
    #> Loading required package: pdftools
    #> Using poppler version 0.73.0
    #> Loading required package: xml2
    #> Loading required package: rvest
    #> Loading required package: tidytext
    #> Loading required package: tidyr
    #> Loading required package: rlang
    #> 
    #> Attaching package: 'rlang'
    #> The following object is masked from 'package:xml2':
    #> 
    #>     as_list
    #> Loading required package: stringr
    #> Loading required package: plotly
    #> Loading required package: ggplot2
    #> 
    #> Attaching package: 'plotly'
    #> The following object is masked from 'package:ggplot2':
    #> 
    #>     last_plot
    #> The following object is masked from 'package:stats':
    #> 
    #>     filter
    #> The following object is masked from 'package:graphics':
    #> 
    #>     layout
    #> Loading required package: crayon
    #> 
    #> Attaching package: 'crayon'
    #> The following object is masked from 'package:plotly':
    #> 
    #>     style
    #> The following object is masked from 'package:ggplot2':
    #> 
    #>     %+%
    #> The following object is masked from 'package:rlang':
    #> 
    #>     chr
    #> Loading required package: rio
    #> 
    #> Attaching package: 'rio'
    #> The following object is masked from 'package:plotly':
    #> 
    #>     export
    #> Loading required package: tictoc
    #> Loading required package: lubridate
    #> 
    #> Attaching package: 'lubridate'
    #> The following objects are masked from 'package:base':
    #> 
    #>     date, intersect, setdiff, union

# Usage

The package provides several functions to compute term frequencies on the corpus of reports. Due to the different potential usages and for the necessity to handle large amounts of data several wrap up functions are provided to be able to perform the different steps one by one or sequentially. The packages is constructed in three different blocs:

-   Lexicon: define and prepare categories and keywords
-   Corpus: download, explore and aggregate
-   Term Frequencies: compute the indexes

The main functions are:

-   **lexicon()**: provide the list of categories and keywords
-   **pdf\_from\_url()**: download reports in pdf formats
-   **aggregate\_corpus()**: transform pdf into a dataframe of text
-   **tf\_vector()**: run the term frequency on the corpus for several categories
-   **run\_tf()**; run the term frequency on locally stored corpus
-   **run\_tf\_by\_chunk()** run the term frequency directly downloading the files
-   **run\_tf\_update()** update the term frequency matrix with new categories

## LEXICON: Browse lexicon of economic crisis

Access the names of the existing categories in the lexicon using the function lexicon()

``` r
lexicon() %>% names()
#>  [1] "Wars"                       "Wars_confusing"            
#>  [3] "Migration"                  "Natural_disaster"          
#>  [5] "Natural_disaster_confusing" "Epidemics"                 
#>  [7] "Commodity_crisis"           "Political_crisis"          
#>  [9] "Social_crisis"              "Labormarket_boom"          
#> [11] "Labormarket_crisis"         "Nuclear_accident"          
#> [13] "Cyber_attack"               "Credit_boom"               
#> [15] "Housing_boom"               "Housing_crisis"            
#> [17] "Banking_crisis"             "Banking_crisis_severe"     
#> [19] "Financial_crisis"           "Inflation_crisis"          
#> [21] "Trade_crisis"               "World_outcomes"            
#> [23] "Contagion"                  "Positive_expectations"     
#> [25] "Expectations"               "Balance_payment_crisis"    
#> [27] "Reduction_reserves"         "Currency_crisis"           
#> [29] "Currency_crisis_severe"     "Currency_crisis_confusing" 
#> [31] "Floating_exchange_rate"     "Fixed_exchange_rate"       
#> [33] "Losening_monetary_policy"   "Tightening_monetary_policy"
#> [35] "Severe_recession"           "Soft_recession"            
#> [37] "Expansion"                  "Poverty_crisis"            
#> [39] "Fiscal_outcomes"            "Low_public_debt"           
#> [41] "Fiscal_stimulus"            "Fiscal_consolidation"      
#> [43] "Concessional_lending"       "Short_term_debt"           
#> [45] "floating_rate_debt"         "foreign_debt"              
#> [47] "Sovereign_default"          "Problematic_documents"
```

Browse the keywords associated to each category using lexicon\_details("nameofmycategory")

``` r
lexicon_details("Severe_recession")
#> $Severe_recession
#>  [1] "severe economic crisis"                 
#>  [2] "very difficult economic circumstances"  
#>  [3] "Severe recession"                       
#>  [4] "severe crisis"                          
#>  [5] "economic crisis"                        
#>  [6] "steep recession"                        
#>  [7] "strong recessionary headwinds"          
#>  [8] "sharp slowdown"                         
#>  [9] "sharp declines in output"               
#> [10] "significant loss of output"             
#> [11] "economic collapse"                      
#> [12] "deeper recession"                       
#> [13] "deepening recession"                    
#> [14] "painful recession"                      
#> [15] "prolonged recession"                    
#> [16] "lengthening recession"                  
#> [17] "severity of the recession"              
#> [18] "economic recession"                     
#> [19] "sharp contraction of economic activity" 
#> [20] "strong contraction of economic activity"
#> [21] "large contraction of economic activity" 
#> [22] "deep recession"                         
#> [23] "large economic slowdown"                
#> [24] "severe recession"                       
#> [25] "profond recession"                      
#> [26] "contraction in output"                  
#> [27] "deep recession"                         
#> [28] "severe contraction"                     
#> [29] "deep contraction"                       
#> [30] "profond contraction"                    
#> [31] "large decline in income per capita"     
#> [32] "deep economic downturn"                 
#> [33] "severe economic downturn"               
#> [34] "deep economic downturn"
```

Create your own lexicon by creating a named list with the set of keywords associated

``` r
my_new_lexicon=list(Recession=c("severe economic crisis",
                                "Severe recession",
                                "severe crisis"))
```

## CORPUS: Download IMF reports

Access urls of the IMF reports in the archives. The dataset "BetinCollodel\_urls" contains for document the relevant metadata including the name of the country, the date of publication, the url of the IMF archives where the documents can be downloaded and several other information extracted from the metadata of the documents. For instance the document corresponding to the request for Standby Arrangement of Argentina on the 25 of january of 1983 is accessible on the following link <https://imfbox.box.com/shared/static/fx9w2df3n8u4ya2ni4ulnbrgp42c3ait.pdf> .

``` r
#load dataset containing urls of documents 
data("BetinCollodel_urls")

url_links= BetinCollodel_urls %>% filter(ID=="ARG")
url_links=url_links[150:155,]

url_links %>% head(.,3)
#> # A tibble: 3 x 21
#>   ID    period     title hierarchy pdf   type_doc_progra… type_program
#>   <chr> <date>     <chr> <chr>     <chr> <chr>            <chr>       
#> 1 ARG   1983-01-25 arge… EBS/83/8… http… request          SBA         
#> 2 ARG   1983-05-18 arge… EBS/83/97 http… modification     SBA         
#> 3 ARG   1983-05-27 arge… <NA>      http… modification     <NA>        
#> # … with 14 more variables: type_doc_consultations <chr>, Review_number <chr>,
#> #   perf_criteria <chr>, waiver <chr>, modification <chr>, membership <dbl>,
#> #   statements <dbl>, repurchase_transaction <dbl>, technical_assistance <dbl>,
#> #   expost_assessment <dbl>, exchange_system <dbl>, overdue_obligations <dbl>,
#> #   type_hierarchy <chr>, name_file <chr>
```

Download several reports in pdf format and store them locally in folter of your choice using the pdf\_from\_url() function. The following example downloads 5 reports corresponding to the 5 urls provided in the dataset url\_links. Note that to properly download the file, the argument urls must be a table containing at least two columns: name\_file (the name of the files downloaded) and pdf (the url need to access the files in the archives). The second argument *export\_path* corresponds to name of a folder where the downloaded files will be saved.

``` r

pdf_from_url(url_links[,1],"mydocs_for_textmining")
#> Please provide a valid data.frame of with at least two columns: name_file (name of your file) and pdf (the url link)
```

To access more recent reports from the current publications of the IMF website

## CORPUS: Aggregate the pdf files into a dataset in text format

Documents in pdf format need to be properly transformed into text format to be able to perform the text analysis. The function aggregate\_corpus() aggregates all the files into a single list. In the following example the documents contained in the folder "mydocs\_to\_textmining" are aggregated. The argument only\_files=T ensure that only the text in the document are stored and not the information in the metadata.

``` r
corpus=aggregate_corpus("mydocs_for_textmining",only_files = T)
#> [1] "mydocs_for_textmining/ARG_1983-01-25_request.pdf"
#> 1/5 ARG_1983-01-25_request: 0.151 sec elapsed
#> [1] "mydocs_for_textmining/ARG_1983-05-18_modification.pdf"
#> 2/5 ARG_1983-05-18_modification: 0.049 sec elapsed
#> [1] "mydocs_for_textmining/ARG_1983-05-27_modification.pdf"
#> 3/5 ARG_1983-05-27_modification: 0.191 sec elapsed
#> [1] "mydocs_for_textmining/ARG_1983-06-08_exchange system.pdf"
#> 4/5 ARG_1983-06-08_exchange system: 0.014 sec elapsed
#> [1] "mydocs_for_textmining/ARG_1983-07-28_exchange system.pdf"
#> 5/5 ARG_1983-07-28_exchange system: 0.013 sec elapsed

save(corpus,file="mycorpus.RData")
```

## CORPUS: Explore the reports

To perform exploratory analysis on the reports, to extract specific paragraphs or to enrich your lexicon you can perform a keyword search in a specific document. In the following example the function locate all the occurrences of "debt" in the request for Standby Arrangement of Argentina in 1983.

``` r

pages_containing_word=get_pages(corpus$`ARG_1983-01-25_request`,"debt")
pages_containing_word
#> $target
#> [1] "debt"
#> 
#> $N.chars
#> [1] 54686
#> 
#> $N.Occurence
#> $N.Occurence[[1]]
#> [1] "Found in page 3 :1 times"
#> 
#> $N.Occurence[[2]]
#> [1] "Found in page 6 :1 times"
#> 
#> $N.Occurence[[3]]
#> [1] "Found in page 8 :1 times"
#> 
#> $N.Occurence[[4]]
#> [1] "Found in page 12 :1 times"
#> 
#> $N.Occurence[[5]]
#> [1] "Found in page 14 :2 times"
#> 
#> $N.Occurence[[6]]
#> [1] "Found in page 15 :1 times"
#> 
#> $N.Occurence[[7]]
#> [1] "Found in page 16 :4 times"
#> 
#> $N.Occurence[[8]]
#> [1] "Found in page 17 :1 times"
#> 
#> $N.Occurence[[9]]
#> [1] "Found in page 18 :1 times"
#> 
#> $N.Occurence[[10]]
#> [1] "Found in page 19 :5 times"
#> 
#> $N.Occurence[[11]]
#> [1] "Found in page 20 :1 times"
#> 
#> 
#> $Tot.occurence
#> [1] 19
#> 
#> $pages
#> $pages[[1]]
#> [1] " -2(i) the cumulative overall balance of payments targets described in paragraph 2 of the Memorandum of Understanding annexed to the attached letter have not been met, or (ii) the limit on the cumulative borrowing needs of the nonfinancial public sector described in paragraph 3 of the Memorandum of Understanding annexed to the attached letter has been exceeded, or (iii) the cumulative limit on the outstanding disbursed external debt of the public sector described in -paragraph 5 of the Memorandum of Understanding annexed to the attached letter has been exceeded, or (iv) the limits on total maturities falling due within 36 months of the end of .each calendar quarter described in paragraph 5 of the Memorandum of Understanding annexed to the attached letter have been exceeded, or, (c) during any period after February 28, 1983 in which the system of special rebates for exports to new markets has not been terminated, or (d) during any period after March 31, 1983 in which the schedule for the phased elimination of the minimum foreign financing requirements for imports, as set out in paragraph 6 of the Memorandum of Understanding annexed to the attached letter, has not been adhered to, or (e) during any period after June 30, 1983 in which external payments arrears persist or reappear, or (f) during any period after July 31, 1983 in which under: standings between Argentina and the Fund on a schedule for the elimina-1 tion of existing multiple currency practices and restrictions on pay: ments and transfers for current international transactions have not , been reached, or (g) during the entire period of this stand-by arrangement, if Argentina (I) imposes or intensifies restrictions, on payments and transfers for current international transactions, or "
#> 
#> $pages[[2]]
#> [1] " 5. ATTACHMENT Buenos Aires, Argentina January 7, 1983 Mr. Jacques de Larosiere . .. Managing Director International Monetary Fund Washington, D.C. 20431 U.S.A. Dear Mr. de Larosiere, 1. Annexed are (1) a Memorandum of the Government of the Republic of Argentina on Certain Aspects of its Economi,c Policy.for the period through March 1984; and (2) a Memorandum of Understanding setting out : certain operational guidelines for the conduct of this economic policy from January 1983 through April 1984.. The memoranda describe the measures that Argentina already has taken and still has to take in order to correct economic imbalances and to ensure economic growth on solid and stable foundations. 2. In support of this 15month program, we request herewith a stand-by arrangement with the International Monetary Fund in an amount of SDR 1,500 million, including access to the Fund's borrowed resources. We believe that our request for Argentina's maximum access to Fund resources permissible under existing policies is fully justified given the exceptional circumstances of our country and the pronounced deterioration in international capital market conditions which not only affect Argentina but the entire world. Moreover, believing as.we do. that the process of full economic recovery and restoration of financial stability will not be completed by the time the present Government leaves office, we would like to ensure that the authorities who will succeed it will have the opportunity to establish, if they desire, new financial relations between Argentina and the Fund. To this end the Government is prepared to arrange preliminary contacts prior to March 1984 between representatives of the Fund and the authorities in charge of the next government. 3. The Government of the Republic of Argentina intends to enter into discussions with the international financial community to secure a restructuring of its public and private external debt and attaches great importance to any assistance the Fund could lend in this exercise, as well as in efforts to obtain new external financing. 4. The annexed Memorandum of Understanding covers the principal economic targets and policy undertakings for the period of the requested arrangement. The Government of the Republic of Argentina understands that if, for any reason, any of these targets or policy undertakings are not observed in the period to the end of the arrangement, Argentina will not request any purchase under the arrangement that would raise the Fund's holdings of Argentina pesos beyond the first credit tranche "
#> 
#> $pages[[3]]
#> [1] " -7ANNEX I MEMORANDUM OF THE GOVERNMENTOF THE REPUBLIC OF ARGENTINA ON CERTAIN ASPECTS OF ITS ECONOMIC'POLICY I. Objectives and Strategies for Economic Recovery 1. The Argentine economy is in a severely depressed state and plagued,with acute imbalances.. The rate of inflation remains high and real wages have declined sharply. Real GDP growth, uneven during 1976-79, came to a halt in 1980 and was negative in 1981-82. Output now,barely is at its level of six years ago, and real per capita income is at its lowest level in a decade. Unemployment approached 6 per cent in mid-1982 and underemployment has risen sharply. 2. The exchange rate policy pursued until March 31, 1981 led to an overvaluation of the peso and caused heavy external current payments imbalances which were financed by foreign borrowing on an increasing scale and on ever shorter terms. From that time on, attempts were made to correct these imbalances by an adjustment of the real exchange rate, which did reduce the deficit to some extent, but the lack of supporting domestic policies and waning confidence caused the overall balance of payments deficit to grow in the remainder of 1981. After a brief improvement in early 1982, the overall imbalances intensified during the second quarter of the year, when Argentina's access to international financial markets was interrupted, shipping routes were altered, and payments arrears began to accumulate. Argentina's external debt now exceeds USS36 billion, about one half of which falls due in 1983. The overall balance of payments deficit incurred in 1981 and 1982 combined is estimated.at USS9 billion, which has reduced the disposable international reserves of the Central Bank to -an extremely low level. Internally, wholesale prices rose by 180 per cent during 1981 and by about 310 per cent during 1982, reaching an annual rate of increase of 495 per cent in the second half of last year. 3. Notwithstanding heavy foreign borrowing, private and public investment stagnated during 1978-80 and dropped sharply in 1981-82 with the intensification of the economic recession. Gross fixed capital formation is estimated to have been only 17 per cent of GDP in 1982, compared with 25 per cent of GDP in the mid-1970s. Moreover, certain public investments in the last six years were in sectors yielding low, and in certain cases, negative rates of return. 4. The revival of the economy and the reduction of unemployment, therefore, have been the Government's priority economic objectives. The strategy has been divided into two stages: with the help of an emergency public works program, efforts were initially directed to reactivating activities that are heavily labor-intensive and make little use of imported inputs. Because of budget constraints, however, this program has been limited to the resumption of work on certain projects, the speeding up of others, and maintenance work. The second stage will involve increased capacity utilization (now at some 60 per cent on the average in "
#> 
#> $pages[[4]]
#> [1] " 11 ANNEX I 12. This said, it is recognized that the pattern for wage adjustments in the private sector will be set in large measure by the policy of.remuneration pursued in the public sector. The wage bill of the general government dropped from more than 10 per cent of GDP in 1979 and in 1980 to below 7.5 per cent of GDP in 1982, reflecting in part the freeze imposed on public sector remunerations during the first half of the year and the adoption of flat pesos increases in the third quarter. To the extent permitted by the need to compress sharply the borrowing requirements of the public sector, current budget plans for 1983 imply a real increase in the remunerations of public employees of 5 per cent. In addition, in order to retain qualified mediumand high-level civil servants,their salary scale will be partially restructured so as to correct the distortions in salary levels introduced by the flat peso increases of July-September 1982. Such selective increases will be quarterly commencing on April 1, will be kept during 1983 to one half of the full contemplated restructuring and will be subject to the availability of budgetary resources consistent with the fiscal program. The restructuring process will be completed in 1984. Altogether, the government wage bill would be held to no more than 7.5 per cent of GDP, a level significantly below that recorded in 1980 and 1981. Although wage developments in the public enterprises in principle follow the pattern of those in the private sector, the Government will monitor carefully the behavior of remunerations in the state enterprises and bring appropriate pressure to bear on these enterprises to ensure that the remunerations they pay remain in line with those for government employees. 13. There has been a marked deterioration in the public finances since 1977, particularly in the last two years. Pub1i.c sector expenditure rose to about 40 per cent of GDP, to a large extent because of mounting interest payments on the.internal and external debt and notwithstanding a drop in capital spending. Meanwhile, government revenues declined, affected as they were by rapidly changing economic conditions, modifications in the tax system and widespread tax evasion. Savings of the public sector fell sharply, from a high of 10-l/2 per cent of GDP in 1977 to around minus 3-l/2 per cent of GDP in 1981 and to minus 5 per cent of GD,P in 1982. The overall borrowing requirements of the public sector, which in 1977 had been compressed to 4-l/2 per cent of GDP, widened steadily thereafter to a high of 14-l/3 per cent of GDP in both 1981 and 1982. Consequently, the public sector not only preempted a growing share of domestic financial savings, but also borrowed heavily abroad. 14. The Government is committed to prudent financial management and thereby to strengthening the confidence of the private sector, where expectations are markedly influenced not only by the size of the public sector deficit but also by the magnitude and composition of public spending. There also is a need for relieving pressures on the domestic financial market in order to free savings for the revival of output in the private sector. "
#> 
#> $pages[[5]]
#> [1] " .13 ANNEX I will be partly, if not wholly, offset by the gradual recovery of production, imports, and sales and by a systematic effort at reducing tax evasion, now estimated at around 50 per cent in the case of the VAT alone. A growth of other government revenue is expected from the adoption of a tax moratorium and the impact of the ongoing adjustments in the domestic prices of petroleum derivatives and electricity. 18. The Government will observe austerity in its consumption spending through tight control over the growth of its wage bill and by keeping the increase in its outlays on goods'and services below that in domestic prices. Although no dismissal from government employment can be envisaged in current economic circumstances, no more than one half of the positions vacated by attrition will be filled. With such prudent management of current spending and the anticipated increase in revenue; government savings should rise from minus 1.8 per cent of GDP in. 1982 to 2-l/.? per cent of GDP in 1983. 19. Given the transitory nature of this Government, it would seem inappropriate to introduce major modifications in the size and overall priorities of the public investment program. Nonetheless, concern for economic reactivation dictates that in 1983 real public investment spending be raised by around 1 per cent of GDP from its level of 8.5 per cent of.GDP in 1982, and care has been taken in the 1983 budget to concentrate such spending on labor-intensive projects with a large income multiplier effect. Projects, with low economic returns and those of no immediate priority have been cancelled or postponed, except when breach of contracts involved higher costs than continuing with the project.. : 20. The financial system was substantially modified in July 1982 :. with the objective of alleviating the heavy domestic and foreign debt burden of enterprises resulting from large-scale borrowing during 1978-80. With these modifications, the real value of the private sector's debt to the financial system was reduced by 40 per cent from July through October. But the cost of this operation was high as the low level of real interest rates caused real domestic financial savings to fall sharply. Monetary policy therefore is being directed toward the reconstitution of real financial savings and the efficient allocation of financial resources. 21: A number of measures in this direction were taken in the latter part of 1982 as the interest rate structure established in July 1982 was gradually made more flexible. The maximum monthly interest rates payable on regulated deposits of 30 days were increased in steps from an initial level of 5 per cent per month in July to 7 per cent in September and to 8-112 per cent in November, and the rates on regulated deposits at longer terms were raised correspondingly. The rate of interest on the subsidized basic and additional loans was raised from the original 6 per cent a month in July to 8 per cent a month in September. That lending rate was raised further to 9 per cent a month in November, and new access to these loans was suspended from November 1, 1982. Also, regulations were issued in November 1982 to prevent maturing exchange guarantees granted during June-December 1981' from causing an undue Central Bank credit'expansion and a loss of foreign exchange reserves. "
#> 
#> $pages[[6]]
#> [1] " . 14 ANNEX I 1 22. With effect from January 1, 1983, the monetary authorities have adopted a policy whereby the key regulated deposit rates and the lending rate for loans financed from regulated deposits will be set at the beginning of each month on the basis of a three-month moving average of the wholesale price index-the observed increase in that index during the two preceding months and the projected increase for the current month. The lending rate will be set at least equal to that three-month moving average ; the 30-day deposit rate will be set within 1 percentage point below that average and the rates on deposits of more than 30 days will be set in line with the 30-day rate. Recognising that this formula is based on partially estimated data for the preceding month and projected data for the current month, the authorities are prepared during the course of each month to adjust minimum reserve requirements or to conduct their open market operations in such a way as to produce an interest rate on Central Bank absorption bills which will compensate for any significant underestimation of the current inflation rate resulting from the formula. 23. More generally, the authorities view the ultimate test of the appropriateness of interest rate policy to be the degree of success in .achieving the balance of payments objectives and the targeted real increase in the financial assets of the private sector; they are prepared to adapt the formula for setting regulated deposit and lending rates to the extent that is necessary to meet these goals. In the short run, the results of the regular bill auctions and the movements in the rates on unregulated deposits will be used as indicators of the appropriateness of that formula, and regulated rates will be set above the levels indicated by the price formula if this appears necessary. 24. A major obstacle to economic recovery since the second quarter of 1982 has been the foreign exchange shortage. Two major reasons for this shortage were adverse movements in the leads and lags of import payments and surrender of export receipts and the drying up of external sources of finance at a time of heavy external debt service payments. From July 1982, another reason has been the emergence of a large differ ential between the commercial exchange rate applicable to merchandise n transactions, the financial rate applicable to all other authorised .I 1 transactions, and the rate in the parallel market which emerged as exchange restrictions were tightened. As a consequence, underand over-invoicing became widespread, unrecorded border transactions increased, exporters withheld shipments, and a large portion of service receipts evaded official channels. 25. To avoid the continuation of these distortions in trade and payments flows the Government is determined to restore order in the foreign exchange market. While continuing with the daily depreciation. of the commercial rate initiated in July 1982, the unification between the financial and commercial exchange rates was accelerated in September and October by introducing, and subsequently increasing, the mix of the two rates for trade transactions. The exchange markets subsequently were unified on November 1, 1982, for a 13-l/2 per cent peso depreciation for "
#> 
#> $pages[[7]]
#> [1] "\\ 15 .ANNEX I trade related transactions, and since then the exchange rate has been adjusted about in line with the rate of domestic inflation. This policy will be applied with sufficient flexibility to meet the overall balance of payments objectives. 26. A parallel market will'remain in existence so long as complete freedom of exchange transactions has not been restored. Moreover, the benefits in terns of resource allocation of a unified exchange.rate are at least partly foregone by such payments restrictions as presently exist. Despite the drawbacks of exchange restrictions, the freeing of the capital account of the balance.of.payments has to be ruled out in Argentina's.present circumstances, but it is the intention of the Government to phase out gradually restrictions on payuents and transfers on current account; To this effect a program of gr,adual liberalization has been drawn up, which calls for a return to complete freedom for current payments by December 31, 1983,. e.xcept possibly for limits on certain invisi,ble payments to prevent disguised capital outflows. The 180-day minimum import financing requirement also will be reduced in steps and eventually .eliminated. 27'. Beginning in the second quarter of 1982 Argentina incurred large external payments arrears, of which USS2.5 billion remained outstanding at the end of December. The authorities are giving the ,highest priority to the total elimination of these arrears, in their determination to restore the normal flow of imports and Argentina's international creditworthiness. 28. The authorities have asked foreign banks to restructure Argentina's debt maturities. As already indicated, principal payments equivalent to about one half of the external debt of USS36 billion at the end of 1982 fall due in 1983. This debt amortization schedule obviously,is unrealistic for a country with Argentina's.level of income and-export earnings. The Government trusts that the private international'banking community will recognize this fact and respond positively to Argentina's request for debt relief. Should foreign banks be pre-. pared to go further and resume lending to Argentina, the Government will observe prudent limits on its total external borrowing, especially in the shorter maturity ranges. Government of the Republic of Argentina January 7, 1983 "
#> 
#> $pages[[8]]
#> [1] " 16 ANNEX 11 Buenos Aires, Argentina January 7, 1983 MEMORANDUM OF UNDERSTANDING 1. This Memorandum describes more concretely the key targets and policy undertakings of the accompanying Memorandum of the Government.of the Republic of Argentina on Certain Aspects of its Economic Policy. 2. The overall balance of payments target for 1983 and for the 15-month period through the first quarter of 1984 is a deficit of no more than US$500 million. The intermediate targets are a deficit of no more than US$400 million for the three-mon,th period through March 31, 1983; a deficit of no more than US$220 million for the six-month period through June 30, 1983; and a surplusof at least US$20 million for the nine-month period through September 30, 1983. For the purpose of these targets, the balance of payments performance will be measured by changes in the net international reserve positionof the Central Bank of the Republic of Argentina. The Central Bank's net international reserve position will be defined as the difference between (a) the sum of its holdings of gold, SDRs, reserve position in the IMF, and all claims on nonresidents except discounted export letters of credit and credit lines granted to nonresidents; and (b) the sum of any outstanding external payments arrears and all other obligations to nonresidents, regardless of their currency denomination, any outstanding foreign currency swaps with residents, any loans obtained by public sector entities the foreign currency proceeds of which were surrendered to the Central Bank without the borrowing entity receiving the peso counterpart, any other balance of payments support loans, the cumulative net issue of external bonds (BONEX) against pesos for settlement by the private sector of outstanding external obligations (but excluding external bonds issued in settlement of foreign loans carrying an exchange rate guarantee by the Central Bank) and any debt to the IMF and the BIS. For the purpose of this definition, all foreign assets and liabilities will be expressed in U.S. dollars. All foreign assets and liabilities in other foreign currencies will be converted into U.S. dollars at the market rates of the respective currencies; gold will be valued at a fixed accounting rate of US$42 per fine troy ounce; and the Central Bank's SDR holdings and Argentina's IMF position, be the latter positive or negative, will be valued in SDRs converted into U.S. dollars at the basket valuation of the Special Drawing Right. The Central Bank's net international reserve position as of September 30, 1982, so defined, is shown in attached Table 1. However, for purposes of measuring balance of payments'performance, the change in the net international reserve position will be adjusted for changes in the U.S. dollar value of assets and liabilities denominated in other foreign currencies. An adjustment factor will be calculated weekly as the difference between (a) the U.S. dollar value of such assets and liabilities as of the day before the end of each statistical week valued at market rates on that day and (b) that same stock of assets and liabilities valued at the market "
#> 
#> $pages[[9]]
#> [1] "\\ 17 ANNEX II rates on the day before the end of the.preceding statistical week.. The cumulative value of these weekly adjustment factors will be subtracted from the change in net international reserves of the Central Bank as measured at current market rates. : 3. The cumulative global borrowing needs of the nonfinancial public sector will not exceed $a 105 trillion from January 1, 1983 until March 31, 1983; $a 218 trillion until June 30, 1983; $a 326 trillion until September 30, 1983; $a 445 trillion until December 31, 1983; and $a 559 trillion until March 31, 1984. These borrowing needs will be defined as the sum of the net increase above their respective stocks on December 31, 1982 in (a) the external debt of the nonfinancial public sector, including short-term debt, foreign currency denominated Treasury bills and bonds (BONEX) (excluding BONEX issued against pesos) converted into U.S. dollars if denominated in another foreign currency (and properly adjusted for exchange rate movements) and all U.S. dollar values converted into pesos at the average exchange rate of the U.S. dollar during the calendar quarter of the transaction; (b) external bonds in foreign currency issued against pesos in settlement of foreign obligations carrying an exchange rate guarantee by the Central Bank, valued in pesos at the amount actually received by the Treasury on the date of each such transaction; (c) th e net debt (credit minus deposits) of the nonfinancial public sector to the Central Bank of the Republic of Argentina (including external bonds issued against pesos other than those,referred to in (b) above) and the rest of the domestic financial system, excluding any valuation adjustments for alterations in the external value of the Argentine peso in the pertinent foreign currency denominated accounts; and (d) net placement of Treasury bills and bonds with.the nonfinancial private sector. For the purpose of these cumulative limits, the nonfinancial public sector will be defined as the Treasury, the Special Accounts, the decentralized agencies, the Social Security System, the provinces, the Municipality of Buenos Aires, and the public enterprises listed in attached Table 2. 4. The net domestic assets of the Central Bank of the Republic of Argentina will at no time during the first quarter of 1983 increase by more than the increase (or decrease by less than the decrease) in its banknote issue above (below) its base stock on December 31, 1982, plus $a 9.7 trillion, but in no event by more than 40 per cent of the base q'stock, plus $a 9.7 trillion; at no time during the second quarter of 1983 increase by more than the increase (or'decrease by less than the decrease) in its banknote issue above (below) its base stock, plus '$a 15.0 trillion, but in no event by more than 80 per cent of the base stock, plus $a 15.0 trillion; at no time during the third quarter of 1983 increase by more than the increase (or decrease by less than the ::decrease) in its banknote issue above (below) its base stock, plus '$a 4.9 trillion, but in no event by more than 130 per cent of the base stock, plus $a 4.9 trillion; at no time,during the last quarter of 1983 increase by more than the increase (or decrease by less than the decrease) in its banknote issue above (below) its base stock, plus $a 11.7 trillion; but in no event by more than 170 per cent of the "
#> 
#> $pages[[10]]
#> [1] " 18 1 ANNEX II base stock, plus $a 11.7 trillion; i?nd at no time during the first quarter of 1984 increase by, more than the increase (or decrease by less than the decrease) in its banknote issue above (below) its base stock, plus $a 24.3 trillion, but in no event by more than 220 per _ cent of the base stack, plus Sa 24.3 trillion. For the purpose of this ceiling, the net domestic assets of the Central Bank will be defilled as the difference between (a) its banknote issue and (b) its net international reserve position, defined as in paragraph 2 above, with the U.S. dollar value converted at all times into Argentine pesos at the Central Bank's accounting rate on December 31, 1982. 5. The outstanding disbursed external debt of the public sector will at no time during the period of the arrangement exceed by more than USS2 billion the stock of such debt outstanding on December 31, 1982. Furthermore, the total maturities falling due within three years of the end of each calendar quarter, based on the stock of debt outstanding as of the end of that calendar quarter, will not exceed the total maturities falling due within three years of December 31,'1982, based'on the stock of debt outstanding as of that date, by more than US$600 million on March 31, 1983, by more than US$l.2 billion on June 30, 1983, by more than USS1.8 billion on September 30, 1983, by more than USS2.4 billion on December 31, 1983, and by more than US$3 billion on March 31, 1984. These limits on maturities falling due within three years of the end of each calendar quarter will be subject to a downward adjustment (even, if appropriate, to negative values) for (a) any net debt relief on maturities falling due within these periods obtained through multicreditor agreements involvirig a formal refinancing or rescheduling of the external debt of the public sector, and for (b) any increase in arrears on principal payments on public sector debt over and above the amount of such arrears outstanding on December 31, 1982. For purpose of these limits, the external debt of the public sector will be defined as all external obligations of the total public sector, including the official banks (the domestic offices of Banco de la Nation, the National Development Bank, the Mortgage Bank, the National Postal Savings Bank, and the provincial and municipal banks), but excluding any increase in the stock of Argentine government bonds denominated in foreign currency but issued against pesos; any increase in the external obligations of the public sector treated as international reserve liabilities of the Central Bank as per paragraph 2 above; and any increase in the external debt of the public sector as the result of default by the private sector on a publicly guaranteed debt. External debt in currencies other than the U.S. dollar will be converted into U.S. dollars at the exchange rates prevailing on December 31, 1982, 6. During 1983 and through April 1984, the Government will not impose any new or intensify any existing restriction on payments and transfers for current international transactions; conclude any bilateral payments agreement inconsistent with Article VIII of the Articles of Agreement, or impose any new or intensify any existing import restriction for balance of payments reasons. During the second quarter of 0 1983 the Government will undertake, in consultation with the Fund, a "
#> 
#> $pages[[11]]
#> [1] "1 \\ <..19 ANNEX II comprehensive review.of the Argentine exchange and trade system and reach understandings with the Fund on a schedule for the elimination of existing multiple currency practices. and restrictions on payments and transfers for current international transactions and of the consequent distortions. The Government will terminate the system of special rebates for exports to new markets by February 28, 1983, although rebates authorized before that date will continue in effect until their pre-established expiration dates. The Government will reduce the minimum foreign financing requirement for private imports, now at 180 days, to no more than 150 days by March 31, 1983, to no more than 120 days by June 30, 1983, and to no more than 90 days by September 30, 1983, and it will eliminate this requirement entirely by December 31, 1983. 7. During 1983 and through April 1984, the Government will not introduce or modify any multiple currency practice with the following exceptions: (a) any uodification in a multiple currency practice which reduces the differential between the effective exchange rate applied for a given transaction and the official buying or selling rate for the peso in the unified exchange market; and (b) pending the completion of the review mentioned in paragraph 6 above, the continued operation of the existing system of export rebates within the existing range of rates, including the reclassification of exports within that'range of rates. 8. All external payments arrears will be eliminated as quickly as possible and, in any event, by June 30, 1983. Once eliminated, foreign exchange will be provided freely at the official exchange rate for all bona'fide current international payments. However, reasonable limits may be applied on the automatic allocation of foreign exchange for foreign travel and,remittances in order to prevent disguised capital outflows. ._. 9. ..The Government intends to. initiate shortly discussions with i its foreign creditors with a view to achieving a restructuring of Argen'.tina's external public and private debt that would produce an amortiza.tion profile attuned to Argentina's repayment capacity. Sincerely yours, Julio Gonzalez de1 Solar Jorge Wehbe President of the Central Bank Minister of Economy of the Republic of Argentina "
```

Compute the document term frequency for all the files in the corpus for the category "Currency\_crisis"

## TERM FREQUENCIES: compute the indexes

``` r
tf_matrix=tf(corpus,"Severe_recession")
tf_matrix
#> # A tibble: 5 x 2
#>   var[,1] file                          
#>     <dbl> <chr>                         
#> 1       0 ARG_1983-01-25_request        
#> 2       0 ARG_1983-05-18_modification   
#> 3      NA ARG_1983-05-27_modification   
#> 4       0 ARG_1983-06-08_exchange system
#> 5       0 ARG_1983-07-28_exchange system
```

Compute the document term frequency for several categories "Currency\_crisis" and "Balance\_payment\_crisis". Each documents correspond to a row of the table and the different indexes in columns.

``` r

mycategories=c('Currency_crisis',"Balance_payment_crisis","Sovereign_default")

tf_vector(corpus=corpus,keyword_list=lexicon()[mycategories]) %>% head()
#> 
#> (1/3) running: Currency_crisis
#> Currency_crisis: 0.632 sec elapsed
#> 
#>  Finished running: Currency_crisis
#> 
#> (2/3) running: Balance_payment_crisis
#> Balance_payment_crisis: 0.711 sec elapsed
#> 
#>  Finished running: Balance_payment_crisis
#> 
#> (3/3) running: Sovereign_default
#> Sovereign_default: 0.607 sec elapsed
#> 
#>  Finished running: Sovereign_default
#> # A tibble: 5 x 4
#>   file               Currency_crisis[,… Balance_payment_cris… Sovereign_default…
#>   <chr>                           <dbl>                 <dbl>              <dbl>
#> 1 ARG_1983-01-25_re…                  0                     0           0.00470 
#> 2 ARG_1983-05-18_mo…                  0                     0           0.000642
#> 3 ARG_1983-05-27_mo…                 NA                    NA          NA       
#> 4 ARG_1983-06-08_ex…                  0                     0           0       
#> 5 ARG_1983-07-28_ex…                  0                     0           0
```

Wrapup function for tf() . Given a corpus saved locally compute the term frequencies for different categories. In the following example we used mycorpus.RData and the categories Currency\_crisis and Balance\_payment\_crisis.

``` r

#Run term frequency matrix

wrapup_for_tf=run_tf(corpus_path = "mycorpus.RData",
                     keyword_list = c("Currency_crisis","Balance_payment_crisis"),
                     parrallel = F)
#> Loading corpus from mycorpus.RData
#> (1/2) running: Currency_crisis
#> Currency_crisis: 0.752 sec elapsed
#> 
#>  Finished running: Currency_crisis
#> 
#> (2/2) running: Balance_payment_crisis
#> Balance_payment_crisis: 0.596 sec elapsed
#> 
#>  Finished running: Balance_payment_crisis
#> 1.386 sec elapsed
#> [1] "export table in mycorpus.RData"

head(wrapup_for_tf)
#> # A tibble: 5 x 3
#>   file                           Currency_crisis[,1] Balance_payment_crisis[,1]
#>   <chr>                                        <dbl>                      <dbl>
#> 1 ARG_1983-01-25_request                           0                          0
#> 2 ARG_1983-05-18_modification                      0                          0
#> 3 ARG_1983-05-27_modification                     NA                         NA
#> 4 ARG_1983-06-08_exchange system                   0                          0
#> 5 ARG_1983-07-28_exchange system                   0                          0
```

Wrapup function for run\_tf that allows directly download the files and run the text mining with a single function.

``` r
run_tf_by_chunk(urls =url_links,keyword_list = c("Currency_crisis","Balance_payment_crisis"))
#> Warning in dir.create(path): 'temp' already exists
#> Warning in dir.create(path_corpus): 'temp/corpus' already exists
#> Warning in dir.create(path_tf): 'temp/tf' already exists
#> ARG_1983-01-25_request: succesfully downloaded 
#> ARG_1983-01-25_request : 1/6: 2.696 sec elapsed
#> ARG_1983-05-18_modification: succesfully downloaded 
#> ARG_1983-05-18_modification : 2/6: 2.348 sec elapsed
#> ARG_1983-05-27_modification: succesfully downloaded 
#> ARG_1983-05-27_modification : 3/6: 1.89 sec elapsed
#> ARG_1983-05-27_modification: already downloaded, keep existing 
#> ARG_1983-05-27_modification : 4/6: 0.013 sec elapsed
#> ARG_1983-06-08_exchange system: succesfully downloaded 
#> ARG_1983-06-08_exchange system : 5/6: 2.028 sec elapsed
#> ARG_1983-07-28_exchange system: succesfully downloaded 
#> ARG_1983-07-28_exchange system : 6/6: 2.593 sec elapsed
#> urls succesfully downloaded in 'temp/files
#> '[1] "temp/files/ARG_1983-01-25_request.pdf"
#> 1/5 ARG_1983-01-25_request: 0.154 sec elapsed
#> [1] "temp/files/ARG_1983-05-18_modification.pdf"
#> 2/5 ARG_1983-05-18_modification: 0.048 sec elapsed
#> [1] "temp/files/ARG_1983-05-27_modification.pdf"
#> 3/5 ARG_1983-05-27_modification: 0.008 sec elapsed
#> [1] "temp/files/ARG_1983-06-08_exchange system.pdf"
#> 4/5 ARG_1983-06-08_exchange system: 0.014 sec elapsed
#> [1] "temp/files/ARG_1983-07-28_exchange system.pdf"
#> 5/5 ARG_1983-07-28_exchange system: 0.014 sec elapsed
#> delete folder with pdf 
#> Loading corpus from temp/corpus/corpus_1.RData
#> (1/2) running: Currency_crisis
#> Currency_crisis: 1.045 sec elapsed
#> 
#>  Finished running: Currency_crisis
#> 
#> (2/2) running: Balance_payment_crisis
#> Balance_payment_crisis: 1.05 sec elapsed
#> 
#>  Finished running: Balance_payment_crisis
#> 2.145 sec elapsed
#> [1] "export table in temp/corpus/corpus_1.RData"
#> [1] TRUE
```

Update the tf dataframe with additional columns with the new categories to compute

``` r

updated_tf=run_tf_update(path_tf_to_update = "temp/tf/tf_crisis_words_1.RData",
                corpus_path = "temp/corpus/corpus_1.RData",
                keyword_list = c("Fiscal_outcomes","Fiscal_consolidation"),
                export_path = "temp/tf/tf_crisis_words_1_new.RData")
#> updating selected columnsLoading corpus from temp/corpus/corpus_1.RData
#> (1/2) running: Fiscal_outcomes
#> Fiscal_outcomes: 0.848 sec elapsed
#> 
#>  Finished running: Fiscal_outcomes
#> 
#> (2/2) running: Fiscal_consolidation
#> Fiscal_consolidation: 1.046 sec elapsed
#> 
#>  Finished running: Fiscal_consolidation
#> 1.967 sec elapsed
#> [1] "export table in temp/corpus/corpus_1.RData"
#> [1] "Non updated columns:\n\n                 file, Currency_crisis, Balance_payment_crisis"
#> [1] "Updated columns:\n\n                 Fiscal_outcomes, Fiscal_consolidation"

head(updated_tf)
#> # A tibble: 5 x 5
#>   file     Currency_crisis[… Balance_payment_… Fiscal_outcomes… Fiscal_consolid…
#>   <chr>                <dbl>             <dbl>            <dbl>            <dbl>
#> 1 ARG_198…                 0                 0          0.00381         0.000332
#> 2 ARG_198…                 0                 0          0               0       
#> 3 ARG_198…                 0                 0          0               0       
#> 4 ARG_198…                 0                 0          0               0       
#> 5 ARG_198…                 0                 0          0               0
```
