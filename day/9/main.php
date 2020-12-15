<?php

function load_cipher_chunks($filename) {
	
	$fd = fopen($filename, "r");
	$bytes = array();

	while($line = trim(fgets($fd)))
		if($line)
			$bytes[] = intval($line);

	fclose($fd);
	return array_chunk($bytes, 25);
}

function validate_chunk($preamble, $chunk) {

	$used = array();
	
	foreach($chunk as $byte) {
		$used[$byte] = array();
		foreach($preamble as $p1) {
			foreach($preamble as $p2) {
				if($p1 + $p2 == $byte)
					$used[$byte][] = $p1." + ".$p2;
			}
		}
	}

	return $used;
}

$chunks = load_cipher_chunks("input.txt");
$used = validate_chunk($chunks[0], $chunks[1]);

foreach($used as $list) {
	foreach($list as $sum)
		echo $sum."\n";
	echo "\n";
}


?>
