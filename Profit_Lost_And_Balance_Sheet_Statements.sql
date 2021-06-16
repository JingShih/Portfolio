# Profit and Lost Statement Line 4 - 389
# Balance Sheet Statements Line 391 - 702

#----------------------------------------------------------------------------------------------------------------------------------------
# Profit and Lost Statement
#----------------------------------------------------------------------------------------------------------------------------------------
USE H_Accounting;

DROP PROCEDURE IF EXISTS cshih2019_calculate_revenues_for_a_cy;

DELIMITER $$                 

	CREATE PROCEDURE cshih2019_calculate_revenues_for_a_cy(varCalendarYear YEAR)
	BEGIN
  
		DECLARE varTotalRevenues DOUBLE DEFAULT 0;
        DECLARE varTotalRevenues_Lastyear DOUBLE DEFAULT 0;
        DECLARE varCOGS DOUBLE DEFAULT 0;
        DECLARE varCOGS_Lastyear DOUBLE DEFAULT 0;
        DECLARE varGEXP DOUBLE DEFAULT 0;
        DECLARE varGEXP_Lastyear DOUBLE DEFAULT 0;
        DECLARE varSEXP DOUBLE DEFAULT 0;
        DECLARE varSEXP_Lastyear DOUBLE DEFAULT 0;
        DECLARE varOEXP DOUBLE DEFAULT 0;
		DECLARE varOEXP_Lastyear DOUBLE DEFAULT 0;
        DECLARE varOI DOUBLE DEFAULT 0;
        DECLARE varOI_Lastyear DOUBLE DEFAULT 0;
        DECLARE varEBIT DOUBLE DEFAULT 0;
        DECLARE varEBIT_Lastyear DOUBLE DEFAULT 0;
        DECLARE varINCTAX DOUBLE DEFAULT 0;
        DECLARE varINCTAX_Lastyear DOUBLE DEFAULT 0;
        DECLARE varOTHTAX DOUBLE DEFAULT 0;
        DECLARE varOTHTAX_Lastyear DOUBLE DEFAULT 0;
  
		# Total Revenue
		SELECT  SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit, 0)) INTO varTotalRevenues
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 				AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
			WHERE ss.statement_section_code = "REV"
				AND YEAR(je.entry_date) = varCalendarYear;
		
        # Total Revenue (last year)
        SELECT  SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit, 0)) INTO varTotalRevenues_Lastyear
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 				AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
			WHERE ss.statement_section_code = "REV"
				AND YEAR(je.entry_date) = varCalendarYear - 1;
		
        # Cost of goods and services 
		SELECT  SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit, 0)) INTO varCOGS
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 				AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
			WHERE ss.statement_section_code = "COGS"
				AND YEAR(je.entry_date) = varCalendarYear;
		
        # Cost of goods and services (last year)
		SELECT  SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit, 0)) INTO varCOGS_Lastyear
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 				AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
			WHERE ss.statement_section_code = "COGS"
				AND YEAR(je.entry_date) = varCalendarYear - 1;
                
		# Administrative Expenses 
		SELECT  SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit, 0)) INTO varGEXP
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 				AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
			WHERE ss.statement_section_code = "GEXP"
				AND YEAR(je.entry_date) = varCalendarYear;
                
		# Administrative Expenses (last year)
		SELECT  SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit, 0)) INTO varGEXP_Lastyear
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 				AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
			WHERE ss.statement_section_code = "GEXP"
				AND YEAR(je.entry_date) = varCalendarYear - 1;
		
        # Selling expenses
        SELECT  SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit, 0)) INTO varSEXP
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 				AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
			WHERE ss.statement_section_code = "SEXP"
				AND YEAR(je.entry_date) = varCalendarYear;
		
        # Selling expenses (last year)
        SELECT  SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit, 0)) INTO varSEXP_Lastyear
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 				AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
			WHERE ss.statement_section_code = "SEXP"
				AND YEAR(je.entry_date) = varCalendarYear - 1;
                
        # Other expenses
        SELECT  SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit, 0)) INTO varOEXP
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 				AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
			WHERE ss.statement_section_code = "OEXP"
				AND YEAR(je.entry_date) = varCalendarYear;
                
		# Selling expenses (last year)
        SELECT  SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit, 0)) INTO varSEXP_Lastyear
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 				AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
			WHERE ss.statement_section_code = "SEXP"
				AND YEAR(je.entry_date) = varCalendarYear - 1;
                
		# Other income
        SELECT  SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit, 0)) INTO varOI
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 				AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
			WHERE ss.statement_section_code = "OI"
				AND YEAR(je.entry_date) = varCalendarYear;
                
		# Other income (last year)
        SELECT  SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit, 0)) INTO varOI_Lastyear
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 				AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
			WHERE ss.statement_section_code = "OI"
				AND YEAR(je.entry_date) = varCalendarYear - 1;
		
        # Income Tax
        SELECT  SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit, 0)) INTO varINCTAX
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 				AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
			WHERE ss.statement_section_code = "INCTAX"
				AND YEAR(je.entry_date) = varCalendarYear;
                
		# Income Tax (last year)
        SELECT  SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit, 0)) INTO varINCTAX_Lastyear
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 				AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
			WHERE ss.statement_section_code = "INCTAX"
				AND YEAR(je.entry_date) = varCalendarYear - 1;
		
         # Income Tax
        SELECT  SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit, 0)) INTO varOTHTAX
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 				AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
			WHERE ss.statement_section_code = "OTHTAX"
				AND YEAR(je.entry_date) = varCalendarYear;
		
         # Income Tax (last year)
        SELECT  SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit, 0)) INTO varOTHTAX_Lastyear
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 				AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 		AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
			WHERE ss.statement_section_code = "OTHTAX"
				AND YEAR(je.entry_date) = varCalendarYear - 1;
        
		DROP TABLE IF EXISTS tmp_cshih2019_table;
  
		-- create table with the columns that we need
		CREATE TABLE tmp_cshih2019_table
		(`Index` INT, 
			Label VARCHAR(50), 
			Amount VARCHAR(50),
            `Last Year` VARCHAR(50));
  
  -- insert the a header for the report
	INSERT INTO tmp_cshih2019_table 
		(`Index`, Label, Amount, `Last Year`)
		VALUES (1, 'PROFIT AND LOSS STATEMENT', "In '000s of USD" , '');
  
	INSERT INTO tmp_cshih2019_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (2, '', varCalendarYear, varCalendarYear-1);
    
	# Total Revenues
	INSERT INTO tmp_cshih2019_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (3, 'Total Revenues', format(varTotalRevenues / 1000, 2), format(varTotalRevenues_Lastyear / 1000, 2));
   
    # Cost of goods and services
	INSERT INTO tmp_cshih2019_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (4, 'Cost Of Goods And Services', format(varCOGS / 1000, 2), format(varCOGS_Lastyear / 1000, 2));
	
    # Gross Profit
    INSERT INTO tmp_cshih2019_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (5, 'Gross Profit', format((varTotalRevenues - varCOGS) / 1000, 2),format((varTotalRevenues_Lastyear - varCOGS_Lastyear) / 1000, 2));
	
	INSERT INTO tmp_cshih2019_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (6, '', '', '');
	
    # Administrative Expenses
    INSERT INTO tmp_cshih2019_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (7, 'Administrative Expenses', format(IFNULL(varGEXP,0) / 1000, 2), format(IFNULL(varGEXP_Lastyear,0) / 1000, 2));
	
    # Selling Expenses
    INSERT INTO tmp_cshih2019_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (8, 'Selling Expenses', format(varSEXP / 1000, 2), format(varSEXP_Lastyear / 1000, 2));
	
    # Other Expenses
    INSERT INTO tmp_cshih2019_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (9, 'Other Expenses', format(varOEXP / 1000, 2), format(varOEXP_Lastyear / 1000, 2));
	
    # Earning Before Interest And Taxes (EBIT)
    INSERT INTO tmp_cshih2019_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (10, 'Earning Before Interest And Taxes (EBIT)', 
					format(
							(
								IFNULL(varTotalRevenues,0) 
								- IFNULL(varCOGS,0) 
								- IFNULL(varGEXP,0) 
								- IFNULL(varSEXP,0) 
								- IFNULL(varOEXP,0)
							)/ 1000
							, 2),
					format(
							(
								IFNULL(varTotalRevenues_Lastyear,0) 
								- IFNULL(varCOGS_Lastyear,0) 
								- IFNULL(varGEXP_Lastyear,0) 
								- IFNULL(varSEXP_Lastyear,0) 
								- IFNULL(varOEXP_Lastyear,0)
							)/ 1000
							, 2)
				);
    
    INSERT INTO tmp_cshih2019_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (11, '', '', '');
	
    # Other Income
	INSERT INTO tmp_cshih2019_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (12, 'Other Income', format(IFNULL(varOI,0)/ 1000, 2), format(IFNULL(varOI_Lastyear,0)/ 1000, 2));
	
    # Profit Before Tax
    INSERT INTO tmp_cshih2019_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (13, 'Profit Before Tax', 
					format(
							(
								IFNULL(varTotalRevenues,0) 
								- IFNULL(varCOGS,0) 
								- IFNULL(varGEXP,0) 
								- IFNULL(varSEXP,0) 
								- IFNULL(varOEXP,0)
                                + IFNULL(varOI,0)
							)/ 1000
							, 2),
					format(
							(
								IFNULL(varTotalRevenues_Lastyear,0) 
								- IFNULL(varCOGS_Lastyear,0) 
								- IFNULL(varGEXP_Lastyear,0) 
								- IFNULL(varSEXP_Lastyear,0) 
								- IFNULL(varOEXP_Lastyear,0)
                                + IFNULL(varOI_Lastyear,0)
							)/ 1000
							, 2)
				);
    
    INSERT INTO tmp_cshih2019_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (14, '', '', '');
	
    # Income Tax
    INSERT INTO tmp_cshih2019_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (15, 'Income Tax', format(IFNULL(varINCTAX,0)/ 1000, 2), format(IFNULL(varINCTAX_Lastyear,0)/ 1000, 2));
	
    # Other Tax
    INSERT INTO tmp_cshih2019_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (16, 'Other Tax', format(IFNULL(varOTHTAX,0) / 1000, 2), format(IFNULL(varOTHTAX_Lastyear,0) / 1000, 2));
	
    # Profit For The Year
    INSERT INTO tmp_cshih2019_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (17, 'Profit For The Year', 
					format(
							(
								IFNULL(varTotalRevenues,0) 
								- IFNULL(varCOGS,0) 
								- IFNULL(varGEXP,0) 
								- IFNULL(varSEXP,0) 
								- IFNULL(varOEXP,0)
                                + IFNULL(varOI,0)
                                - IFNULL(varINCTAX,0)
								- IFNULL(varOTHTAX,0)
							)/ 1000
							, 2),
					format(
							(
								IFNULL(varTotalRevenues_Lastyear,0) 
								- IFNULL(varCOGS_Lastyear,0) 
								- IFNULL(varGEXP_Lastyear,0) 
								- IFNULL(varSEXP_Lastyear,0) 
								- IFNULL(varOEXP_Lastyear,0)
                                + IFNULL(varOI_Lastyear,0)
                                - IFNULL(varINCTAX_Lastyear,0)
								- IFNULL(varOTHTAX_Lastyear,0)
							)/ 1000
							, 2)
				);
    
    
        
    SELECT * FROM tmp_cshih2019_table;  
    
	END $$
    
