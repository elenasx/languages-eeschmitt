Logic Programming

Use the github pages feature to publish a simple web site with HTML and CSS in the docs folder of your languages repository.  It does not have to have a working back-end component.  Turn in a link to your web site and a link to the chat you had developing the pages.  For example,

https://chatgpt.com/share/66e45abd-d7f0-8009-8b17-aa9c07d401c5

and (only the public/ components are needed for the front-end):

https://wmacevoy.github.io/languages-wmacevoy/mortgage-calculator/index.html

You can see the content in my languages-wmacevoy repository under the docs folder.


\
ChatGPT:\
I want to create a simple webpage application that takes in text input and returns a caesar cipher of the input text (only letters a-z, no symbols). Can you show me what the js would look like given the html?

Response:
Certainly! Below is a simple JavaScript implementation for a Caesar cipher that you can use with your provided HTML. The code captures the text input, applies the Caesar cipher using the specified shift value, and then displays the result.

```js
function caesarCipher(str, shift) {
    return str.split('').map(char => {
        if (char.match(/[a-z]/i)) {
            const code = char.charCodeAt();
            const base = (char === char.toLowerCase()) ? 97 : 65;
            return String.fromCharCode(((code - base + shift) % 26) + base);
        }
        return char; // Non-alphabetic characters are not changed
    }).join('');
}

document.getElementById('encrypt').addEventListener('click', function() {
    const textInput = document.getElementById('text').value;
    const shiftInput = parseInt(document.getElementById('shift').value, 10);
    const encryptedText = caesarCipher(textInput, shiftInput);
    document.getElementById('result').textContent = encryptedText;
});
```
Explanation:
1. Event Listener: When the "Encrypt" button is clicked, it triggers the function that gets the input text and shift value.
2. Caesar Cipher Function:
    * It iterates through each character of the input text.
    * It checks if the character is a letter (using a regex).
    * It calculates the new character by shifting its position based on the ASCII value.
    * Non-letter characters are added to the result unchanged.
3. Display Result: The encrypted text is displayed in the designated result area.

Usage:
* Make sure you include the above JavaScript in a file named script.js.
* When you open the HTML file in a browser, you can enter text and a shift value, and clicking the "Encrypt" button will show the encrypted text using the Caesar cipher.