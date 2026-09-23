#!/bin/bash

# ==========================================
# Number Guessing Game
# ==========================================

echo "=============================="
echo "     Number Guessing Game"
echo "=============================="

# Generate a random number between 1 and 100
secret_number=$((RANDOM % 100 + 1))

attempts=0

while true
do
    read -p "Guess a number between 1 and 100: " guess

    # Check if input is a number
    if ! [[ "$guess" =~ ^[0-9]+$ ]]; then
        echo "Please enter a valid number."
        continue
    fi

    ((attempts++))

    if [ "$guess" -lt "$secret_number" ]; then
        echo "Too low! Try again."

    elif [ "$guess" -gt "$secret_number" ]; then
        echo "Too high! Try again."

    else
        echo ""
        echo "🎉 Congratulations!"
        echo "You guessed the correct number: $secret_number"
        echo "Number of attempts: $attempts"
        break
    fi
done