DELIMITER ;
CALL cshih2019_calculate_revenues_for_a_cy (2020);

#----------------------------------------------------------------------------------------------------------------------------------------
# Balance Sheet Statements
#----------------------------------------------------------------------------------------------------------------------------------------
USE H_Accounting;

DROP PROCEDURE IF EXISTS anto_balance_sheet;

DELIMITER $$

CREATE PROCEDURE anto_balance_sheet(varCalendarYear YEAR)
BEGIN

	DECLARE varCurrentAssets DOUBLE DEFAULT 0;
	DECLARE varCurrentAssetsly DOUBLE DEFAULT 0;
    DECLARE varFixedAssets DOUBLE DEFAULT 0;
	DECLARE varFixedAssetsly DOUBLE DEFAULT 0;
    DECLARE varDeferredAssets DOUBLE DEFAULT 0;
    DECLARE varDeferredAssetsly DOUBLE DEFAULT 0;
    DECLARE varTotalAssets DOUBLE DEFAULT 0;
    DECLARE varTotalAssetsly DOUBLE DEFAULT 0;
    DECLARE varCurrentLiabilities DOUBLE DEFAULT 0;
    DECLARE varCurrentLiabilitiesly DOUBLE DEFAULT 0;
    DECLARE varLongTermLiabilities DOUBLE DEFAULT 0;
	DECLARE varLongTermLiabilitiesly DOUBLE DEFAULT 0;
    DECLARE varDeferredLiabilities DOUBLE DEFAULT 0;
	DECLARE varDeferredLiabilitiesly DOUBLE DEFAULT 0;
    DECLARE varEquity DOUBLE DEFAULT 0;
    DECLARE varEquityly DOUBLE DEFAULT 0;

    
	# Current Assets
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit, 0))  INTO varCurrentAssets
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account AS ac 				ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry AS je 			ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section AS ss 		ON ss.statement_section_id = ac.balance_sheet_section_id
      
			WHERE ss.statement_section_code = "CA"
			  AND ac.balance_sheet_section_id <> 0
              AND je.debit_credit_balanced = 1
 			  AND YEAR(je.entry_date) = varCalendarYear;
	
	# Current Assets last year
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit, 0))  INTO varCurrentAssetsly
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 						AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 			AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
      
			WHERE ss.statement_section_code = "CA"
			  AND ac.balance_sheet_section_id <> 0
              AND je.debit_credit_balanced = 1
 			  AND YEAR(je.entry_date) = varCalendarYear-1;
	
	# Fixed Assets
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit, 0)) INTO varFixedAssets
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account AS ac 				ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry AS je 			ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section AS ss 		ON ss.statement_section_id = ac.balance_sheet_section_id
      
			WHERE ss.statement_section_code = "FA"
			  AND ac.balance_sheet_section_id <> 0
              AND je.debit_credit_balanced = 1
 			  AND YEAR(je.entry_date) = varCalendarYear;
	
	# Fixed Assets ly
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit, 0))  INTO varFixedAssetsly
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 						AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 			AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
      
			WHERE ss.statement_section_code = "FA"
			  AND ac.balance_sheet_section_id <> 0
              AND je.debit_credit_balanced = 1
 			  AND YEAR(je.entry_date) = varCalendarYear-1;
                

	# Deferred Assets
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit, 0))  INTO varDeferredAssets
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account AS ac 				ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry AS je 			ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section AS ss 		ON ss.statement_section_id = ac.balance_sheet_section_id
      
			WHERE ss.statement_section_code = "DA"
			  AND ac.balance_sheet_section_id <> 0
              AND je.debit_credit_balanced = 1
 			  AND YEAR(je.entry_date) = varCalendarYear;
	
	# Deferred Assets ly
	SELECT SUM(IFNULL(jeli.debit,0) - IFNULL(jeli.credit, 0)) INTO varDeferredAssetsly
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 						AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 			AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
      
			WHERE ss.statement_section_code = "DA"
			  AND ac.balance_sheet_section_id <> 0
              AND je.debit_credit_balanced = 1
 			  AND YEAR(je.entry_date) = varCalendarYear-1;
		
	# Current Liabilities
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit, 0))  INTO varCurrentLiabilities
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account AS ac 				ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry AS je 			ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section AS ss 		ON ss.statement_section_id = ac.balance_sheet_section_id
      
			WHERE ss.statement_section_code = "CL"
			  AND ac.balance_sheet_section_id <> 0
              AND je.debit_credit_balanced = 1
 			  AND YEAR(je.entry_date) = varCalendarYear;
	
	# Current Liabilities ly
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit, 0))   INTO varCurrentLiabilitiesly
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 						AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 			AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
      
			WHERE ss.statement_section_code = "CL"
			  AND ac.balance_sheet_section_id <> 0
              AND je.debit_credit_balanced = 1
 			  AND YEAR(je.entry_date) = varCalendarYear-1;

	# Long Term Liabilities
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit, 0))  INTO varLongTermLiabilities
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account AS ac 				ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry AS je 			ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section AS ss 		ON ss.statement_section_id = ac.balance_sheet_section_id
      
			WHERE ss.statement_section_code = "LLL"
			  AND ac.balance_sheet_section_id <> 0
              AND je.debit_credit_balanced = 1
 			  AND YEAR(je.entry_date) = varCalendarYear;
	
	# Long Term Liabilities ly
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit, 0)) INTO varLongTermLiabilitiesly
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 						AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 			AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
      
			WHERE ss.statement_section_code = "LLL"
			  AND ac.balance_sheet_section_id <> 0
              AND je.debit_credit_balanced = 1
 			  AND YEAR(je.entry_date) = varCalendarYear-1;

	# Deferred Liabilities
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit, 0))  INTO varDeferredLiabilities
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account AS ac 				ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry AS je 			ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section AS ss 		ON ss.statement_section_id = ac.balance_sheet_section_id
      
			WHERE ss.statement_section_code = "DL"
			  AND ac.balance_sheet_section_id <> 0
              AND je.debit_credit_balanced = 1
 			  AND YEAR(je.entry_date) = varCalendarYear;
	
	# Deferred Liabilities ly
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit, 0))  INTO varDeferredLiabilitiesly
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 						AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 			AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
      
			WHERE ss.statement_section_code = "DL"
			  AND ac.balance_sheet_section_id <> 0
              AND je.debit_credit_balanced = 1
 			  AND YEAR(je.entry_date) = varCalendarYear-1;

	# Equity
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit, 0))  INTO varEquity
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account AS ac 				ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry AS je 			ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section AS ss 		ON ss.statement_section_id = ac.balance_sheet_section_id
      
			WHERE ss.statement_section_code = "EQ"
			  AND ac.balance_sheet_section_id <> 0
              AND je.debit_credit_balanced = 1
 			  AND YEAR(je.entry_date) = varCalendarYear;
	
	# Equity ly
	SELECT SUM(IFNULL(jeli.credit,0) - IFNULL(jeli.debit, 0))   INTO varEquityly
		
			FROM journal_entry_line_item AS jeli
		
				INNER JOIN account 						AS ac ON ac.account_id = jeli.account_id
				INNER JOIN journal_entry 			AS je ON je.journal_entry_id = jeli.journal_entry_id
				INNER JOIN statement_section	AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
	
			WHERE ss.statement_section_code = "EQ"
			  AND ac.balance_sheet_section_id <> 0
              AND je.debit_credit_balanced = 1
 			  AND YEAR(je.entry_date) = varCalendarYear-1;

