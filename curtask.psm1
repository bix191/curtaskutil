
class CurTask_GenParam {
}


class CurTask {
    [int] $taskId;
    [int] $interval;
    [int] $timeout;
    CurTask([int] $taskId,[int] $interval,[int] $timeout) {
        $this.taskId = $taskId;
        $this.interval = $interval;
        $this.timeout = $timeout;
    }
}
class CurTaskTcp : CurTask {
    [string] $hostname;
    [int] $port;
    CurTaskTcp([int] $taskId,[int] $interval,[int] $timeout,[string] $hostname,[int] $port) :
        CurTask($taskId,$interval,$timeout)    {
        $this.hostname=$hostname;
        $this.port=$port;
    }
}


class CurTaskList {
     [CurTask[]] $tasklist;
     addTask([CurTask] $obj) {
     }
}



function write-func {
    Write-Output "ahaha3";
}

Export-ModuleMember -Function write-func
# Export-ModuleMember -Class CurTask_GenParam

