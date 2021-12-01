<?php
$file = "input.txt";
$input = file($file);

echo sizeof($input)."\n";
$counter = 0;

for ($i = 1; $i < sizeof($input); $i++){
    if ($input[$i] > $input[$i-1])
    {
        $counter = $counter + 1;
    }
    
}

echo "Answer Task 1: {$counter} \n";

$counter = 0;
for ($i = 3; $i < sizeof($input); $i++){

    if ($input[$i] > $input[$i-3])
    {
        $counter = $counter + 1;
    }
    
}

echo "Answer Task 2: {$counter} \n";

?>