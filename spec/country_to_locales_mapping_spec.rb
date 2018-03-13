RSpec.describe CountryToLocalesMapping do
  it "has a version number" do
    expect(CountryToLocalesMapping::VERSION).not_to be nil
  end

  it "tells which languages are spoken in given countries" do
    instance = CountryToLocalesMapping::Mapping.instance
    expect(instance.country_code_locales("PL")).
      to eq(%w[pl de-pl yi])
    expect(instance.country_code_locales("GB")).
      to eq(%w[en-gb en-gb-oed en-scouse cy-gb gd fr-gb ga-gb gv kw])
  end
end
