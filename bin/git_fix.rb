#!/usr/bin/env ruby

# frozen_string_literal: true

require 'tty-prompt'

module Git
  def self.fix(sha)
    `TARGET=$(git rev-parse "#{sha}"); git commit --fixup=$TARGET ${@:2} && EDITOR=true git rebase -i --autostash --autosquash $TARGET^;`
  end

  def self.log
    `git log --format=format:'%h %s'`
  end

  def self.staged
    `git diff --cached`
  end
end

class GitFix
  def self.call
    abort('Nothing is staged. Stage files before fixing.') if Git.staged == ''

    prompt = TTY::Prompt.new
    commits = Git.log.split("\n")
    selected = prompt.
      select('Choose commit to fix', commits, filter: true, per_page: 10).
      match(/^(?<sha>\w*) (?<msg>.*)$/)
    Git.fix(selected[:sha])
  end
end

GitFix.call
