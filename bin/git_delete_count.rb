#!/usr/bin/env ruby
# frozen_string_literal: true

require 'colorize'

module GitDeleteCount
  class Git
    def self.local_branch
      `git rev-parse --abbrev-ref HEAD`.chomp
    end

    def self.numstat
      `git diff --numstat #{local_branch} #{remote_branch}`
    end

    def self.remote_branch
      `git rev-parse --abbrev-ref #{local_branch}@{upstream}`.chomp
    end
  end

  class Controller
    NUMSTAT_REGEX = /(?<deletions>\d+)\s+(?<additions>\d+).*/

    def parse_numstat
      Git.numstat.split("\n").map { |line| line.match(NUMSTAT_REGEX) }.compact
    end

    def delete_count
      numstat = parse_numstat
      armor = numstat.map { |stat| stat[:additions].to_i }.sum
      hit = numstat.map { |stat| stat[:deletions].to_i }.sum
      damage = hit - armor
      if damage.positive?
        punc = damage <= 37 ? '.' : '!'
        print "Your #{damage_string(damage)} coding #{hit_string(damage)} the line count#{punc}\n".colorize(:red)
      end
    end

    def damage_string(damage)
      if damage <= 0
        ''
      elsif damage <= 4
        'pathetic'
      elsif damage <= 8
        'pitiful'
      elsif damage <= 12
        'feeble'
      elsif damage <= 15
        'weak'
      elsif damage <= 18
        'paltry'
      elsif damage <= 22
        'inadequate'
      elsif damage <= 25
        'mediocre'
      elsif damage <= 31
        ''
      elsif damage <= 37
        'average'
      elsif damage <= 45
        'telling'
      elsif damage <= 52
        'strong'
      elsif damage <= 61
        'POTENT'
      elsif damage <= 75
        'FORCEFUL'
      elsif damage <= 85
        'POWERFUL'
      elsif damage <= 95
        'FIERCE'
      elsif damage <= 110
        '** VICIOUS **'
      elsif damage <= 125
        '*** BRUTAL ***'
      elsif damage <= 140
        '*** MIGHTY ***'
      elsif damage <= 160
        '=== FEARSOME ==='
      elsif damage <= 180
        '=== FEROCIOUS ==='
      elsif damage <= 220
        '>>> FORMIDABLE <<<'
      elsif damage <= 260
        '<<< TREMENDOUS >>>'
      elsif damage <= 320
        '))) HEROIC ((('
      elsif damage <= 400
        ']]] TITANIC [[['
      else
        '### GODLIKE ###'
      end
    end

    def hit_string(damage)
      if damage <= 1
        'barely scratches'
      elsif damage <= 2
        'scratches'
      elsif damage <= 4
        'grazes'
      elsif damage <= 8
        'hurts'
      elsif damage <= 12
        'hits'
      elsif damage <= 16
        'injures'
      elsif damage <= 22
        'wounds'
      elsif damage <= 30
        'damages'
      elsif damage <= 40
        'harms'
      elsif damage <= 52
        'tears into'
      elsif damage <= 66
        'rends'
      elsif damage <= 81
        'mauls'
      elsif damage <= 97
        'savages'
      elsif damage <= 114
        'mutilates'
      elsif damage <= 140
        'maims'
      elsif damage <= 180
        'mangles'
      elsif damage <= 220
        'devastates'
      elsif damage <= 280
        'dismembers'
      elsif damage <= 240
        'ravages'
      elsif damage <= 400
        'sunders'
      elsif damage <= 600
        'kills'
      elsif damage <= 800
        'slays'
      elsif damage <= 1600
        'butchers'
      elsif damage <= 2400
        'slaughters'
      elsif damage <= 3200
        'exterminates'
      elsif damage <= 4000
        'destroys'
      elsif damage <= 8000
        'utterly destroys'
      elsif damage <= 12_000
        'annihilates'
      elsif damage <= 20_000
        'eradicates'
      else
        'obliterates'
      end
    end
  end
end

::GitDeleteCount::Controller.new.delete_count
