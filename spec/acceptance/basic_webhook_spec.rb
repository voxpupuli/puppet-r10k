require 'spec_helper_acceptance'

describe 'basic webhook' do

 context 'default parameters' do
    let(:pp) {"
      class { 'r10k':
        remote => 'git@github.com:someuser/puppet.git',
      }
      class {'r10k::webhook::config':
        enable_ssl      => false,
        protected       => false,
        use_mcollective => false,
        notify     => Service['webhook'],
      }
      
      class {'r10k::webhook':
        require => Class['r10k::webhook::config'],
      }
    "}
    it 'should apply with no errors' do
      apply_manifest(pp, :catch_failures=>true)
    end
    it 'should be idempotent' do
      apply_manifest(pp, :catch_changes=>true)
    end
  end

end
