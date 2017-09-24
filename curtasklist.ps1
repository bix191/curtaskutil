using module .\curtask.psm1
Import-Module .\curtask.psm1 -Force 


$filename="curtask.xml";


$tasklist=[CurTaskList]::New();
$tasklist.parseXml("$filename");


$tasklist.tasklist.GetEnumerator() 
