require 'open3'
require 'climate_control'
require 'timeout'
load File.expand_path(File.join('..','..', 'bin', 'yq'), __FILE__)

describe 'bin/yq' do
  # Contract Or[nil,String] => self
  def run_bin(args = "")
    status = nil
    output = ""
    cmd = "bin/yq #{args}"
    Open3.popen2e(cmd) do |i, oe, t|
      begin
        pid = t.pid
        Timeout.timeout(0.5) do
          oe.each { |v|
            output << v
          }
        end
      rescue Timeout::Error => e
        LOGGER.warn "Timing out #{t.inspect} after 1 second"
        Process.kill(15, pid)
      ensure
        status = t.value
      end
    end
    [output, status]
  end

  required_vars = %w[
  ]

  before do
    required_vars.each do |v|
      ClimateControl.env[v] = v.downcase
    end
  end

  required_vars.map do |v|
    it "dies unless given ENV[#{v}]" do
      ClimateControl.env[v] = nil
      out_err, status = run_bin
      expect(out_err).to match(/#{v} must be specified/)
      expect(status).to_not be_success
    end
  end

  it 'supplies help' do
    out_err, status = run_bin("--help")
    expect(out_err).to match(/Usage: yq/)
    expect(status).to be_success
  end
end
