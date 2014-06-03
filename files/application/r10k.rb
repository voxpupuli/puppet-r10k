class MCollective::Application::R10k<MCollective::Application
  def post_option_parser(configuration)
    if ARGV.length >= 1
      configuration[:command] = ARGV.shift
      case configuration[:command]
      when 'push','pull','status'
        configuration[:path] = ARGV.shift || docs
      when 'deploy'
        configuration[:environment] = ARGV.shift || docs
      end
  else
      docs
    end
  end

  def docs
    puts "Usage: #{$0} push | pull | status | deploy"
  end

  def main
    mc = rpcclient("r10k", :chomp => true)
    options = {:path => configuration[:path]} if ['push','pull','status'].include? configuration[:command]
    options = {:environment => configuration[:environment]} if ['deploy'].include? configuration[:command]
    mc.send(configuration[:command], options).each do |resp|
      puts "#{resp[:sender]}:"
      if resp[:statuscode] == 0
        responses = resp[:data][:output]
        puts responses if responses and ['push','pull','status','deploy'].include? configuration[:command]
      else
        puts resp[:statusmsg]
      end
    end
    mc.disconnect
    printrpcstats
  end
end
