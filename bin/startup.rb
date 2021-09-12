#!/usr/bin/env ruby
# frozen_string_literal: true

lib = File.join(File.dirname(File.expand_path(__FILE__)), "..", "lib")
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rubygems'
require 'bundler/setup'

require 'microservice'

bind_port = (ENV['PORT'] && ENV['PORT'].to_i) || 3001
bind_address = "0.0.0.0"

bind = "#{bind_address}:#{bind_port}"
server_args = {
  'grpc.max_receive_message_length' => (256) * 1024 * 1024,
  'grpc.max_send_message_length' => (256) * 1024 * 1024,
}
server = GRPC::RpcServer.new(
  server_args: server_args
  # pool_size: env_default('THREAD_POOL_SIZE', 5),
  # max_waiting_requests: env_default('MAX_WAITING_REQUESTS', 10),
  # poll_period: env_default('POLL_PERIOD', 10),
  # connect_md_proc: nil,
)
server.add_http2_port(bind, :this_port_is_insecure)
server.handle(MicroService::Handler.new)

# Runs the server with SIGHUP, SIGINT and SIGQUIT signal handlers to
#   gracefully shutdown.
# User could also choose to run server via call to run_till_terminated
server.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'], 5)
