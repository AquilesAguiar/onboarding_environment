defmodule CadProductsPhoenix.Tracerer.ManuallyTraced do
  alias CadProductsPhoenix.Tracerer.Tracer
  require Spandex

  def trace_me() do
    Tracer.start_trace("my_trace")
    Tracer.update_span(service: :cad_products_phoenix, type: :db)

    result = span_me()

    Tracer.finish_trace()

    result
  end

  def span_me() do
    Tracer.start_span("this_span")
    Tracer.update_span(service: :cad_products_phoenix, type: :web)

    result = span_me_also()

    Tracer.finish_span()
  end

  def span_me_also() do
    Tracer.span "span_me_also" do
      ...
    end
  end
end
