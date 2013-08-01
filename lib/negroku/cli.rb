require 'thor'
require 'rainbow'
require 'highline/import'
require 'negroku/version'

trap('INT') { exit }

module Negroku
  class CLI < Thor
    class_option :version, :type => :boolean, :aliases => "-v"

    def initialize(*)
      super

      # Show the version
      if options[:version]
        puts Negroku::VERSION
        exit 0
      end
    end

  end
end
