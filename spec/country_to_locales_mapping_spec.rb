RSpec.describe CountryToLocalesMapping do
  it "has a version number" do
    expect(CountryToLocalesMapping::VERSION).not_to be nil
  end

  it "tells which languages are spoken in given country" do
    instance = CountryToLocalesMapping::Mapping.instance
    expect(instance.country_code_locales("PL")).
      to eq(%w[pl de-PL yi])
    expect(instance.country_code_locales("GB")).
      to eq(%w[en-GB en-GB-oed en-scouse cy-GB gd fr-GB ga-GB gv kw])
  end
end
