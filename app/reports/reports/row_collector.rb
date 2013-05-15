module Reports
  class RowCollector
    class CollectedReport
      attr_reader :header_row, :rows

      def initialize
        @header_row = nil
        @rows       = []
      end

      def <<(row)
        if header_row
          rows << row
        else
          @header_row = row
        end
      end
    end

    attr_reader :report

    def initialize(report)
      @report = report
    end

    def collect_rows
      collector = CollectedReport.new
      report.generate(collector)
      collector
    end
  end
end
