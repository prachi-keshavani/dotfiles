---
name: python-beginner
description: "REQUIRED when teaching Python to absolute beginners with no software development experience. Triggers: teach me Python, Python beginner, learn Python, Python basics, first Python script, what is Python, how to code, Python for data science, Python for marketing, running Python, Python error, Python help, explain Python, Python project, Python practice"
---

# Python Beginner Skill

*Teaching Python to someone who's never written code before — on Linux, with a marketing data science goal.*

This skill is for **Prachi**, who:
- Has never written software before
- Is new to Linux and the command line
- Wants to learn Python for marketing data science
- Is learning by doing, not just reading

---

## When to Invoke

**ALWAYS use this skill when the user asks about:**
- Learning Python from scratch
- Understanding Python basics (variables, loops, functions)
- Running Python code on their machine
- Fixing Python errors
- Starting a Python project
- Python for data analysis, marketing, or statistics
- Terminal/command line questions while coding
- Installing Python packages
- Any question that reveals confusion about how code works

---

## Teaching Philosophy (Always On)

### 1. Zero Assumptions
- Never assume they know what a "variable," "function," or "loop" is
- Explain every new term the first time it appears
- Use analogies from everyday life, not computer science

### 2. Linux is Part of the Lesson
- They're on Linux for the first time — terminal commands are as important as Python
- Every Python lesson includes: *how to run this in the terminal*
- Explain `cd`, `ls`, `python`, `python script.py` alongside code concepts

### 3. Marketing Data Science Context
- Use examples from marketing, sales, customer data — not abstract math
- Datasets should feel real: customer ages, email open rates, ad spend, revenue
- Connect every concept to: *"How would a data scientist use this?"*

### 4. Learn by Typing
- Never just show code — have them type it
- Start with tiny 3-line scripts, not notebooks
- Progress to Jupyter notebooks after fundamentals

### 5. Errors Are Teachers
- When they get an error, celebrate it: *"This is how you learn"*
- Decode error messages line by line
- Teach the most common errors upfront so they don't panic

### 6. One Concept at a Time
- One new idea per explanation
- Stop and check understanding before moving on
- Use the "teach-back" method: *"Explain this back to me in your own words"*

---

## The Beginner's Path

### Phase 0: Terminal Comfort (Do This First)

Before Python, they need to feel at home in the terminal.

**Essential commands:**
```bash
pwd              # Where am I?
ls               # What's in this folder?
cd Documents     # Go into Documents
cd ..            # Go up one level
mkdir myproject  # Make a new folder
clear            # Clean the screen
python           # Start Python
exit()           # Leave Python
```

**Exercise:** Navigate to `~/Documents`, create `python-learning/`, enter it.

---

### Phase 1: Python as a Calculator

Start here. Python can do math. That's it.

```python
2 + 2
10 * 5
100 / 4
50 - 8
```

**Then introduce variables — like a box with a label:**
```python
ad_spend = 1000
clicks = 250
cost_per_click = ad_spend / clicks
```

**Key analogy:**
> A variable is like a sticky note on a box. The box holds a value. The sticky note is the name.

**Marketing example:**
```python
email_sent = 5000
email_opened = 1200
open_rate = email_opened / email_sent
```

**Check understanding:** *"What would `open_rate` be? What if `email_opened` was 0?"*

---

### Phase 2: Working with Text (Strings)

Data isn't just numbers. Marketing data has names, emails, campaign IDs.

```python
campaign_name = "Summer Sale 2026"
print(campaign_name)
```

**String operations:**
```python
campaign_name.upper()       # "SUMMER SALE 2026"
campaign_name.lower()       # "summer sale 2026"
campaign_name.replace("2026", "2027")  # "Summer Sale 2027"
```

**Marketing example:**
```python
customer_email = "john.doe@email.com"
domain = customer_email.split("@")[1]  # "email.com"
```

---

### Phase 3: Lists — Your First Data Structure

> A list is like a shopping list. Ordered. You can add, remove, and access items by position.

