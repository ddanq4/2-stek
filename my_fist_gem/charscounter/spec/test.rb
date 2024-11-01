require "charscounter"
require "rspec"

RSpec.describe Charscounter do
  it "рахує символи" do
    result = Charscounter.charscounter("asjhdgajdyryryryrnsdjcvbvhsdgtfv][ad")
    puts result
    expect(result).to eq({ "a" => 4, "s" => 4, "j" => 4, "h" => 3, "d" => 5, "g" => 3, "y" => 6, "r" => 5, "n" => 1, "c" => 1, "v" => 3, "b" => 2, "[" => 1, "]" => 1, "t" => 1, "f" => 1 })
  end
end