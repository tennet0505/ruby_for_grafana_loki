# frozen_string_literal: true
require 'json'
require 'net/http'

module RubyForGrafanaLoki
  class InterceptingLogger < Logger
    attr_accessor :client

    SEVERITY_NAMES = %w(DEBUG INFO WARN ERROR FATAL).freeze

    def initialize(intercept_logs: false)
      @intercept_logs = intercept_logs
      @log = ""
      self.level = Logger::DEBUG
    end

    def add(severity, message = nil, progname = nil, &block)

      severity_name = severity_name(severity)
      log_message = message || (block&.call)

      @log = format_message(severity_name, Time.now, progname, log_message)

      if @intercept_logs
        client.send_log(@log) if client
      end
      super(severity, message, progname, &block)
    end

    def broadcast_to(console)
      client.send_log(@log) if client
    end

    private

    def format_message(severity, datetime, progname, msg)
      "#{severity} #{progname}: #{msg}\n"
    end

    def severity_name(severity)
      SEVERITY_NAMES[severity] || "UNKNOWN"
    end
  end
end
