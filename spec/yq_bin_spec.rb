require 'open3'
require 'climate_control'
require 'timeout'

describe 'bin/yq' do
  # Contract Or[nil,String] => self
  def run_bin(args = "", input = nil)
    status = nil
    output = ""
    cmd = "bin/yq #{args}"
    Open3.popen2e(cmd) do |i, oe, t|
      begin
        pid = t.pid

        if input
          i.puts input
          i.close
        end

        Timeout.timeout(0.5) do
          oe.each { |v|
            output << v
          }
        end
      rescue Timeout::Error
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

  describe 'parses' do
    let(:query) { 'foo.bar' }
    let(:yaml) { <<-EOF }
foo:
  bar:
    baz: value
EOF

    it 'foo.bar' do
      out_err, status = run_bin(query, yaml)
      expect(out_err).to match('baz: value')
      expect(status).to be_success
    end
  end
end
