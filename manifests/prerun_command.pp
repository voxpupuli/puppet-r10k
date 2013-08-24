# This class will configure r10k to run as part of the masters agent run
class r10k::prerun_command (
  $command = 'r10k synchronize'
){
  augeas{'puppet.conf prerun_command' :
    context       => '/files//puppet.conf/agent',
    changes       => "set prerun_command 'r10k synchronize'",
  }
}
