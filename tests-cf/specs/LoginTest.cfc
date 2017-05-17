component
	extends = "TestCase"
	output = false
	hint = "I test the Login component."
	{


	// --- 
	// LIFECYCLE METHODS.
	// ---


	// I get called before each test method.
	public void function setup() {

		loginHelper = new app.login(  );

	}


	// I get called after each test method.
	public void function teardown() {
		
		// ...

	}


	// ---
	// TEST METHODS.
	// ---


	public void function testThatLogoutCanBeInitialized() {

		var loginHelper = new app.login();

	}


	public void function testThatInvalidLoginFails() {

		var invalidLogin = "bogus";
		var invalidPassword = "bogus";

		var login = loginHelper.init(invalidLogin, invalidPassword);
		var json = login.checkCredentials();

		assert( json == '{"message":"Incorrect login.","status":"fail","userGuid":""}' );

	}

	public void function testThatValidLoginSucceeds() {

		var validLogin = "foo";
		var validPassword = "bar";

		var login = loginHelper.init(validLogin, validPassword);
		var json = login.checkCredentials();

		assert( json == '{"this.userName":"foo","message":"Login successful.","status":"pass","userGuid":"1EBE3657-3FAF-4449-8092-3182B9F42DDE"}' );

	}


	// ---
	// PRIVATE METHODS.
	// ---


}