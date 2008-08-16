require File.expand_path(__FILE__ + '/../../spec_helper')
require File.expand_path(File.dirname(__FILE__) + "/../../../lib/selenium/rspec/reporting/system_capture")

describe "System Capture" do

  it "Retrieves remote control logs on local file system when no session is started" do
    FileUtils.rm_rf "/tmp/selenium_ruby_client"
    example  = stub('example',:implementation_backtrace => [ "a line" ])
    strategy = Selenium::RSpec::Reporting::FilePathStrategy.new "/tmp/selenium_ruby_client/test_report.html"
    class << strategy
      def example_hash(example)
        123
      end
    end
    system_capture = Selenium::RSpec::Reporting::SystemCapture.new selenium_driver, example, strategy
    system_capture.retrieve_remote_control_logs
    
    File.exists?("/tmp/selenium_ruby_client/resources/test_report/example_123_remote_control.log").should be_true
  end

  it "Retrieves remote control logs on local file system when there is a session" do
    selenium_driver.start_new_browser_session
    
    FileUtils.rm_rf "/tmp/selenium_ruby_client"
    example  = stub('example',:implementation_backtrace => [ "a line" ])
    strategy = Selenium::RSpec::Reporting::FilePathStrategy.new "/tmp/selenium_ruby_client/test_report.html"
    class << strategy
      def example_hash(example)
        123
      end
    end
    system_capture = Selenium::RSpec::Reporting::SystemCapture.new selenium_driver, example, strategy
    system_capture.retrieve_remote_control_logs
    
    File.exists?("/tmp/selenium_ruby_client/resources/test_report/example_123_remote_control.log").should be_true
  end

  it "Retrieving HTML Snapshot should not bomb when there is no session" do
    example  = stub('example',:implementation_backtrace => [ "a line" ])
    strategy = Selenium::RSpec::Reporting::FilePathStrategy.new "/tmp/selenium_ruby_client/test_report.html"
    system_capture = Selenium::RSpec::Reporting::SystemCapture.new selenium_driver, example, strategy
    system_capture.capture_html_snapshot
  end

  it "Retrieves HTML Snapshots on local file system when session is started" do
    selenium_driver.start_new_browser_session

    FileUtils.rm_rf "/tmp/selenium_ruby_client"
    example  = stub('example',:implementation_backtrace => [ "a line" ])
    strategy = Selenium::RSpec::Reporting::FilePathStrategy.new "/tmp/selenium_ruby_client/test_report.html"
    class << strategy
      def example_hash(example)
        123
      end
    end
    system_capture = Selenium::RSpec::Reporting::SystemCapture.new selenium_driver, example, strategy
    system_capture.capture_html_snapshot
    
    File.exists?("/tmp/selenium_ruby_client/resources/test_report/example_123.html").should be_true
  end
  
end