
#!/bin/bash

# ==========================================
# PROJECT 03: LINUX PASSWORD GENERATOR
# ==========================================

echo "========================================"
echo "          PASSWORD GENERATOR"
echo "========================================"

# 1. Ask the user for password length
read -r -p "Enter password length (12-16): " length

# 2. Validate the input
if [[ ! "$length" =~ ^[0-9]+$ ]]; then
    echo "Error: Please enter a valid number."
    exit 1
fi

if (( length < 12 || length > 16 )); then
    echo "Error: Password length must be between 12 and 16."
    exit 1
fi
lowercase='abcdefghijklmnopqrstuvwxyz'
uppercase='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
numbers='0123456789'
symbols='!@#$%^&*()_+=-'

password_chars=()

password_chars+=("$(LC_ALL=C tr -dc "$lowercase" < /dev/urandom | head -c 1)")
password_chars+=("$(LC_ALL=C tr -dc "$uppercase" < /dev/urandom | head -c 1)")
password_chars+=("$(LC_ALL=C tr -dc "$numbers" < /dev/urandom | head -c 1)")
password_chars+=("$(LC_ALL=C tr -dc "$symbols" < /dev/urandom | head -c 1)")

all_characters="${lowercase}${uppercase}${numbers}${symbols}"

remaining=$((length - 4))

for ((i=0; i<remaining; i++)); do
    random_char=$(LC_ALL=C tr -dc "$all_characters" < /dev/urandom | head -c 1)
    password_chars+=("$random_char")
done
# 7. Shuffle the characters
password=$(printf '%s\n' "${password_chars[@]}" | shuf | tr -d '\n')

# 8. Display the password
echo ""
echo "========================================"
echo "       PASSWORD GENERATED"
echo "========================================"

echo "Password: $password"
echo "Length: ${#password}"

echo "========================================"
