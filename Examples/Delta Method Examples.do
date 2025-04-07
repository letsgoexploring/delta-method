clear 
cls

/*This do-file verifies the calculations in Delta Method.ipynb.

The data file Inflation_Unemployment_Data.csv must be in the same directory as this do-file.*/

// Import data
import delimited Inflation_Unemployment_Data.csv

// Set time series
tsset index

// Generate first-difference of inflation
gen inflation_diff = d.inflation

// Regress inflation (first-difference) on two lags of inflation (first-difference)
regress inflation_diff L.inflation_diff L2.inflation_diff

// Example 1: g(β) = β_0^0.25
nlcom (_b[_cons]^(0.25))

// Example 2: g(β) = β_1/β_2
nlcom (_b[L.inflation_diff]/_b[L2.inflation_diff])

// Example 3: g(β) =  (β_1 + β_2, β_1/β_2, β_1/β_2^6)
nlcom (_b[L.inflation_diff]+_b[L2.inflation_diff]) (_b[L.inflation_diff]/_b[L2.inflation_diff]) (_b[_cons]+ _b[L1.inflation]/_b[L2.inflation]^6)

// Example 4: g(β) = β_1/β_2, 99% C.I.
nlcom (_b[L1.inflation]/_b[L2.inflation]), level(99)

// Example 5: Regress the first-difference of inflation on its first four lagged values and four lags of unemployment.
regress inflation_diff L.inflation_diff L2.inflation_diff L3.inflation_diff L4.inflation_diff L.unemployment L2.unemployment L3.unemployment L4.unemployment

// Estimate β_5 + β_6 + β_7 + β_8
nlcom (_b[L1.unemployment]+_b[L2.unemployment]+_b[L3.unemployment]+_b[L4.unemployment])
