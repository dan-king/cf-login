<cfcomponent displayname="login" hint="This component acts as login engine.">

	<cffunction name="init" returntype="login" output="No" hint="Pseudo-constructor">
		<cfargument name="inputUsername" type="string" required="No" default="">
		<cfargument name="inputPassword" type="string" required="No" default="">

		<cfscript>
			this.userName = inputUsername;
			this.userPassword = inputPassword;

			// Hash passwords several iterarions
			this.hashIterarions = 1659;

		</cfscript>

		<cfreturn this/>
	</cffunction>


	<cffunction name="checkCredentials" displayname="checkCredentials" hint="Returns a JSON object with the result of the credential check." returntype="string" access="public" output="No" >

			<!--- Init response variables --->
			<cfset var status = ""/>
			<cfset var message = ""/>
			<cfset var userGuid = ""/>
			<cfset var json = ""/>

			<cftry>

				<!--- Query user record by userName --->
				<cfscript>
					ORMReload();
					users = entityLoad( "user", { username: this.userName } ) ;
					userJson = serializeJSON( users );
				</cfscript>

				<cfif ArrayLen(users) neq 1>
					<!--- Fail: User record does not exist. --->
					<cfset status = "fail"/>
					<cfset message = "Incorrect login."/>
				<cfelse>
					<!--- Get the user object --->
					<cfset user = users[1]>

					<!--- Get the user's password salt. --->
					<cfset passwordSalt = user.getPasswordSalt()>

					<!--- Hash the password input with the user's password salt. --->
					<cfset saltedPasswordInput = Hash(this.userPassword & passwordSalt, "SHA-512", "utf-8", this.hashIterarions)>

					<!--- Compre with hashed password in database --->
					<cfset userHashedPassword = user.getHashedPassword()>

					<cfif saltedPasswordInput eq userHashedPassword>

						<!--- Finally, make sure the user account is not disabled. --->
						<cfset userAccountDisabled = user.getAccountDisabled()>

						<cfif userAccountDisabled>
							<!--- Fail! Correct login and password but user account is disabled. --->
							<cfset status = "fail"/>
							<cfset message = "Your credentials are correct but your account is disabled. Please contact your administrator for details on how to reactivate your account."/>
						<cfelse>
							<!--- Success! Correct login and password. --->
							<cfset status = "pass"/>
							<cfset message = "Login successful."/>
						</cfif>

						<!--- Extract the userGuid to include with the response. --->
						<cfset userGuid = user.getuserGuid()>

						<!--- Launch new session --->
						<cfset SessionRotate() />
						<cfset SESSION.userGuid = userGuid/>
						<cfset SESSION.isLoggedIn = true/>
					<cfelse>
						<!--- Fail. Wrong password. --->
						<cfset status = "fail"/>
						<cfset message = "Incorrect Login."/>
					</cfif>
				</cfif>

				<cfcatch type="any">
					<cfset status = "fail"/>
					<cfset message = "MESSAGE: " & cfcatch.message & " - DETAIL: " & cfcatch.detail/>
				</cfcatch>
			</cftry>

			<!--- Prepare response --->
			<cfscript>
				response = structNew();
				structInsert(response,"this.userName",this.userName);
				structInsert(response,"status",status);
				structInsert(response,"message",message);
				structInsert(response,"userGuid",userGuid);
			</cfscript>

			<!--- Convert resonse to JSON format --->
			<cfset json = serializeJSON(response)>

		<cfreturn json>
	</cffunction>


</cfcomponent>
