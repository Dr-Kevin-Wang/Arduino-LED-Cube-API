<?php
	session_start();
	//Connect to db
	$user = "root";
	$pass = "pw";
	$pdo = new PDO('mysql:host=localhost;dbname=cube', $user, $pass);
	
	//Read from POST request
	$x = $_POST["x"];
	$y = $_POST["y"];
	$z = $_POST["z"];
	$state = $_POST["state"];
	//Write to DB
	$stmt = $pdo->prepare("
		UPDATE onoff
		SET onoff = '$state'
		WHERE x = '$x' AND y = '$y' AND z = '$z'");
	$stmt->execute();
	
	//Write to TXT file
	$file = fopen("arduino.txt", "w");
	$txt = "$x$y$z$state\n";
	fwrite($file, $txt);
	fclose($file);
?>
