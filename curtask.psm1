
class CurTask_GenParam {
    [int] $taskId;
    [int] $interval;
    [int] $timeout;
}


class CurTask {
    [CurTask_GenParam] $genparm;
}

class CurTaskList {
     [CurTask] $tasklist;
}



function write-func {
    Write-Output "ahaha2";
}

Export-ModuleMember -Function write-func

