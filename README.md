## Code test

For an online marketplace, here is a sample of some of the products available:

| Product code | Name | Price |
| ------------ | ---- | ----- |
| 001 | Silver Earrings | £9.25 |
| 002 | Dove Dress in Bamboo | £45.00 |
| 003 | Autumn Floral Shirt | £19.95 |

The marketing team want to offer promotions as an incentive for our customers to purchase these items.

- If you spend over £60, then you get 10% off your purchase
- If you buy 2 or more sets of earrings then the price drops to £8.50

Our check-out can scan items in any order, and because our promotions will change, it needs to be flexible regarding our promotional rules.

The interface to our checkout looks like this (shown in Ruby):

```ruby
co = Checkout.new(promotional_rules)
co.scan(item)
co.scan(item)
price = co.total
```

Implement a checkout system that fulfills these requirements.

## Test data

| Basket products | Total expected |
| --------------- | -------------- |
| 001, 002, 003 | £66.78 |
| 001, 003, 001 | £36.95 |
| 001, 002, 001, 003 | £73.76 |


## Running

This project uses bundler and includes `.ruby-version`/`.tool-versions` to allow version managers to pick the right version.

Run `bundle install` to install the necessary gems
Run `bundle exec rspec` to run the tests