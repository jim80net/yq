# Yq

[![Gem Version](https://badge.fury.io/rb/yq.svg)](http://badge.fury.io/rb/yq)
![Rspec and Release](https://github.com/jim80net/yq/workflows/Rspec%20and%20Release/badge.svg)

Use `yq` to parse YAML documents using [jq](https://stedolan.github.io/jq/). This gem is a simple wrapper around the executable. It will convert the YAML input into JSON, run `jq` against it, then convert the output back into YAML. Sometimes, `jq` will output non-JSON, but `yq` will just turn that into valid YAML. 

`jq` should be available in your `$PATH` to use this gem. 

## Installation

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

`yq`  converts the STDIN to JSON, and passes it to `jq`, along with the `jq` query you specify. The result is then turned back into YAML.  

## Contributing

1. Fork it ( https://github.com/jim80net/yq/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
