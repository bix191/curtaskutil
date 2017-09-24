

class CurTask {
    [int] $taskId;
    [string] $taskLabel;
    [int] $interval;
    [int] $timeout;
    CurTask([int] $taskId,[string] $taskLabel,[int] $interval,[int] $timeout) {
        $this.taskId = $taskId;
        $this.taskLabel = $taskLabel;
        $this.interval = $interval;
        $this.timeout = $timeout;
    }
}
class CurTaskTcp : CurTask {
    [string] $hostname;
    [int] $port;
    CurTaskTcp([int] $taskId,[string] $taskLabel,[int] $interval,[int] $timeout,[string] $hostname,[int] $port) : base($taskId,$taskLabel,$interval,$timeout)    {
        $this.hostname=$hostname;
        $this.port=$port;
    }
}

class CurTaskList {
    [CurTask[]] $tasklist;
    addTask([CurTask] $obj) {
        $this.tasklist+=$obj;
    }
    parseXml([string] $xmlfilename) {
        $xml=[xml](Get-Content -Encoding UTF8 $xmlfilename);
        $xml.GetElementsByTagName("TASK") | foreach -process {
            [int] $taskId;
            [string] $taskLabel;
            [int] $interval;
            [int] $timeout;
            
            [string] $hostname;
            [int] $port;
            [CurTaskTcp] $taskTcp;
            
            $task=$_;
            $task.ChildNodes.GetEnumerator()  |  foreach -process {
                if ($_.LocalName.CompareTo("GEN_PARAM")-eq 0) {
                    $gen_params = $_;
                    $gen_params.ChildNodes.GetEnumerator()  |  foreach -process {
                        $gen_param=$_; 
                        if ($gen_param.LocalName.CompareTo("TASKID") -eq 0) {
                            $taskId = $gen_param.InnerText;
                        } elseif ($gen_param.LocalName.CompareTo("TASKLABEL") -eq 0) {
                            $taskLabel = $gen_param.InnerText;
                        } elseif ($gen_param.LocalName.CompareTo("INTERVAL") -eq 0) {
                            $interval = $gen_param.InnerText;
                        } elseif ($gen_param.LocalName.CompareTo("TIMEOUT") -eq 0) {
                            $timeout = $gen_param.InnerText;
                        }
                    }
                } elseif ($_.LocalName.CompareTo("SERV_PARAM") -eq 0) {
                    $serv_params = $_;
                    $serv_params.ChildNodes.GetEnumerator()  |  foreach -process {
                        if ($_.LocalName.CompareTo("TCP") -eq 0) {
                            $tcp_params = $_;
                            $tcp_params.ChildNodes.GetEnumerator()  |  foreach -process {
                                $tcp_param = $_;
                                if ($tcp_param.LocalName.CompareTo("HOSTNAME") -eq 0) {
                                    $hostname = $tcp_param.InnerText;
                                } elseif ($tcp_param.LocalName.CompareTo("PORT") -eq 0) {
                                    $port = $tcp_param.InnerText;
                                }
                            }
                        }
                    }
                    $taskTcp = [CurTaskTcp]::new($taskId,$taskLabel,$interval,$timeout,
                                                $hostname,$port);
                    $this.addTask($taskTcp);
                }
            }
        }
    }
}



function write-func {
    Write-Output "ahaha3";
}

Export-ModuleMember -Function write-func
# Export-ModuleMember -Class CurTask_GenParam

