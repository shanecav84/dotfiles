#!/usr/bin/env ruby

# Checks homebrew and bundle for updates
module Today
  class CLI

    DCS_LOCATION = "$HOME/Dev/dcs/dcs-manager".freeze

    def dcs_bundle_outdated
      puts "##########\n"
      puts "DCS Bundle\n"
      puts "##########"
      puts `#{DCS_LOCATION}/bin/bundle outdated --parseable`
    end

    def homebrew_outdated
      puts "########\n"
      puts "Homebrew"
      puts "########\n\n"
      printf `brew outdated --verbose`
      puts "\n"
    end

    def run
      homebrew_outdated
      dcs_bundle_outdated
    end
  end
end

puts "\n"
Today::CLI.new(*ARGV).run