#----------------------------------------------------------------------------------------------------------------------------------------                
		DROP TABLE IF EXISTS tmp_afroio_table;
		-- create table with the columns that we need
		CREATE TABLE tmp_afroio_table
		(`Index` INT, 
			Label VARCHAR(50), 
			Amount VARCHAR(50),
            `Last Year` VARCHAR(50));
 
 -- insert the a header for the report
	INSERT INTO tmp_afroio_table 
		(`Index`, Label, Amount, `Last Year`)
		VALUES (1, 'BALANCE SHEET STATEMENT', "In '000s of USD",'');		

	INSERT INTO tmp_afroio_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (2, '', varCalendarYear, varCalendarYear-1);
#------------------------------------------------------------------------------------------------------------------------------------------

	#Current Assets 
	INSERT INTO tmp_afroio_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (3, 'Current Assets', ifnull(format(varCurrentAssets/ 1000, 2),0), ifnull(format(varCurrentAssetsly / 1000, 2),0));
	
	#Fixed assets
	INSERT INTO tmp_afroio_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (4, 'Fixed Assets', ifnull(format(varFixedAssets/ 1000, 2),0), ifnull(format(varFixedAssetsly / 1000, 2),0));

	#Deferred assets
	INSERT INTO tmp_afroio_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (5, 'Deferred Assets', ifnull(format(varDeferredAssets/ 1000, 2),0), ifnull(format(varDeferredAssetsly / 1000, 2),0));
	
	#Total assets
	INSERT INTO tmp_afroio_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (6, 'Total Assets', format((IFNULL(varCurrentAssets,0) + IFNULL(varFixedAssets,0) + IFNULL(varDeferredAssets,0))/ 1000, 2),
							format((IFNULL(varCurrentAssetsly,0) 
								+ IFNULL(varFixedAssetsly,0) 
								+ IFNULL(varDeferredAssetsly,0))/ 1000, 2));
	#space                                
	INSERT INTO tmp_afroio_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (7, '', '','');

	#Current Liabilities
	INSERT INTO tmp_afroio_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (8, 'Current Liabilities', ifnull(format(varCurrentLiabilities/ 1000, 2),0), ifnull(format(varCurrentLiabilitiesly / 1000, 2),0));
    
    #Long Term Liabilities
	INSERT INTO tmp_afroio_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (9, 'Long Term Liabilities', ifnull(format(varLongTermLiabilities/ 1000, 2),0), ifnull(format(varLongTermLiabilitiesly / 1000, 2),0));
	
	#Deferred Liabilities
	INSERT INTO tmp_afroio_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (10, 'Deferred Liabilities', ifnull(format(varDeferredLiabilities/ 1000, 2),0), ifnull(format(varDeferredLiabilitiesly / 1000, 2),0));
	
	#Equity
	INSERT INTO tmp_afroio_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (11,'Equity', ifnull(format(varEquity/ 1000, 2),0), ifnull(format(varEquityly / 1000, 2),0));
        
	# Tot Shareholder's equity and liabilities
    	INSERT INTO tmp_afroio_table 
		(`Index`, Label, Amount, `Last Year`)
  		VALUES (12, 'Total Shareholders Equity and Liabilities', format((IFNULL(varCurrentLiabilities,0) + IFNULL(varLongTermLiabilities,0) + IFNULL(varDeferredLiabilities,0) + IFNULL(varEquity,0))/ 1000, 2),
							format(
                            (IFNULL(varCurrentLiabilitiesly,0) 
								+ IFNULL(varLongTermLiabilitiesly,0) 
								+ IFNULL(varDeferredLiabilitiesly,0)
                                + IFNULL(varEquityly,0))
                                / 1000, 2
                                )
                                );


    SELECT * FROM tmp_afroio_table;  
                
	END $$
    
call anto_balance_sheet(2020)

