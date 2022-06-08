# FactoryBot::NamespacedFactories

Affordances for applying Domain Driven design while using FactoryBot

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'factory_bot-namespaced_factories'
```

And then execute:
```shell
$ bundle install
```
## Usage

See:

- https://github.com/thoughtbot/factory_bot/issues/199
- https://github.com/thoughtbot/factory_bot/commit/652818bd1701db67ea03cd062c8259cd7fb37807

There are two main use-cases for Namespaced Factories:

1. Sharing Factories from an Engine or Gem
2. Decomposing an application using domain driven design

Example User Factory

```ruby
# spec/factories/categories.rb
FactoryBot.define do
  factory :category do
    name { "Classics" }
  end
end

# movies/spec/factories/categories.rb
FactoryBot.define do
  with_namespace(:Movies) do
    factory :category do
      name { "Emmy Winners" }
    end
  end
end

# movies/spec/category_spec.rb
category = FactoryBot.build(:category)
expect(category).to be_kind_of(Movies::Category)

# spec/category_spec.rb
category = FactoryBot.build(:category)
expect(category).to be_kind_of(Category)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zinc-collective/factory_bot-namespaced_factories. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/zinc-collective/factory_bot-namespaced_factories/blob/main/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the FactoryBotNamespacedFactories project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/zinc-collective/factory_bot-namespaced_factories/blob/main/CODE_OF_CONDUCT.md).
