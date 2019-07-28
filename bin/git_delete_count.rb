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
      case
      when damage <= 0 then ''
      when damage <= 4 then 'pathetic'
      when damage <= 8 then 'pitiful'
      when damage <= 12 then 'feeble'
      when damage <= 15 then 'weak'
      when damage <= 18 then 'paltry'
      when damage <= 22 then 'inadequate'
      when damage <= 25 then 'mediocre'
      when damage <= 31 then ''
      when damage <= 37 then 'average'
      when damage <= 45 then 'telling'
      when damage <= 52 then 'strong'
      when damage <= 61 then 'POTENT'
      when damage <= 75 then 'FORCEFUL'
      when damage <= 85 then 'POWERFUL'
      when damage <= 95 then 'FIERCE'
      when damage <= 110 then '** VICIOUS **'
      when damage <= 125 then '*** BRUTAL ***'
      when damage <= 140 then '*** MIGHTY ***'
      when damage <= 160 then '=== FEARSOME ==='
      when damage <= 180 then '=== FEROCIOUS ==='
      when damage <= 220 then '>>> FORMIDABLE <<<'
      when damage <= 260 then '<<< TREMENDOUS >>>'
      when damage <= 320 then '))) HEROIC ((('
      when damage <= 400 then ']]] TITANIC [[['
      else
        '### GODLIKE ###'
      end
    end

    def hit_string(damage)
      case
      when damage <= 1 then 'barely scratches'
      when damage <= 2 then 'scratches'
      when damage <= 4 then 'grazes'
      when damage <= 8 then 'hurts'
      when damage <= 12 then 'hits'
      when damage <= 16 then 'injures'
      when damage <= 22 then 'wounds'
      when damage <= 30 then 'damages'
      when damage <= 40 then 'harms'
      when damage <= 52 then 'tears into'
      when damage <= 66 then 'rends'
      when damage <= 81 then 'mauls'
      when damage <= 97 then 'savages'
      when damage <= 114 then 'mutilates'
      when damage <= 140 then 'maims'
      when damage <= 180 then 'mangles'
      when damage <= 220 then 'devastates'
      when damage <= 280 then 'dismembers'
      when damage <= 240 then 'ravages'
      when damage <= 400 then 'sunders'
      when damage <= 600 then 'kills'
      when damage <= 800 then 'slays'
      when damage <= 1600 then 'butchers'
      when damage <= 2400 then 'slaughters'
      when damage <= 3200 then 'exterminates'
      when damage <= 4000 then 'destroys'
      when damage <= 8000 then 'utterly destroys'
      when damage <= 12_000 then 'annihilates'
      when damage <= 20_000 then 'eradicates'
      else
        'obliterates'
      end
    end
  end
end

::GitDeleteCount::Controller.new.delete_count
