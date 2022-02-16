defmodule CadProductsPhoenixWeb.Jobs.CreateReportJob do
  alias CadProductsPhoenix.Services.CsvReport
  alias CadProductsPhoenix.Services.MailerService

  def perform(path) do
    CsvReport.generate_report(path)
    MailerService.send_body_email()
  end
end
