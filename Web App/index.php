<?php
	$user = "root";
	$pass = "UnitedPolaris";
	$pdo = new PDO('mysql:host=localhost;dbname=cube', $user, $pass);
	$count = 1;
?>
<html>
	<head>
		<style>
			@import url('https://fonts.googleapis.com/css?family=Roboto');
			h1 {
				font-family: 'Roboto', sans-serif;
				text-align: center;
			}
			div {
				text-align: center;
			}
			.switch {
			  position: relative;
			  display: inline-block;
			  width: 60px;
			  height: 34px;
			}

			.switch input {display:none;}
			
			.slider {
			  position: absolute;
			  cursor: pointer;
			  top: 0;
			  left: 0;
			  right: 0;
			  bottom: 0;
			  background-color: #ccc;
			  -webkit-transition: .4s;
			  transition: .4s;
			}
			
			.slider:before {
			  position: absolute;
			  content: "";
			  height: 26px;
			  width: 26px;
			  left: 4px;
			  bottom: 4px;
			  background-color: white;
			  -webkit-transition: .4s;
			  transition: .4s;
			}
			
			input:checked + .slider {
			  background-color: #2196F3;
			}
			
			input:focus + .slider {
			  box-shadow: 0 0 1px #2196F3;
			}
			
			input:checked + .slider:before {
			  -webkit-transform: translateX(26px);
			  -ms-transform: translateX(26px);
			  transform: translateX(26px);
			}

			.slider.round {
			  border-radius: 34px;
			}
			
			.slider.round:before {
			  border-radius: 50%;
			}
		</style>
	</head>
	<body>
	<div>
		<h1>Lower Layer</h1>
		<?php
			for ($y = 0; $y < 4; $y++)
			{
				for ($x = 0; $x < 4; $x++)
				{
					$onoff = "0";
					$stmt = $pdo->query("
					SELECT `onoff` FROM `onoff` WHERE x = '$x' AND y = '$y' AND z = '0'");
					$onoff = $stmt->fetchColumn();
					?>
		<label class="switch">
		<input id="<?php echo $count; $count++;?>" type="checkbox" data-x="<?php echo($x);?>" data-y="<?php echo($y);?>" data-z="0" <?php if($onoff == "1"){echo("checked='checked'");}?> onclick="switched(this.id);"> 
		<span class="slider round"></span>
		</label><?php if($x == 3) {echo "<br>";}?>
					<?php
				}
			}
		?>
	</div>
	<div>
		<h1>Second Layer</h1>
		<?php
			for ($y = 0; $y < 4; $y++)
			{
				for ($x = 0; $x < 4; $x++)
				{
					$onoff = "0";
					$stmt = $pdo->query("
					SELECT `onoff` FROM `onoff` WHERE x = '$x' AND y = '$y' AND z = '1'");
					$onoff = $stmt->fetchColumn();
					?>
		<label class="switch">
		<input id="<?php echo $count; $count++;?>" type="checkbox" data-x="<?php echo($x);?>" data-y="<?php echo($y);?>" data-z="1" <?php if($onoff == "1"){echo("checked='checked'");}?> onclick="switched(this.id);">  
		<span class="slider round"></span>
		</label><?php if($x == 3) {echo "<br>";}?>
					<?php
				}
			}
		?>
	</div>
		
	<div>
		<h1>Third Layer</h1>
		<?php
			for ($y = 0; $y < 4; $y++)
			{
				for ($x = 0; $x < 4; $x++)
				{
					$onoff = "0";
					$stmt = $pdo->query("
					SELECT `onoff` FROM `onoff` WHERE x = '$x' AND y = '$y' AND z = '2'");
					$onoff = $stmt->fetchColumn();
					?>
		<label class="switch">
		<input id="<?php echo $count; $count++;?>" type="checkbox" data-x="<?php echo($x);?>" data-y="<?php echo($y);?>" data-z="2" <?php if($onoff == "1"){echo("checked='checked'");}?> onclick="switched(this.id);"> 
		<span class="slider round"></span>
		</label><?php if($x == 3) {echo "<br>";}?>
					<?php
				}
			}
		?>
	</div>
		
	<div>
		<h1>Top Layer</h1>
			<?php
			for ($y = 0; $y < 4; $y++)
			{
				for ($x = 0; $x < 4; $x++)
				{
					$onoff = "0";
					$stmt = $pdo->query("
					SELECT `onoff` FROM `onoff` WHERE x = '$x' AND y = '$y' AND z = '3'");
					$onoff = $stmt->fetchColumn();
					?>
		<label class="switch">
		<input id="<?php echo $count; $count++;?>" type="checkbox" data-x="<?php echo($x);?>" data-y="<?php echo($y);?>" data-z="3" <?php if($onoff == "1"){echo("checked='checked'");}?> onclick="switched(this.id);"> 
		<span class="slider round"></span>
		</label><?php if($x == 3) {echo "<br>";}?>
					<?php
				}
			}
			?>
	</div>
	<script>
		function switched(id) {
			var state = 0;
			if($("#" + id).prop('checked')) 
			{
				state = 1;
			}
			else 
			{
				state = 0;
			}
			var x = $("#" + id).data("x");
			var y = $("#" + id).data("y");
			var z = $("#" + id).data("z");
			$.post(
				"processing.php",
				{
					x: x,
					y: y,
					z: z, 
					state: state
				}
			);
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
	</body>
</html>