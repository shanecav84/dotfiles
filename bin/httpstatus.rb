#!/usr/bin/env ruby

require 'net/http'
require 'nokogiri'
require 'reverse_markdown'

class HttpStatus
  def initialize
    @status_code = ARGV[0]
    @article = load_article
    @reverse = reverse
    format_status_category
    format_status_code
    if format_message.nil?
      raise "format_message didn't work"
    end
    IO.popen("less -R", "w") { |f| f.puts @reverse }
  end

  private

  def format_status_code
    h1 = @reverse.match(/^# \d\d\d.*/)[0]
    @reverse.sub!(/^#.*/, "\033[1m\033[97m\033[105m#{h1}")
  end

  def format_status_category
    h2 = @reverse.match(/^(?:##).*/)[0]
    @reverse.sub!(/^##.*/, "\033[1m\033[90m\033[47m#{h2}\033[0m")
  end

  def format_message
    message = @reverse.match(/(?:^.*105m# \d\d\d.*\n\n)(.*)/)[1]
    @reverse.sub!(/^.*105m(# \d\d\d.*)\n\n.*/, "\1#{message}\033[0m")
  end

  def headers
    {
      "User-Agent" => "statusrun/0.0.1a (https://github.com/patientdev/statusrun)"
    }
  end

  def reverse
    ::ReverseMarkdown.convert @article
  end

  def load_article
    url = format('https://httpstatuses.com/%s', @status_code)
    uri = ::URI.parse(url)
    req = ::Net::HTTP::Get.new(uri.to_s, headers)
    res = ::Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(req)
    end
    text = ::Nokogiri::HTML(res.body).at('article[@class="code container"]')
    text.at('h1:nth-of-type(2)').xpath('following-sibling::*').remove
    text.at('h1:nth-of-type(2)').remove
    text
  end
end

HttpStatus.new