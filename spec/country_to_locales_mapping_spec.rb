RSpec.describe CountryToLocalesMapping do
  it "has a version number" do
    expect(CountryToLocalesMapping::VERSION).not_to be nil
  end

  it "tells which languages are spoken in given countries" do
    expect(CountryToLocalesMapping::Mapping.instance["PL"]).to eq(["pl"])
  end
end
