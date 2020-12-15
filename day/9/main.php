<?php

function load_cipher($filename) {
	
	$fd = fopen($filename, "r");
	$bytes = array();

	while($line = trim(fgets($fd)))
		if($line)
			$bytes[] = intval($line);

	fclose($fd);
	return $bytes;
}

function validate_byte($bytes, $offset) {

	$byte = $bytes[$offset];
	$pre = array();
	
	if($offset < 25) {
		for($i = 0; $i < 25; $i++)
			$pre[] = $bytes[$i];
	} else {
		for($i = $offset; $i >= ($offset - 25); $i--)
			$pre[] = $bytes[$i];
	}

	foreach($pre as $n1) {
		foreach($pre as $n2) {
			if($n1 + $n2 == $byte)
				return true;
		}
	}

	return false;
}

function exploit_cipher($bytes, $invalid_byte) {
	
	$nums = array();
	$init = 0;

	while($init <= count($bytes)) {
		for($i = $init; $i < count($bytes); $i++) {
			$nums[] = $bytes[$i];
			$sum = array_sum($nums);
			if($sum == $invalid_byte) {
				return $nums;
			} elseif ($sum > $invalid_byte)
				break;
		}
		$nums = array();
		$init++;
	}

	return null;
}

$bytes = load_cipher("input.txt");
$invalid_byte = 0;

for($i = 25; $i < count($bytes); $i++) {
	if(!validate_byte($bytes, $i)) {
		$invalid_byte = $bytes[$i];
		break;
	}
}

$nums = exploit_cipher($bytes, $invalid_byte);
$lo = PHP_INT_MAX;
$hi = 0;

foreach($nums as $num) {
	if($num > $hi)
		$hi = $num;
	elseif($num < $lo)
		$lo = $num;
}

echo "solution 1: ".$invalid_byte."\n";
echo "solution 2: ".($lo + $hi)."\n";

?>
