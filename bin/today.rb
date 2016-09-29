#!/usr/bin/env ruby

require 'date'
require 'pry'
# Checks homebrew and bundle for updates
module Today
  class CLI

    DCS_LOCATION = "$HOME/Dev/dcs/dcs-manager".freeze
    UPDATED_AT = %(#{ENV["DOTFILES_PATH"]}/tmp/today_last_updated.txt)

    def initialize
      updated_at = DateTime.strptime(IO.read(UPDATED_AT))
      @updated_hours_ago = ((updated_at - DateTime.now) * 24)
    end

    def run
      unless @updated_hours_ago < 3
        puts "\nChecking updates...\n"
        @homebrew_outdated = homebrew_outdated
        @dcs_bundle_outdated = dcs_bundle_outdated

        @homebrew_outdated ? homebrew_outdated_output : "Homebrew up-to-date"
        @dcs_bundle_outdated ? dcs_bundle_outdated_output : "DCS up-to-date"
        puts "\n"

        touch
      end
    end

    private

    def dcs_bundle_outdated
      `#{DCS_LOCATION}/bin/bundle outdated --parseable`
    end

    def dcs_bundle_outdated_output
      puts "##########\n"
      puts "DCS Bundle\n"
      puts "##########"
      puts @dcs_bundle_outdated
    end

    def homebrew_outdated
      `brew outdated --verbose`
    end

    def homebrew_outdated_output
      puts "########\n"
      puts "Homebrew"
      puts "########\n\n"
      puts @homebrew_outdated
      puts "\n"
    end

    def touch
      IO.write(UPDATED_AT, DateTime.now())
    end
  end
end

Today::CLI.new(*ARGV).run
