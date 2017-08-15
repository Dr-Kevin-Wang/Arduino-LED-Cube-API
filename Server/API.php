<?php
	session_start();
	
	$user = "root";
	$pass = "UnitedPolaris";
	$pdo = new PDO('mysql:host=localhost;dbname=cube', $user, $pass);
	
	$x = $_POST["x"];
	$y = $_POST["y"];
	$z = $_POST["z"];
	$state = $_POST["state"];
	$stmt = $pdo->prepare("
		UPDATE onoff
		SET onoff = '$state'
		WHERE x = '$x' AND y = '$y' AND z = '$z'");
	$stmt->execute();
	
	$file = fopen("arduino.txt", "w");
	$txt = "$x$y$z$state\n";
	fwrite($file, $txt);
	fclose($file);
?>