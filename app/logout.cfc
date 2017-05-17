component
	output = false
	hint = "I terminate the current session."
	{

	any function init(  ) {

		StructClear(SESSION);
		SessionInvalidate();
		SessionRotate();
		SESSION.userGuid = "";
		SESSION.isLoggedIn = false;

		return( this );

	}

	// ---
	// PUBLIC METHODS.
	// ---

	// I return the SESSION Guid value.
	public string function getGuid(  ) {

		var guid = SESSION.userGuid;

		return( guid );

	}

	// I return the SESSION IsLoggedIn value.
	public string function getIsLoggedIn(  ) {

		var isLoggedIn = SESSION.isLoggedIn;

		return( isLoggedIn );

	}

	// ---
	// PRIVATE METHODS.
	// ---

}