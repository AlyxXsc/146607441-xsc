// Store answers
const answers = {
    "multipleChoice" : ["Pagekite"],
    "freeResponse" : ["ls"]
}

// Check text input and submit answer selection on newline input
function awaitInput() {
    checkSelected();
}

// Check if selected answer matches answer in answer object
function checkAnswer() {
    showResponse();
}

// Modify and display results
function showResponse() {}

// Reset page data and settings to default
function resetDefault() {
    // Hide all responses

    // Reset the graphic of all elements to default
}

// Check answer selected by user
function checkSelection(event, questionType, index) {
    let clicked = event.target.id;
    if (questionType === "multipleChoice") {
        const selected = event.target.id
    }
    else if (questionType === "freeResponse") {
        const qAnswer = answers.freeResponse[index];
    }
}

// Initialize page for trivia session
document.addEventListener("DOMContentLoaded", function() {
    resetDefault();
});