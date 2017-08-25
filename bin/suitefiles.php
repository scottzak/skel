<?php
// This program prints out a list of files associated with a behat suite.
// The program output can be used on the command-line to open all files in
// a capable editor, such as vim or emacs.

$projectRoot = getenv('SLS_PROJECT_ROOT');

if (isset($argv[1])) {

}

$ymlstr = preg_replace('/%paths.base%/', "$projectRoot/behat", file_get_contents("$projectRoot/behat/behat.yml"));
// print($behatyml);
$data = yaml_parse($ymlstr);

$files = array();
array_push($files, "behat.yml");

if (isset($argv[1])) {
  $suite = $data['default']['suites'][$argv[1]];
  foreach ($suite['paths'] as $fn) {
    array_push($files, $fn);
  }

  # print("\$contexts: " . print_r($suite['contexts'], TRUE) . "\n");
  foreach ($suite['contexts'] as $context) {

    if (is_array($context)) {
      $class = array_keys($context)[0];
    } else {
      $class = $context;
    }
    $f = "$projectRoot/behat/features/bootstrap/$class.php";

    array_push($files, $f);
    $output = shell_exec("grep require_once $f");
    $lines = explode("\n", $output);
    foreach($lines as $line) {
      // print($line);
      $fstr = preg_replace("/require_once '/", '', $line);
      $fstr = preg_replace("/';/", '', $fstr);
      if (file_exists($fstr)) {
        array_push($files, $f);
      }
    }
  }
}

array_push($files, "$projectRoot/behat/features/bootstrap/cscu/Env.php");
print(join(' ', $files));
