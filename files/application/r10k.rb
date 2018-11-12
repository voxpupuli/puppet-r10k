class MCollective::Application::R10k<MCollective::Application
  description 'R10K interface for MCO'

  usage <<-END_OF_USAGE
mco r10k <ACTION> <ARGUMENTS>
Usage: mco r10k <push|pull|status|deploy|deploy_module|generate_types>

The ACTION can be one of the following:

    push            - Git push a module
    pull            - Git pull a module
    status          - Git status of a module
    deploy          - Deploy a specific environment, and its Puppetfile specified modules
    deploy_module   - Deploy a specific module
    generate_types  - Generate metadata file of resource types

END_OF_USAGE

  def post_option_parser(configuration)
    if ARGV.length >= 1
      configuration[:command] = ARGV.shift
      case configuration[:command]
      when 'push','pull','status'
        configuration[:path] = ARGV.shift || docs
      when 'deploy', 'generate_types'
        configuration[:environment] = ARGV.shift || docs
      when 'deploy_module'
        configuration[:module_name] = ARGV.shift || docs
      end
    else
      docs
    end
  end

  def docs
    puts "Usage: #{$0} push | pull | status | deploy | deploy_module | generate_types"
  end

  def main
    mc = rpcclient("r10k", :chomp => true)
    options = {:path => configuration[:path]} if ['push','pull','status']
      .include? configuration[:command]
    options = {:environment => configuration[:environment]} if [
      'deploy', 'generate_types'
    ].include? configuration[:command]
    options = {:module_name => configuration[:module_name]} if ['deploy_module'].include? configuration[:command]
    mc.send(configuration[:command], options).each do |resp|
      puts "#{resp[:sender]}:"
      if resp[:statuscode] == 0
        responses = resp[:data][:output]
        puts responses if responses and [
          'push','pull','status','deploy','deploy_module', 'generate_types'
        ].include? configuration[:command]
      else
        puts resp[:statusmsg]
      end
    end
    mc.disconnect
    printrpcstats
  end
end
