<?php
echo "<h1>Debug: File Listing</h1>";
echo "<p>Current Directory: " . getcwd() . "</p>";
echo "<hr>";

$files = scandir('.');
echo "<ul>";
foreach($files as $file) {
    if($file != '.' && $file != '..') {
        $type = is_dir($file) ? "[DIR] " : "[FILE] ";
        echo "<li>" . $type . $file . "</li>";
    }
}
echo "</ul>";

echo "<hr>";
if(file_exists('static')) {
    echo "<h3>✅ 'static' folder FOUND!</h3>";
    echo "Checking contents of static/js...<br>";
    if(is_dir('static/js')) {
        $jsFiles = scandir('static/js');
        foreach($jsFiles as $js) {
             if(strpos($js, '.js') !== false) echo "Found JS: $js <br>";
        }
    } else {
        echo "❌ static/js does not exist";
    }
} else {
    echo "<h3>❌ 'static' folder NOT FOUND</h3>";
    echo "<p>This is likely the problem! Did you extract the zip into a subfolder?</p>";
}
echo "<hr><p>Server Software: " . $_SERVER['SERVER_SOFTWARE'] . "</p>";
?>
