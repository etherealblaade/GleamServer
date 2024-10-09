# Gleam GenServer and Supervisor

This micro-library provides a simple implementation of GenServer and Supervisor patterns in Gleam, inspired by the corresponding concepts from Elixir/OTP.

## Features

- Basic GenServer implementation with support for synchronous (call) and asynchronous (cast) messages
- Simple Supervisor for managing the lifecycle of GenServer
- Easily extensible and customizable architecture

## Structure

The library consists of two main modules:

1. `my_genserver.gleam`: Implements basic GenServer functionality
2. `my_supervisor.gleam`: Provides Supervisor functionality for managing GenServer

## Usage

### GenServer

```gleam
import my_genserver

// Define your message and state types
type Message {
  // ...
}

type State {
  // ...
}

// Implement message handlers
fn handle_call(msg, caller, state) {
  // ...
}

fn handle_cast(msg, state) {
  // ...
}

// Start the GenServer
my_genserver.start_link(initial_state)
```

### Supervisor

```gleam
import my_supervisor

// Start the supervisor
my_supervisor.start_link()
```

## Installation

Add this library to your Gleam project dependencies:

```shell
gleam add gleamserver
```

## Contributing

We welcome contributions to this library! Please create an issue or submit a pull request on GitHub.

## License

This library is distributed under the MIT license. See the LICENSE file for more information.
