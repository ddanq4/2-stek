
require "charscounter"
require "rspec"


RSpec.describe Charscounter do
  it "проверяет подсчет символов в строке hello" do
    result = Charscounter.charscounter("hello")
    puts result
    expect(result).to eq({"h" => 1, "e" => 1, "l" => 2, "o" => 1})
  end
end
