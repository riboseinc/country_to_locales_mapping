require "country_to_locales_mapping/version"
require "country_to_locales_mapping/mapping"

module CountryToLocalesMapping

  module_function

  def locale_country_codes(l)
    Mapping::instance.locale_country_codes(l)
  end

  def country_code_locales(c)
    Mapping::instance.country_code_locales(c)
  end
end
