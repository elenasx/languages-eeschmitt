// Function to calculate the caesar cipher and change the letters.
// Only works for letters A-Z, not symbols.
function cipher(str, shift){
    return str.split('').map(char =>{
        if(char.match(/[a-z]/i)){
            const code = char.charCodeAt();
            const base = (char === char.toLowerCase()) ? 97:65;
            return String.fromCharCode(((code - base + shift) % 26) + base);
        }
        return char;
    }).join('');
}

// Gets the input from the html input and returns the result to webpage.
document.getElementById('encrypt').addEventListener('click', function(){
    const text = document.getElementById('text').value;
    const shift = parseInt(document.getElementById('shift').value, 10);
    const encryption_res = cipher(text, shift);
    document.getElementById('result').textContent = encryption_res;
});