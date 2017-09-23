using module .\curtask.psm1
Import-Module .\curtask.psm1 -Force 


$filename="curtask.xml";

$xml=[xml](Get-Content $filename);


# Write-Output ($xml.GetElementsByTagName("TASKLIST")).GetElementsByTagName("GEN_PARAM")


$gen_params=($xml.GetElementsByTagName("TASKLIST")).GetElementsByTagName("GEN_PARAM");

# çÄñ⁄ñºóÒãì

$title="";

$ienum=$gen_params.Get(0).GetEnumerator();
while($ienum.MoveNext()) {
    $data=$ienum.Current;
    $title +=$data.LocalName;
    $title +=" ";
}

Write-Output $title;

$gen_params | foreach -process {
    $gen_param=$_;
    $dataline="";
    $gen_param.ChildNodes |  foreach -process {

    $dataline +=$_.InnerText;
    $dataline +=" ";
    }
    Write-Output $dataline;
}


write-func

$o=[CurTask_GenParam]::New();

