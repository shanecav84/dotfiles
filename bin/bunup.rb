#!/usr/bin/env ruby

require 'open3'
require 'ostruct'

# Adds a message with an indicator while performing the given block
# https://en.wikipedia.org/wiki/Throbber
def throb(message, &blk)
  thr = Thread.new do
    glyphs = %w[⡀ ⠄ ⠂ ⠁ ⠂ ⠄].freeze
    glyphs_index = 0
    wave = glyphs.dup
    loop do
      print "#{message} " + wave.join + "\r"
      wave.shift
      glyphs_index = (glyphs_index + 1) % glyphs.length
      wave << glyphs[glyphs_index]
      sleep 0.1
    end
  end

  yield blk
ensure
  Thread.kill(thr)
  print "#{message}...done\r\n"
end

# Updates a single gem using `bundle update` and makes a git commit
# with a useful message, e.g. "rails 4.2.4 (was 4.2.3)".
module Bunup
  class Bundler
    OUTDATED_PATTERN = /(?<gem_name>.*) \(newest (?<newest>.*), installed (?<installed>.*)\)/

    def initialize(gem)
      @gem = gem
    end

    # Expected output format:
    #   "\ngem-name (newest 1.0.0, installed 2.0.0)\n"
    def outdated
      stdout, stderr, status = bundle_outdated
      validate_output(stderr, status)
      stdout.strip
    end

    def update
      stdout, _stderr, _status = bundle_update

      # Bundler might be unable to update the gem, and won't say why.
      if stdout.match?('its version stayed the same')
        abort "ERROR: Bundler was unable to update #{@gem.name} for reasons unknown"
      end
    end

    def bundle_update
      throb "Updating #{@gem.name} #{@gem.installed_version} -> #{@gem.newest_version}" do
        Open3.capture3("bundle update #{@gem.name}")
      end
    end

    private

    def validate_output(stderr, status)
      # `bundler outdated` exits with a 0 status if the gem is up-to-date
      abort 'Gem is up-to-date' if status.success?

      # `bundler outdated` exits with a status of 256 if the gem is out-of-date.
      # If it exits with some other status, print the error and exit with that
      # status
      unless status.to_i == 256
        print "ERROR:\n"
        print "#{stderr}\n"
        exit(status.to_i)
      end
    end

    def bundle_outdated
      throb "Checking for new version of #{@gem.name}" do
        Open3.capture3("bundler outdated --parseable #{@gem.name}")
      end
    end
  end

  class CLI
    MAJOR_VERSION_UPGRADE_WARNING = <<-TEXT
This is a major version upgrade with possible breaking changes.

Are you sure you want to continue? [y/N]
    TEXT
    USAGE = "Usage: bunup.rb gem_name"

    def initialize(*args)
      abort(USAGE) unless args.length == 1
      gem_name = args[0]
      @gem = Gem.new(name: gem_name)
      @bundler = Bundler.new(@gem)
      @git = Git.new(@gem)
    end

    def run
      @gem.installed_version, @gem.newest_version = versions

      prompt_for_major_upgrade if major_version_upgrade

      @bundler.update

      @git.add
      @git.commit

      print "#{@gem.name} updated to #{@gem.newest_version} "\
        "(was #{@gem.installed_version})\n"
    end

    private

    # Gets the highest-level integer of the version string
    # Assumes a three part versioning scheme: major.minor.patch
    def major_version_upgrade
      major_version = ->(version) { version.split('.')[0].to_i }
      major_version.call(@gem.newest_version) >
        major_version.call(@gem.installed_version)
    end

    # A major version upgrade has breaking changes, according to Semantic
    # Versioning (https://semver.org/spec/v2.0.0.html). Let's make sure the user
    # is aware of that.
    def prompt_for_major_upgrade
      print "WARNING: #{@gem.name} is being upgraded from #{@gem.installed_version} " \
        "to #{@gem.newest_version}. " + MAJOR_VERSION_UPGRADE_WARNING.chomp + " "
      abort 'No update performed' unless 'y' == STDIN.gets.chomp.downcase
    end

    def versions
      # Handle errors with capturing version info from output
      match_data = Bundler::OUTDATED_PATTERN.match(@bundler.outdated)
      if match_data.nil?
        abort "ERROR: Unable to determine current version of gem: #{@gem.name}"
      end

      [
        match_data[:installed],
        match_data[:newest]
      ]
    end
  end

  class Gem < OpenStruct
    # Gem name patterns taken from
    # https://github.com/rubygems/rubygems.org/blob/master/lib/patterns.rb
    SPECIAL_CHARACTERS = ".-_"
    ALLOWED_CHARACTERS = "[A-Za-z0-9#{Regexp.escape(SPECIAL_CHARACTERS)}]+"
    NAME_PATTERN       = /\A#{ALLOWED_CHARACTERS}\Z/

    def initialize(*args)
      super
      validate
    end

    def validate
      abort "Invalid gem name: #{name}" unless valid_name?
    end

    private

    def valid_name?
      !!(name =~ NAME_PATTERN)
    end
  end

  class Git
    def initialize(gem)
      @gem = gem
    end

    def add
      `git add Gemfile Gemfile.lock`
    end

    def commit
      `git commit -m "#{message}"`
    end

    def message
      format '%s %s (was %s)',
        @gem.name,
        @gem.newest_version,
        @gem.installed_version
    end
  end
end

Bunup::CLI.new(*ARGV).run
