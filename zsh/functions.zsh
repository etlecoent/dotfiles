# Utility Functions

# Quick find file
ff() {
    find . -type f -name "*$1*"
}

# Quick find directory
fd() {
    find . -type d -name "*$1*"
}
