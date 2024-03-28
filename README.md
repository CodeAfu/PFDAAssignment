## Hypothesis
* <b><u>Independent Variables: </u></b> 
    * Delay_from_due_date, 
    * Interest_Rate, 
    * Outstanding_Debt, 
    * Total_EMI_per_month

- <b>Customers with high Delay_from_due_date, high Interest Rate, high Outstanding_Debt, and high Total_EMI_per_month have a low credit score</b>


## Objectives
- To investigate the impact of Delay_from_due_date to the credit score
- To investigate the impact of Interest_Rate to the credit score
- To investigate the impact of Outstanding_Debt to the credit score
- To investigate the impact of Total_EMI_per_month to the credit score

## How to work on this repo?
1. Pull latest progress from the remote repository.
```
>>> git pull        // Deal with conflicts if necessary 
```
2. Create and work on new branch on your local repository. 
```
>>> git branch samplebranch     // Create new branch
>>> git checkout samplebranch   // Use new branch
```
3. Commit progress after each session
```
>>> git commit -m "Commit message"
```
4. Merge contents to main branch once feature is complete and free of bugs
```
>>> git checkout main
>>> git merge samplebranch
```


## TODO LIST:
<details><summary>
Create Hypothesis and Objectives ✅
</summary>
<ul>
    <li>Select 4 independent variables ✅</li>
<ul>
</details>

<details><summary>
Clean Data
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
        <li>Deal with nulls</li>
        <li>Remove unnecessary characters</li>
        <li>Convert to Numeric</li>
    </ul>
</li>
</ul>
</details>
