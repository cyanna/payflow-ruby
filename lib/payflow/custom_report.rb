module Payflow
  ## 
  # Basic custom report support.  Inputs could be expanded through documentation available at 
  # https://cms.paypal.com/cms_content/GB/en_GB/files/developer/PP_Reporting_Guide.pdf
  class CustomReport < Report
    def create_report(start_date, end_date)
      xml = Builder::XmlMarkup.new
      xml.tag! 'runReportRequest' do
        xml.tag! 'reportName', 'CustomReport'

        [
          {name: 'start_date', value: date_string(start_date)},
          {name: 'end_date', value: date_string(end_date)}
        ].each do |param|
          xml.tag! 'reportParam' do
            xml.tag! 'paramName', param[:name]
            xml.tag! 'paramValue', param[:value]
          end
        end
      end

      response = commit(xml.target!)
      @report_id = response.report_id if response.successful?
      response
    end

  end
end