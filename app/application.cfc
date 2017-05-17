<!------------------------------------------------------------------------------------------------------------------------
FEATURE: Application.cfc
CHANGE CONTROL:
25 May 2015 - Created.
-------------------------------------------------------------------------------------------------------------------------->
<cfcomponent displayname="Application" output="true" hint="Handle the login/logout.">

	<!--- Set up the application. --->
	<cfscript>
		this.name = "LoginPage";

		// Enable ORM
		this.ormenabled = true;
		this.datasource = "vcsdata";

		// Session SessionManagement
		this.SessionManagement = true;
		this.SessionTimeout = CreateTimeSpan( 0, 1, 0, 0 );

		// Init Session as logged out with no userGUID value.
		SessionRotate();
		SESSION.userGuid = "";
		SESSION.isLoggedIn = false;

	</cfscript>

	<cfsetting
		requesttimeout="20"
		showdebugoutput="false"
		enablecfoutputonly="false"
	/>

	<cffunction
		name="OnRequest"
		access="public"
		returntype="void"
		output="true"
		hint="Fires after pre page processing is complete.">

		<!--- Define arguments. --->
		<cfargument
			name="TargetPage"
			type="string"
			required="true"
		/>

		<!--- Include the requested page. --->
		<cfinclude template="#ARGUMENTS.TargetPage#" />

		<!--- Return out. --->
		<cfreturn />
	</cffunction>

</cfcomponent>