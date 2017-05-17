<!--- Validate input --->
<cfparam name="form.inputUsername" type="string" default=""/>
<cfparam name="form.inputPassword" type="string" default=""/>

<!--- Check credentials --->
<cfscript>
	login = createObject("component", "login").init(form.inputUsername, form.inputPassword);
	json = login.checkCredentials();
</cfscript>

<!--- Output the response --->
<cfoutput>
	#json#
</cfoutput>
