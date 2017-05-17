
# Sample Login/Logout Page in ColdFusion

by Dan King

This code exercise demonstrates the use of ColdFusion and JavaScript to create single-page login/logout workflow.

## CDN

The 'cdn' directory contains JavaScript helper libraries used in the exercise.
- jQuery: interact with DOM objects
- Bootstrap: page layout
- Fontawesome: favicon and site icons
- Toastr: popup messages

## Initial Page Setup

On initial load the login and password form fields and empty and the "Login" button is disabled.

Once values are present for both the login and password the "Login" button becomes enabled.

If the page is reloaded or if the user clears either field the "Login" button revert back to disabled.

## Database

This exercise uses MySQL as the database with four sample user records in 'user' table. see user.sql for the SQL to create and populate the table.

## ORM

The exercise avails of the [ColdFusion Object-Relational Mapping (ORM)] [1] commands to access the database.

## Workflow

When the login button is clicked authentication is performed on the server. If the login and password are correct the login form disappears and a success message title "You are in" appears. A "Logout" button also appears. When the "Logout" button is clicked the ColdFusion session is terminated and the login form reappears.

## No Page Refresh

As per the specifications, the workflow includes no page refreshes. Content is loaded display dynamically based on Ajax calls to the relevant login/logout logic.

## Successful Login

Upon successful login the login form disappears and a success message is displayed in the page. A logout button also appears. Another success popup is display using ToastrJS. The Toastr popup disappears automatically after a few seconds. 

Upon successful login a new ColdFusion session is created and two SESSION variables are set: SESSION.UserGUID (from the database) and SESSION.IsLoggedIn (set to true).

## Unsuccessful Login

There are three reasons a login will be unsuccessful:

1. The username is not in the database
2. The password for the given username is incorrect
3. The user records has value of TRUE in the "Account Disabled" field.

For the first two situations the error message is simply "Login incorrect. Please try again".

For the third situation the error message is "Your credentials are correct but your account is disabled. Please contact your administrator for details on how to reactivate your account."

## Password Salt

Password in the database are salted and hashed. Each user record has a unique salt value so that two users with the same password will have different password values in the database.

## Hashed Password

Passwords and appended with the user's unique salt value and hashed with SHA-216. The hashing logic avails of the ColdFusion hash iterations parameter to hash over 1000 times.

## Logout

When the user clicked the "Logout" button the ColdFusion session variables are cleared and the session is reset. The login form reappears.


## Sample User Credentials

The following are the login and passwords for the sample users:

foo		bar
adam	H3llo.world
bob		H3llo.world
calvin	H3llo.world

Note the user account "bob" is deactivated so entering the correct credentials will result in an error message indicating that the account has been disabled.

## Testing

Front-end JavaScript tests are written in Mocha.js using the Should.js assertion library.

Front-end tests can be run at the command line in the "test-js" directory with the command 'mocha login.spec.js'

Back-end ColdFusion tests are located in the "test-cf" directory are written with the [TinyTest][2] web-based testing tool from [Ben Nadel][3] at [www.bennadel.com][3]

Back-end tests can be run by browsing to the path "test-cf" directory relative to the app root, e.g. http://localhost/exercise/tests-cf/index.cfm

## Database

The exercise was written using a MySQL database on the back-end. The directory "database" contains a SQL file named 'user.sql' for creating and populating the user table.

The exercise uses a datasource named 'vcsdata' which is defined near the top of the Application.cfc.

## Screenshots

The "screenshots" directory contains sample screenshots of the user interface.

[1]: http://help.adobe.com/en_US/ColdFusion/9.0/Developing/WSD628ADC4-A5F7-4079-99E0-FD725BE9B4BD.html
[2]: https://github.com/bennadel/QueryHelper.cfc
[3]: http://www.bennadel.com
