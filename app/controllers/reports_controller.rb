class ReportsController < ApplicationController
  def index
  end

  def all_invoices
    report = Reports::AllInvoices.new
    collect_report(report)
  end

  def deadbeats
    report = Reports::Deadbeats.new
    collect_report(report)
  end

  def revenue_per_month
    report = Reports::RevenuePerMonth.new
    collect_report(report)
  end

private

  def collect_report(report)
    @report = Reports::RowCollector.new(report).collect_rows
  end
end