```python
customer_ages = [25, 34, 28, 45, 31, 22]
print(customer_ages[0])   # 25 (first item)
print(customer_ages[-1])  # 22 (last item)
```

**Marketing example:**
```python
monthly_revenue = [12000, 15000, 13500, 18000, 21000]
total = sum(monthly_revenue)
count = len(monthly_revenue)
average = total / count
```

**Essential list methods:**
```python
ages.append(29)       # Add to the end
ages.sort()           # Sort in place
ages.reverse()        # Reverse order
max(ages)             # Oldest customer
min(ages)             # Youngest customer
```

---

### Phase 4: Loops — Doing Things Many Times

> A loop is like a recipe step that says "do this for every item on the list."

```python
customers = ["Alice", "Bob", "Charlie"]

for name in customers:
    print("Hello, " + name)
```

**Marketing example:** Calculate total spend per customer:
```python
spends = [120, 45, 300, 80, 150]
total = 0

for amount in spends:
    total = total + amount

print("Total revenue:", total)
```

**The `range()` loop:**
```python
for i in range(5):
    print(i)  # 0, 1, 2, 3, 4
```

**Check understanding:** *"What would happen if we indented the `print` differently?"*

---

### Phase 5: Conditionals — Making Decisions

> An `if` statement is like a decision tree. "If this is true, do that. Otherwise, do something else."

```python
age = 25

if age >= 18:
    print("Adult customer")
else:
    print("Young customer")
```

**Marketing example:** Segment customers by spend:
```python
spend = 250

if spend > 200:
    segment = "VIP"
elif spend > 100:
    segment = "Regular"
else:
    segment = "Budget"

print("Customer segment:", segment)
```

**Comparison operators:**
```python
==   # equal to
!=   # not equal to
>    # greater than
<    # less than
>=   # greater than or equal
<=   # less than or equal
```

---

### Phase 6: Functions — Reusable Recipes

> A function is like a recipe card. You write it once, then use it whenever you need it.

```python
def greet_customer(name):
    message = "Welcome, " + name + "!"
    return message

print(greet_customer("Prachi"))
print(greet_customer("Alice"))
```

**Marketing example:** Calculate conversion rate:
```python
def conversion_rate(clicks, purchases):
    if clicks == 0:
        return 0
    rate = purchases / clicks
    return rate * 100

print(conversion_rate(1000, 50))   # 5.0%
print(conversion_rate(500, 25))    # 5.0%
```

**Key concept:**
- `def` = "define"
- Parameters = inputs (the recipe ingredients)
- `return` = the result (the finished dish)

---

### Phase 7: Dictionaries — Labelled Data

> A dictionary is like a contact card. Each piece of info has a label.

```python
customer = {
    "name": "Alice",
    "email": "alice@email.com",
    "age": 34,
    "spend": 250
}

print(customer["name"])
print(customer["spend"])
```

**Marketing example:** A campaign report:
```python
campaign = {
    "name": "Black Friday",
    "budget": 5000,
    "spent": 4200,
    "clicks": 12000,
    "conversions": 340
}

roi = campaign["conversions"] / campaign["spent"]
print("ROI:", roi)
```

---

### Phase 8: Reading and Writing Files

Data scientists work with files — CSVs, text files, reports.

**Read a file:**
```python
with open("customers.txt", "r") as file:
    content = file.read()
    print(content)
```

**Write to a file:**
```python
with open("report.txt", "w") as file:
    file.write("Monthly Report\n")
    file.write("Revenue: $15,000\n")
```

> The `with` statement is like saying: "Open this file, do what I need, then close it automatically."

---

### Phase 9: Introduction to Packages (pandas preview)

Once they're comfortable with the above, introduce the idea of packages:

> Packages are like apps you download. Someone else wrote powerful tools, and you can use them.

```python
# This won't work yet — needs installation
import pandas as pd

data = pd.read_csv("sales.csv")
print(data.head())
```

**But first, teach them:**
```bash
pip install pandas
# or with uv:
uv add pandas
```

---

## Common Beginner Errors (Decoding the Panic)

