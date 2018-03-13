RSpec.describe CountryToLocalesMapping do
  it "has a version number" do
    expect(CountryToLocalesMapping::VERSION).not_to be nil
  end

  describe "CountryToLocalesMapping::Mapping#country_code_locales" do
    subject { instance.method(:country_code_locales) }
    let(:instance) { CountryToLocalesMapping::Mapping.instance }

    it "tells which languages are spoken in given country" do
      expect(subject.("PL")).to eq(%w[pl de-PL yi])
      expect(subject.("GB")).
        to eq(%w[en-GB en-GB-oed en-scouse cy-GB gd fr-GB ga-GB gv kw])
    end

    it "raises ArgumentError for unrecognized country codes" do
      expect{ subject.("XX") }.
        to raise_exception(ArgumentError, "Country code not recognized: XX")
    end
  end

  describe "CountryToLocalesMapping::Mapping#locale_country_codes" do
    subject { instance.method(:locale_country_codes) }
    let(:instance) { CountryToLocalesMapping::Mapping.instance }

    it "tells in which countries given language is spoken" do
      expect(subject.("pl")).to contain_exactly("PL", "UA")
      expect(subject.("uk")).to contain_exactly("MD", "UA")
    end

    it "raises ArgumentError for unrecognized locale codes" do
      expect{ subject.("xx") }.
        to raise_exception(ArgumentError, "Locale not recognized: xx")
    end
  end

end
