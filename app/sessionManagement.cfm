<!------------------------------------------------------------------------------------------------------------------------
FEATURE: sessionManagement.cfm
CHANGE CONTROL:
25 June 2015 - Created.
-------------------------------------------------------------------------------------------------------------------------->

<!---
	Set default variables.
--->

<cfset loginMessage = "Please login">
<cfparam name="url.loginName" type="string" default=""/>
<cfset loginName = url.loginName>


<!---
	This cflogin block only get executed if the user is NOT logged in
--->
<cflogin>


	<!---
		See if form values just submitted. If so then check against database.
		If not sent the show form and halt
	--->
	<cfif isDefined("form.loginName") and isDefined("form.loginPassword")>

		<!--- Set login DSN --->
		<cfinclude template="./login_admin/set_dsn.cfm"/>


		<!--- Hardcode values until we get rid of all these hardcoded users. --->

		<cfset SESSION.user_company_id = 2>
		<cfset SESSION.user_company_name = "Diageo">
		<cfset SESSION.user_customer_id = 2>
		<cfset SESSION.user_customer_name = "Diageo">

		<cfset SESSION.user_login = form.loginName>
		<cfset SESSION.user_email = "email">

		<!---
			Contractor Developers 
		--->
		<cfif form.loginName eq "nicola" and form.loginPassword eq "nyc123">
			<cfloginuser name="Nicola Viviano" password="#form.loginPassword#" roles="System Administrator">

			<cfset SESSION.user_firstname = "Nicola">
			<cfset SESSION.user_lastname = "Viviano">
			<cfset SESSION.user_role = "System Administrator">
			<cfset SESSION.user_id = 1001>
			<cfset SESSION.user_company_id = 4>
			<cfset SESSION.user_company_name = "Viewpoint Computer Services">

			<cfset log_login("#form.loginName#","pass","#variables.dsn#")/>

		<cfelseif form.loginName eq "dan" and form.loginPassword eq "acorn">
			<cfloginuser name="Dan King" password="#form.loginPassword#" roles="System Administrator">

			<cfset SESSION.user_firstname = "Dan">
			<cfset SESSION.user_lastname = "King">
			<cfset SESSION.user_role = "System Administrator">
			<cfset SESSION.user_id = 1002>
			<cfset SESSION.user_company_id = 4>
			<cfset SESSION.user_company_name = "Viewpoint Computer Services">
			<!--- 
			<cfset SESSION.user_customer_id = 1>
			<cfset SESSION.user_customer_name = "Demo Company">
			 --->

			<cfset log_login("#form.loginName#","pass","#variables.dsn#")/>


		<cfelse>

			<!--- Query users table to see if the record exists. --->
			<cfquery name="query" datasource="#variables.dsn#" result="queryResult" maxrows="1">
				SELECT 
					users.*,
					companies.company_name,
					customers.customer_name 
				FROM 
					users,
					companies,
					customers
				WHERE
					users.company_id = companies.id
						AND
					users.customer_id = customers.id
						AND
					users.user_login = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.loginName#">
			</cfquery>

			<cfif query.recordCount eq 0 >
				<cfset loginName = form.loginName>
				<cfset loginMessage = "No such login. Please try again.">
				<cfset log_login("#form.loginName#","fail","#variables.dsn#")/>
			<cfelse>
				<!--- See if the password matches the record --->
				<cfif form.loginPassword neq query.user_password>
					<cfset loginName = form.loginName>
					<cfset loginMessage = "Incorrect password. Please try again.">
					<cfset log_login("#form.loginName#","fail","#variables.dsn#")/>

				<cfelse>

					<!--- Set some session variables --->
					<cfset SESSION.user_login = query.user_login>
					<cfset SESSION.user_firstname = query.user_firstname>
					<cfset SESSION.user_lastname = query.user_lastname>
					<cfset SESSION.user_email = query.user_email>
					<cfset SESSION.user_role = query.user_role>
					<cfset SESSION.user_id = query.id>
					<cfset SESSION.user_company_id = query.company_id>
					<cfset SESSION.user_company_name = query.company_name>
					<cfset SESSION.user_customer_id = query.customer_id>
					<cfset SESSION.user_customer_name = query.customer_name>

					<cfloginuser name="#query.user_firstname# #query.user_lastname#" password="#form.loginPassword#" roles="#query.user_role#">

					<cfset log_login("#form.loginName#","fail","#variables.dsn#")/>

				</cfif>
			</cfif>
		</cfif>
	</cfif>

</cflogin>


<!---
	Some actions at this point
	- cfabort if not logged in
	- show login form if not logged in
	- checklogin if form submitted
	-
	- display settings if logged in
--->


<!---
	Show login form and halt processing if not logged in at this point
--->
<cfif !isUserLoggedIn()>

	<img src="../resources/images/sp-cp-logo.png">

	<cfoutput>
		<h2>#loginMessage#</h2>
	</cfoutput>

	<cfform action="#cgi.script_name#?#cgi.query_string#" name="LoginForm" method="post">
		<table>
			<tr>
				<td align="right">
					Login:
				</td>
				<td>
					<cfinput type="text" name="loginName" value="#loginName#" required="yes" message="Please enter your login name" maxlength="100" size="40">
				</td>
			</tr>
			<tr>
				<td align="right">
					Password:
				</td>
				<td>
					<cfinput type="password" name="loginPassword" required="yes" message="Please enter your password" size="40">
				</td>
			</tr>
			<tr>
				<td align="right">
					&nbsp;
				</td>
				<td>
					<input type="Submit" value="Go">
				</td>
			</tr>
		<table>
	</cfform>

	<cfabort>
</cfif>


<cffunction name="log_login" output="true" returntype="void">
	<cfargument name="login_name" type="string" required="true"/>
	<cfargument name="status" type="string" required="true"/>
	<cfargument name="dsn" type="string" required="true"/>

	<cfset var query = ""/>
	<cfset var ip = CGI.REMOTE_ADDR/>
<!--- 

	<cfquery name="query" datasource="#dsn#">
		INSERT INTO login_history  ( 
			login_name,
			status,
			ip_address
		) 
		VALUES 
		(
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#login_name#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#status#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#ip#">
		)

	</cfquery>
 --->



	<cfreturn/>
</cffunction>
