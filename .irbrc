begin
  if RUBY_VERSION < '1.9.0'
    $KCODE='u'
  end

  require 'irb/completion'
  ARGV.concat ['--readline', '--prompt-mode', 'simple']

  require 'pp'

  require 'irb/ext/save-history'
  IRB.conf[:SAVE_HISTORY] = 100
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
rescue Object => e
  STDERR.puts "Fail to initialize irb. #{e.inspect}"
end

begin
  require 'rubygems'
  require 'wirb'
  Wirb.start
rescue LoadError
  STDERR.puts 'Fail to load wirb gem.'
end

# vim:ft=ruby
