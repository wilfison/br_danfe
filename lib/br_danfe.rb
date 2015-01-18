require "prawn"
require "prawn/measurement_extensions"
require "prawn/table"
require "barby"
require "barby/barcode/code_128"
require "barby/outputter/prawn_outputter"
require "nokogiri"
require "yaml"
require "ostruct"
require "i18n"
require "br_documents"

Dir[File.dirname(__FILE__) + "/**/*.rb"].each { |f| require f }
I18n.load_path << File.expand_path("../../config/locales/pt-BR.yml", __FILE__)