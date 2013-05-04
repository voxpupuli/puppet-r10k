class r10k::prerun_command {
  augeas{'puppet.conf prerun_command' :
    context       => '/files//puppet.conf/agent',
    changes       => "set prerun_command 'r10k synchronize'",
  }
}
