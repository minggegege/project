require 'timeout'

require_relative 'gitlab_config'
require_relative 'gitlab_logger'
require_relative 'gitlab_metrics'

class GitlabKeys
  class KeyError < StandardError ; end

  attr_accessor :auth_file, :key

  def self.command(key_id)
    raise KeyError.new("Invalid key_id: #{key_id.inspect}") unless /\A[a-z0-9-]+\z/ =~ key_id
    "#{ROOT_PATH}/bin/gitlab-shell #{key_id}"
  end

  def self.key_line(key_id, public_key)
    public_key.chomp!
    raise KeyError.new("Invalid public_key: #{public_key.inspect}") if public_key.include?("\n")
    "command=\"#{command(key_id)}\",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty #{public_key}"
  end

  def initialize
    @command = ARGV.shift
    @key_id = ARGV.shift
    key = ARGV.shift
    @key = key.dup if key
    @auth_file = GitlabConfig.new.auth_file
  end

  def exec
    GitlabMetrics.measure("command-#{@command}") do
      case @command
      when 'add-key';
        add_key
      when 'batch-add-keys';
        batch_add_keys
      when 'rm-key';
        rm_key
      when 'list-keys';
        list_keys
      when 'list-key-ids';
        list_key_ids
      when 'clear';
        clear
      when 'check-permissions';
        check_permissions
      else
        $logger.warn "Attempt to execute invalid gitlab-keys command #{@command.inspect}."
        puts 'not allowed'
        false
      end
    end
  end

  protected

  def add_key
    lock do
      $logger.info "Adding key #{@key_id} => #{@key.inspect}"
      auth_line = self.class.key_line(@key_id, @key)
      open_auth_file('a') { |file| file.puts(auth_line) }
    end
    true
  end

  def list_keys
    $logger.info 'Listing all keys'
    keys = ''
    File.readlines(auth_file).each do |line|
      # key_id & public_key
      # command=".../bin/gitlab-shell key-741" ... ssh-rsa AAAAB3NzaDAxx2E\n
      #                               ^^^^^^^              ^^^^^^^^^^^^^^^
      matches = /^command=\".+?\s+(.+?)\".+?(?:ssh|ecdsa)-.*?\s(.+)\s*.*\n*$/.match(line)
      keys << "#{matches[1]} #{matches[2]}\n" unless matches.nil?
    end
    keys
  end

  def list_key_ids
    $logger.info 'Listing all key IDs'
    open_auth_file('r') do |f|
      f.each_line do |line|
        matchd = line.match(/key-(\d+)/)
        next unless matchd
        puts matchd[1]
      end
    end
  end

  def batch_add_keys
    lock(300) do # Allow 300 seconds (5 minutes) for batch_add_keys
      open_auth_file('a') do |file|
        stdin.each_line do |input|
          tokens = input.strip.split("\t")
          abort("#{$0}: invalid input #{input.inspect}") unless tokens.count == 2
          key_id, public_key = tokens
          $logger.info "Adding key #{key_id} => #{public_key.inspect}"
          file.puts(self.class.key_line(key_id, public_key))
        end
      end
    end
    true
  end

  def stdin
    $stdin
  end

  def rm_key
    lock do
      $logger.info "Removing key #{@key_id}"
      open_auth_file('r+') do |f|
        while line = f.gets do
          next unless line.start_with?("command=\"#{self.class.command(@key_id)}\"")
          f.seek(-line.length, IO::SEEK_CUR)
          # Overwrite the line with #'s. Because the 'line' variable contains
          # a terminating '\n', we write line.length - 1 '#' characters.
          f.write('#' * (line.length - 1))
        end
      end
    end
    true
  end

  def clear
    open_auth_file('w') { |file| file.puts '# Managed by gitlab-shell' }
    true
  end

  def check_permissions
    open_auth_file(File::RDWR | File::CREAT) { true }
  rescue => ex
    puts "error: could not open #{auth_file}: #{ex}"
    if File.exist?(auth_file)
      system('ls', '-l', auth_file)
    else
      # Maybe the parent directory is not writable?
      system('ls', '-ld', File.dirname(auth_file))
    end
    false
  end

  def lock(timeout = 10)
    File.open(lock_file, "w+") do |f|
      begin
        f.flock File::LOCK_EX
        Timeout::timeout(timeout) { yield }
      ensure
        f.flock File::LOCK_UN
      end
    end
  end

  def lock_file
    @lock_file ||= auth_file + '.lock'
  end

  def open_auth_file(mode)
    open(auth_file, mode, 0600) do |file|
      file.chmod(0600)
      yield file
    end
  end
end
