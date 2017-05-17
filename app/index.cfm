<!doctype html>
<html>
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Sample login/logout page">
    <meta name="author" content="Dan King">
    <link rel="icon" href="./favicon.ico">
	<title>Hello World Login/Logout</title>

	<!-- Toastr CSS -->
	<link rel='stylesheet' type='text/css' href='./cdn/toastr-2.1.2/toastr.min.css'/>

	<!-- Bootstrap CSS -->
	<link rel='stylesheet' type='text/css' href='./cdn/Bootstrap-3.3.5/css/bootstrap.css'/>

	<!-- jQuery JS-->
	<script type='text/javascript' src='./cdn/jQuery-2.1.4/jquery-2.1.4.js'></script>

	<!-- Toastr JS -->
	<script type='text/javascript' src='./cdn/toastr-2.1.2/toastr.min.js'></script>

	<!-- Bootstrap JS -->
	<script type='text/javascript' src='./cdn/Bootstrap-3.3.5/js/bootstrap.js'></script>

	<!-- Font-Awsesome CSS -->
	<link rel='stylesheet' href='./cdn/font-awesome-4.7.0/css/font-awesome.css' type='text/css' />

    <!-- Custom styles for this template -->
    <link href="styles.css" rel="stylesheet">

	<!-- Client-side login helper functions -->
	<script type='text/javascript' src='./login.js'></script>

</head>
<body>

   <div id="loginContainer" class="container">

      <form class="form-signin">
        <h2 class="form-signin-heading"><i class="fa fa-lock" aria-hidden="true"></i>&nbsp;<span id="loginMessage">Please sign in</span></h2>
        <label for="inputUsername" class="sr-only">Username</label>
        <input type="email" id="inputUsername" class="form-control" placeholder="Username" required autofocus>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" id="inputPassword" class="form-control" placeholder="Password" required>
        <button class="btn btn-lg btn-primary btn-block" type="button" id="loginbutton">Login</button>
      </form>

    </div> <!-- /loginContainer -->

   <div id="logoutContainer" class="container">

      <form class="form-signout">
        <h2 class="form-signout-heading"><i class="fa fa-star" aria-hidden="true"></i>&nbsp;You are in!</h2>
        <button class="btn btn-lg btn-danger btn-block" type="button" id="logoutbutton">Logout</button>
      </form>

    </div> <!-- /logoutContainer -->

<hr/>

<script>
$(document).ready(function(){
	// Init with login button disabled
	resetLoginForm();

	// Init with logout hidden
	$("#logoutContainer").hide();

	// Monitor keyup on form fields to enable "Login" button
	$(document).on('keyup', '#inputUsername', function() {
		formKeyUp();
	});
	$(document).on('keyup', '#inputPassword', function() {
		formKeyUp();
	});

});

//
// Enable the login button when both login and password fields have values.
//
function formKeyUp() {
	var inputUsername = $("#inputUsername").val();
	var inputPassword = $("#inputPassword").val();
	var disableLoginButton = checkLoginFields(inputUsername, inputPassword);
	$("#loginbutton").prop("disabled",disableLoginButton);
}

// 
// Process login form when "Login" button is clicked
//
$("#loginbutton").click(function(){
	var inputUsername = $("#inputUsername").val();
	var inputPassword = $("#inputPassword").val();
	$.post("login.cfm", {
			inputUsername:inputUsername,
			inputPassword:inputPassword
		},function(result){

			console.log("result:",result);

			json = $.parseJSON(result);

			var loginSuccess = json.status;

			if (loginSuccess === "pass") {
				toastr.success("You are in!", "Successful login.");
				// Hide the "login" container
				$("#loginContainer").slideUp("slow");

				// Show the "logout" container
				$("#logoutContainer").slideDown("slow");

			} else {
				var message = json.message;
				toastr.error("Please try again.", message);

				// Reset login form.
				resetLoginForm();
				$("#loginMessage").text(message + " Please try again.");
			}
		}
	);
});

// 
// When logout button is clicked reset session and re-display login form.
//
$("#logoutbutton").click(function(){
	// Clear session
	$.post("logout.cfm", {},function(result){

		// Reset login form.
		resetLoginForm();

		// Hide the "logout" container
		$("#logoutContainer").slideUp("slow");

		// Show the "login" container
		$("#loginContainer").slideDown("slow");

		toastr.success("You are logged out!", "Successful logout.");
	});
});

//
// Reset login form on page load, on logout or if the user clears either field.
//
function resetLoginForm() {
	$("#loginbutton").prop("disabled",true);
	$("#inputUsername").val('');
	$("#inputPassword").val('');
	$("#loginMessage").text("Please sign in");
}

</script>

</body>
</html>