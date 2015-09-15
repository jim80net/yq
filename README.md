# Yq

[![Gem Version](https://badge.fury.io/rb/yq.svg)](http://badge.fury.io/rb/yq)
[![Build Status](https://travis-ci.org/jim80net/yq.svg?branch=master)](https://travis-ci.org/jim80net/yq)

Use `yq` to parse YAML documents using [jq](https://stedolan.github.io/jq/). This gem is a simple wrapper around the executable. `jq` should be available in your path to use this gem. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yq'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yq

## Usage

`yq` takes input from STDIN: 

```
$ cat stuff.yml | yq '.'
---
stuff:
  foo: 
    bar: baz
   
$ cat stuff.yml | yq '.stuff.foo'
---
bar: baz
    
```

## Contributing

1. Fork it ( https://github.com/jim80net/yq/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
