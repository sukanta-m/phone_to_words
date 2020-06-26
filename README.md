## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes


### Installing

A step by step series of examples that tell you have to get a development env running

1. Clone / Download the code.
2. You may create gemset in .ruby-gemset if you want.
3. Code is tested in ruby version 2.6.6. It may work in other versions as well. You can change, ruby version in .ruby-version file.
4. Open terminal and cd in root directory.
5. It will create gemset and will ask to install rvm version, if already not installed.
6. Install bundler and gems:

```
gem install bundler
bundle install
```

### Execution

- `rspec spec/conversion_test.rb --format documentation`
- `time ruby lib/benchmark.rb`