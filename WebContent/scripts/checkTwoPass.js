// JavaScript Document
//check if two pass is the same


function check(input) {
	if (input.value != document.getElementById('password').value) {
		input.setCustomValidity('Οι δύο κωδικοί πρέπει να ταιρίαζουν.');
	} else {
		// input is valid -- reset the error message
		input.setCustomValidity('');
   }
}
