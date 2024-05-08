## Hypothesis
 <b><u>Independent Variables: </u></b> 
* Delay_from_due_date
* Interest_Rate 
* Outstanding_Debt
* Total_EMI_per_month <br>

 <h3><b><u>Customers with high Delay_from_due_date, high Interest_Rate, high Outstanding_Debt, and high Total_EMI_per_month have a low credit score</u></b></h3>

## Objectives
- To investigate the impact of Delay_from_due_date to the credit score
- To investigate the impact of Interest_Rate to the credit score
- To investigate the impact of Outstanding_Debt to the credit score
- To investigate the impact of Total_EMI_per_month to the credit score

## Tasks
- **Ibrahim:** Clean **Outstanding_Debt** 

## Clean Tasks:
Default Null String Value = NULL
- Age, Num_of_Loan, Num_of_Delayed_Payment, (chr)
    - Remove characters -, _ ✅
    - Convert to integer ✅
    - Handle null
    - Fix Outliers
- Occupation (chr)
    - Set _______ to normalized null string value
- Annual_Income, Num_of_Delayed_Payment, Outstanding_Debt, Monthly_Balance (chr)
    - Remove _
    - Convert to double
    - Fix Outliers
- Monthly_Inhand_Salary, Changed_Credit_Limit (dbl)
    - Fix Outliers
- Num_Bank_Accounts, Num_Credit_Cards, Interest_Rate, (int)
    - Fix Outliers, 
    - Set -1 values to null
- Delay_from_due_date (int)
    - Set -1 to null
    - Set other negatives to positive
    - Fix Outliers
- Credit_Mix, Payment_of_Min_Amount (str)
    - Remove _
    - Convert to factor
- Credit_Utilization_Ratio (dbl)
    - Fix Outliers (I think nothing here)
- Credit_History_Age (chr) **(Possible ignore)**
    - Convert to Integer (grab year only)
- Total_EMI_per_month (dbl) **UNSURE WHAT TO DO**
    - Fix Outliers
- Amount_invested_monthly (chr)
    - Convert to dbl
- Payment_Behaviour (chr)
    - Convert to factor
    - Change !@9#%8 to default string null value
- Monthly_Balance (chr)
    - Remove weird characters if exists
    - Convert to double

## TODO LIST:
<details><summary>
Create Hypothesis and Objectives ✅
</summary>
<ul>
    <li>Select 4 independent variables ✅</li>
<ul>
</details>

<details><summary>
Clean Data <--- CURRENT WORK
</summary>
<ul>

<li>
Total_EMI_per_month:
    <ul>
        <li>Round off to 2DP</li>
        <li>Remove nulls</li>
        <li>Identify outliers</li>
    </ul>
</li>

<li>
Delay_from_due_date: 
    <ul>
        <li>Deal with negative values</li>
        <li>Identify outliers</li>
    </ul>
</li>

<li>
Interest_Rate: 
    <ul>
        <li>Do something about the crazy interest rates?</li>
    </ul>
</li>

<li>
Outstanding_Debt: 
    <ul>
        <li>Deal with nulls ❌</li>
        <li>Remove unnecessary characters ✅</li>
        <li>Convert to Numeric ✅</li>
    </ul>
</li>

</ul>
</details>

## How to work on this repo

*If you are using vscode, add the following to settings.json:*
```json
    "editor.tabSize": 4,
    "[r]": {
        "editor.tabSize": 2
    },
```

1. Pull latest progress from the remote repository.
```bash
### SAFER IF YOU ARE EXPECTING CONFLICTS
>>> git diff origin/main    # Replace main with branch name, review changes
>>> git fetch               # FETCH_HEAD
>>> git merge

### OR
>>> git pull        
```
2. Create and work on new branch on your local repository. 
```bash
>>> git branch samplebranch     # Create new branch
>>> git checkout samplebranch   # Use new branch
```
3. Commit progress after each session
```bash
>>> git commit -m "Commit message"
```
4. Push newly finished content to the remote repository
```bash
### main branch
>>> git push
### other branches
>>> git push origin samplebranch
```
5. Create Pull Request on the github repository once the feature is complete
    - Check the github repository online and send pull request for the branch

#### **Extras**
```bash
### Remove branch from remote repository
>>> git push <remote_name> --delete <branch_name>
```
