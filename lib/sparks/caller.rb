
module Sparks
  extend self

  SPARKS_IGNORE_CALLERS = [
    %r{lib/sparks.*$},
    %r{minitest}
  ] unless defined?(SPARKS_IGNORE_CALLERS)


  def first_caller
    Sparks.call_stack.first
  end

  def call_stack
    caller(1).
      map     { |line| line.split(/:/).first }.
      reject  { |file,line| SPARKS_IGNORE_CALLERS.any? { |pattern| file =~ pattern } }.
      map { |file, line| file }
  end
end
