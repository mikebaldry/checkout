require 'bundler'

Bundler.require
SimpleCov.start

require_relative '../lib/product'
require_relative '../lib/basket_product'
require_relative '../lib/checkout'
require_relative '../lib/rules/percentage_discount_on_total'
require_relative '../lib/rules/price_drop_on_multiple'
