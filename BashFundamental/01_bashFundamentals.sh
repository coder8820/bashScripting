#!/bin/bash

# ==========================================
# Bash Scripting Fundamentals
# ==========================================

echo "===== Bash Scripting Fundamentals ====="

# ------------------------------------------
# 1. Variables
# ------------------------------------------

name="Kumail"
age=22

echo "Name: $name"
echo "Age: $age"


# ------------------------------------------
# 2. User Input
# ------------------------------------------

read -p "Enter your name: " username

echo "Hello, $username!"


# ------------------------------------------
# 3. Command Substitution
# ------------------------------------------

current_date=$(date)

echo "Current date and time: $current_date"


# ------------------------------------------
# 4. Arithmetic Operations
# ------------------------------------------

num1=10
num2=5

sum=$((num1 + num2))
difference=$((num1 - num2))
product=$((num1 * num2))
division=$((num1 / num2))

echo "Sum: $sum"
echo "Difference: $difference"
echo "Product: $product"
echo "Division: $division"


# ------------------------------------------
# 5. Conditional Statements
# ------------------------------------------

number=10

if [ $number -gt 5 ]; then
    echo "$number is greater than 5"
else
    echo "$number is not greater than 5"
fi


# ------------------------------------------
# 6. String Comparison
# ------------------------------------------

user="admin"

if [ "$user" = "admin" ]; then
    echo "Welcome, Admin!"
else
    echo "Welcome, User!"
fi


# ------------------------------------------
# 7. File Checking
# ------------------------------------------

file="bash_fundamentals.sh"

if [ -f "$file" ]; then
    echo "$file exists."
else
    echo "$file does not exist."
fi


# ------------------------------------------
# 8. For Loop
# ------------------------------------------

echo "For Loop:"

for i in 1 2 3 4 5
do
    echo "Number: $i"
done


# ------------------------------------------
# 9. While Loop
# ------------------------------------------

counter=1

echo "While Loop:"

while [ $counter -le 5 ]
do
    echo "Counter: $counter"
    ((counter++))
done


# ------------------------------------------
# 10. Functions
# ------------------------------------------

greet() {
    echo "Hello from the Bash function!"
}

greet


# Function with argument

welcome() {
    echo "Welcome, $1!"
}

welcome "Kumail"


# ------------------------------------------
# 11. Arrays
# ------------------------------------------

fruits=("Apple" "Banana" "Mango" "Orange")

echo "First fruit: ${fruits[0]}"

echo "All fruits: ${fruits[@]}"


# ------------------------------------------
# 12. Case Statement
# ------------------------------------------

choice="start"

case $choice in
    start)
        echo "Starting the program..."
        ;;
    stop)
        echo "Stopping the program..."
        ;;
    *)
        echo "Invalid option."
        ;;
esac


# ------------------------------------------
# 13. Command-Line Arguments
# ------------------------------------------

echo "Script name: $0"
echo "First argument: $1"
echo "Second argument: $2"


# ------------------------------------------
# 14. Exit Status
# ------------------------------------------

echo "Testing exit status..."

ls /tmp

if [ $? -eq 0 ]; then
    echo "Command executed successfully."
else
    echo "Command failed."
fi


# ------------------------------------------
# End
# ------------------------------------------

echo "===== Bash Fundamentals Completed ====="