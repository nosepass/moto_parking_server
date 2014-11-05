APP_ROOT = File.expand_path(File.dirname(File.dirname(__FILE__)))
 
worker_processes 4
working_directory APP_ROOT
 
preload_app true
 
timeout 30
 
listen "/tmp/unicorn.parking.sock", :backlog => 64
 
pid APP_ROOT + "/unicorn.pid"
 
stderr_path APP_ROOT + "/log/unicorn.stderr.log"
stdout_path APP_ROOT + "/log/unicorn.stdout.log"
 
before_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
 
  old_pid = APP_ROOT + '/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
  begin
    Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts "Old master alerady dead"
    end
  end
end
 
after_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end