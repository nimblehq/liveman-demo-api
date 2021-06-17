## Introduction

Showcase application built for Growth #34 to demonstrate the abilities of Phoenix Livebook to document an API.

## Project Setup

### Erlang & Elixir

* Erlang 24.0.1

* Elixir 1.12.1

* Recommended version manager.

  - [asdf](https://github.com/asdf-vm/asdf)
  - [asdf-erlang](https://github.com/asdf-vm/asdf-erlang)
  - [asdf-elixir](https://github.com/asdf-vm/asdf-elixir)

### Development

* Install [Docker for Mac](https://docs.docker.com/docker-for-mac/install/)

* Setup and boot the Docker containers:

  ```sh
  make docker_setup
  ```

* Install Elixir dependencies:

  ```sh
  mix deps.get
  ```

* Setup the databases:

  ```sh
  mix ecto.setup
  ```

* Start the Phoenix app

  ```sh
  iex -S mix phx.server
  ```

* Run all tests:

  ```sh
  mix test 
  ```

* Run all lint:

  ```sh
  mix codebase 
  ```
  
* Test coverage:

  ```sh
  mix coverage 
  ```

### Production

* Build Docker image

  ```sh
  docker-compose build
  ```

## License

This project is Copyright (c) 2014 and onwards. It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE

## About

![Nimble](https://assets.nimblehq.co/logo/dark/logo-dark-text-160.png)

This project is maintained and funded by Nimble.

We love open source and do our part in sharing our work with the community!
See [our other projects][community] or [hire our team][hire] to help build your product.

[community]: https://github.com/nimblehq
[hire]: https://nimblehq.co/
