# Cirrus

A simple tool that leverages Redis to allow you to safetly lock your blocks of code

## Installation

Add this line to your application's Gemfile:

    gem 'cirrus'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cirrus

## Usage

    Cirrus.lock(me.id, you.id) do
      "Yay!"
    end

    # => Yay!

    Cirrus.lock(me.id, you.id) do
      Cirrus.lock(me.id, you.id) do
        "Yay!"
      end
    end

    # => Cirrus::UnlockableExecption

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
