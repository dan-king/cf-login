var checkLoginFields = function (inputUsername, inputPassword) {
	// Enable the login button as soon as text is entered in both the username and password fields.
	var disableLoginButton;
	if ( inputUsername !== '' && inputPassword !== '') {
		// Both form fields have values. Do not disable the login button.
		disableLoginButton = false;
	} else {
		// One or borh form fields are empty. Disable the login button.
		disableLoginButton = true;
	}
	return disableLoginButton;
}

//
// Export modules 
//
module.exports.checkLoginFields = checkLoginFields;