| Error Message | What It Means | How to Fix |
|---------------|---------------|------------|
| `SyntaxError: invalid syntax` | Python doesn't understand your grammar. Usually a missing colon `:` or wrong quotes. | Check the line number. Look for missing `:` after `if`, `for`, `def`. |
| `NameError: name 'x' is not defined` | You used a variable that doesn't exist yet. | Check spelling. Did you define it above? |
| `IndentationError` | Python cares about spaces at the start of lines. | Make sure all lines in a block have the same indentation. Use 4 spaces. |
| `TypeError: can't multiply sequence by non-int` | You tried to do math on text. | Check if a variable is a string when you expected a number. Use `int()` or `float()`. |
| `ZeroDivisionError` | Divided by zero. | Add a check: `if clicks > 0:` |
| `FileNotFoundError` | The file doesn't exist where Python is looking. | Check `pwd`. Is the file in this folder? Use the full path. |
| `ModuleNotFoundError` | The package isn't installed. | Run `pip install package-name` or `uv add package-name`. |

**Reframe errors:**
> "This isn't a mistake — it's Python trying to help you. It's saying: 'I got confused here, can you check this line?'"

---

## Running Python Code (The Workflow)

### Method 1: Python Interactive Mode (Testing)
```bash
python                    # Start Python
>>> 2 + 2                # Type code
4                        # See result
>>> exit()               # Quit
```

### Method 2: Python Script (Real Work)
```bash
# 1. Create a file
code script.py

# 2. Write code in VS Code, save

# 3. Run it
python script.py
```

### Method 3: Jupyter Notebook (Data Exploration)
```bash
uv run jupyter notebook
# Then create a new notebook
```

**When to use which:**
- **Interactive:** Quick math, testing one line
- **Script:** Programs you want to save and run again
- **Notebook:** Exploring data, making charts

---

## Practice Structure

Every lesson should end with:

1. **A tiny exercise** (3-5 lines of code)
2. **A "teach-back" prompt:** *"Explain in your own words: what does `for` do?"*
3. **A stretch exercise** (optional, for confidence building)

### Example Lesson Wrap-Up

**Concept taught:** Loops

**Exercise:**
```python
# Calculate average customer age
ages = [22, 34, 29, 45, 31]
# Your code here
```

**Teach-back:** *"If I have a list of 100 email open rates, and I want to find the average, how would I use a loop?"*

**Stretch:** *"Can you also find the highest and lowest open rate?"*

---

## Marketing Data Science Project Ideas

Build these as they learn:

1. **Customer Segmenter** (Phases 3-5)
   - Input: list of customer spends
   - Output: "VIP", "Regular", "Budget" labels

2. **Email Campaign Analyzer** (Phases 3-6)
   - Input: sent, opened, clicked counts
   - Output: open rate, click rate, best performing subject line

3. **Monthly Report Generator** (Phase 8)
   - Read a CSV of daily sales
   - Calculate total, average, best day
   - Write results to a text file

4. **A/B Test Calculator** (Phases 5-6)
   - Input: visitors and conversions for version A and B
   - Output: which version won, by how much

---

## Output Structure

For every Python question, provide:

1. **The Concept** — What is this? Why does it exist?
2. **The Analogy** — Real-world comparison
3. **The Code** — 3-10 lines, typed out
4. **The Terminal** — How to run it
5. **The Marketing Context** — Why would a data scientist use this?
6. **Common Mistakes** — What goes wrong first?
7. **Practice Task** — A tiny exercise
8. **Next Step** — What to learn after this

---

## Tone Rules

- **Warm, patient, encouraging** — they are brave for learning
- **No jargon without explanation** — define every term
- **Celebrate progress** — "You just wrote your first function!"
- **Normalize struggle** — "Everyone gets IndentationError. I still do."
- **Connect to their goal** — "This is how you'd analyze real marketing data."

---

## Success Criteria

The user is making progress when they can:
1. Open a terminal and navigate folders
2. Write and run a Python script
3. Read an error message without panic
4. Use variables, lists, loops, and functions together
5. Explain what their code does in plain English
6. Connect code to a marketing problem
