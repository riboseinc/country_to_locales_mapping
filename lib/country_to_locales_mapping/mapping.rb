# (c) Copyright 2017 Ribose Inc.
#

require "json"
require "singleton"

module CountryToLocalesMapping
  #
  # Provides a mapping between ISO3166 country codes and RFC4646 locale
  # codes. Locale codes are placed in order of usage in the region
  # (e.g. de-CH > fr-CH > it-CH).
  #
  # Country-Locale data is stored in:
  #   root/config/i18n/country_locale_map.csv
  #
  # Country-Locale csv columns:
  #
  #   ISO3166 Country Code,
  #   Country name, (not used in processing)
  #   RFC4646 Locale code,
  #   (all columns after are RFC4646 Locale codes)
  #
  #   RFC4646 Locale codes are ordered to indicate preference.
  #   i.e. locale code in column 3 is more important than the locale code
  #   in column 5 for a country.
  #
  #   First Locale code always reflects the official language of country
  #   (but might not be only official language, e.g. CH).
  #
  #
  # Sources considered:
  #   http://www.i18nguy.com/unicode/language-identifiers.html
  #   http://www.infoplease.com/ipa/A0855611.html
  #

  #
  # TODO: Give each locale a preference value: e.g. de-CH 0.6, fr-CH 0.3
  #
  class Mapping
    include Singleton
    attr_accessor :cc, :ll

    def initialize
      @cc = {}
      @ll = {}
      import_locale_map
    end

    # Imports country-locale map to memory for upcoming
    # queries
    def import_locale_map
      json = JSON.parse(File.read(path_to_json))

      json["countries"].each_pair do |country_code, country_data|
        country_name = country_data["name"]
        languages = country_data["locales"]

        associate_country_with_locales(country_name, country_code, languages)
      end
    end

    # Returns an array of country codes that match the given locale code.
    #
    # Note: Since in our current mapping, "en" is not assigned to any
    # country, so "en" will not match anything while "en-us" will return
    # "us".
    #
    def locale_country_codes(l)
      if l.nil? || !@ll.has_key?(l)
        raise ArgumentError, "Locale not recognized: #{l}"
      end

      @ll[l][:ccodes]
    end

    # Returns an array of locale ids that match the given country code.
    #
    def country_code_locales(c)
      if c.nil? || !@cc.has_key?(c)
        raise ArgumentError, "Country code not recognized: #{c}"
      end

      @cc[c][:locales]
    end

    private

    def associate_country_with_locales(country_name, country_code, languages)
      @cc[country_code] = {
        name: country_name,
        locales: languages,
      }

      languages.each do |l|
        @ll[l] ||= {}
        @ll[l][:ccodes] ||= []
        @ll[l][:ccodes].push country_code
      end
    end

    def path_to_json
      File.expand_path("../../../data/country_locale_map.json", __FILE__)
    end
  end
end
