<?php
	$user = "root";
	$pass = "UnitedPolaris";
	$pdo = new PDO('mysql:host=localhost;dbname=cube', $user, $pass);
	$q = $pdo->prepare("
		UPDATE onoff
		SET onoff = '0'
		");
	$q->execute();
?>