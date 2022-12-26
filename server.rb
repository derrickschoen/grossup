require "sinatra"
require "json"
require "income-tax"

before { content_type :json }

get "/" do
  { song: "Wake me Up" }.to_json
end

get "/grossup/:country/:net_income/:state" do
  tax_info =
    IncomeTax.new(
      params[:country],
      params[:net_income],
      :net,
      state: params[:state]
    )

  _gross = tax_info.gross_income.round() # => 59020
  _net = tax_info.net_income.round() # => 48000
  _rate = tax_info.rate.round(4) * 100 # => "18.67"

  { gross_income: _gross, net_income: _net, tax_rate: _rate }.to_json
end
