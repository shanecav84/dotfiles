#! /usr/bin/env ruby

require 'csv'
require 'tempfile'

module YNAB
  class CSVImporter
    YNAB_HEADERS = %w[Date Payee Category Memo Outflow Inflow].freeze
    CSV_OPTIONS = { headers: YNAB_HEADERS, write_headers: true }.freeze

    def initialize(file_path)
      abort 'Give me a file path' unless file_path
      @file_path = file_path
      raise Errno::ENOENT unless File.exist?(@file_path)
    end

    def perform
      ::Tempfile.create(['ynab', '.csv']) do |file|
        ::CSV.open(file.path, 'w', CSV_OPTIONS) do |csv|
          ::CSV.foreach(@file_path, headers: true) do |row|
            transaction = parse_transaction(row)

            amount = parse_amount(row['amount'])
            if amount.negative?
              transaction.append(amount.abs, '')
            else
              transaction.append('', amount)
            end

            csv << transaction
          end
        end

        `open -a 'YNAB 4' #{file.path}`
      end
      File.delete(@file_path)
    end

    private

    # Negative numbers are contained in parentheses. We detect the parentheses,
    # and return the bare number.
    def parse_amount(amount)
      float = amount.match(/\d.*\.\d\d/).to_s.to_f
      amount = amount.start_with?('(') && amount.end_with?(')') ? (0 - float) : float
    end

    def parse_transaction(row)
      [
        row['date'],
        row['description'],
        row['category'],
        row['memo']
      ]
    end
  end
end

YNAB::CSVImporter.new(ARGV[0]).perform
