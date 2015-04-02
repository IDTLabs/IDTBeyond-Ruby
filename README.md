# Ruby Gem for IDT Beyond

[![Join the chat at https://gitter.im/IDTLabs/IDTBeyond-Ruby](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/IDTLabs/IDTBeyond-Ruby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

The official node package for interacting with the IDT Beyond API.

## Getting started with IDT Beyond

To use this service, sign up for a free account at: [https://portal.idtbeyond.com](https://portal.idtbeyond.com), or read the documentation at [https://portal.idtbeyond.com/docs](https://portal.idtbeyond.com/docs).

## Requirements

- bundler
- ruby 2.2.1


## Setup your environment

1. Make sure above requirements are fulfilled. (see site documentation in links above)
2. run `npm install idtbeyond --save` to add this module to your project 

## Testing

Running `rake spec` will run the unit tests with RSpec 3.x.

## Usage

require "idtbeyond"

idtbeyond = IDTBeyond::Service::IATU.new 'app-id', 'app-key', 'term-id'

## Contributing

1. Fork it ( https://github.com/[my-github-username]/idtbeyond/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
