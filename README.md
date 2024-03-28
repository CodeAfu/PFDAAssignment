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
- **Ruhit:** 

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

If you are using vscode, add the following to settings.json:
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
>>> git merge               # FETCH_HEAD
>>> git fetch

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
4. Merge contents to main branch once feature is complete and free of bugs
```bash
>>> git checkout main
>>> git merge samplebranch
>>> git branch -d samplebranch  # -D for forced delete
```
