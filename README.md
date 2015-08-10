# Yq

Use `yq` to parse YAML documents using [JMESPath](http://jmespath.org/). This gem is a simple wrapper around the [jmespath gem](https://github.com/jmespath/jmespath.rb). 

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
   
$ cat stuff.yml | yq 'stuff.foo'
---
bar: baz
    
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/yq/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
