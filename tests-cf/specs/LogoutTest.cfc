component
	extends = "TestCase"
	output = false
	hint = "I test the Logout component."
	{


	// --- 
	// LIFECYCLE METHODS.
	// ---


	// I get called before each test method.
	public void function setup() {

		logoutHelper = new app.logout(  );

	}


	// I get called after each test method.
	public void function teardown() {
		
		// ...

	}


	// ---
	// TEST METHODS.
	// ---


	public void function testThatLogoutCanBeInitialized() {

		var logoutHelper = new app.logout();

	}


	public void function testThatGuidEmptyAfterLogout() {

		var guid = logoutHelper.getGuid(  );

		assert( guid == "" );

	}

	public void function testThatIsLoggedOutFalseAfterLogout() {

		var isLoggedIn = logoutHelper.getIsLoggedIn(  );

		assert( isLoggedIn == false );

	}


	// ---
	// PRIVATE METHODS.
	// ---





}