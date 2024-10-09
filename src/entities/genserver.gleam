import gleam/otp/actor

pub type Message(a, b) {
  Call(msg: a)
  Cast(msg: b)
}

pub type State(a) {
  State(data: a)
}

pub fn start(
  initial_state: a,
) -> Result(actor.StartResult(Message(b, c)), actor.StartError) {
  actor.start(fn() { init(initial_state) })
}

fn init(initial_state: a) -> actor.InitResult(Message(b, c), State(a)) {
  actor.Ready(State(initial_state), None)
}

pub fn call(
  process: actor.StartResult(Message(a, b)),
  msg: a,
) -> Result(b, actor.ExitReason) {
  actor.call(process, fn() { Call(msg) })
}

pub fn cast(process: actor.StartResult(Message(a, b)), msg: b) -> Nil {
  actor.send(process, Cast(msg))
}

pub fn handle_message(
  msg: Message(a, b),
  state: State(c),
) -> actor.Next(Message(a, b), State(c)) {
  case msg {
    Call(msg) -> {
      let #(reply, new_state) = handle_call(msg, state)
      actor.Reply(reply, State(new_state))
    }
    Cast(msg) -> {
      let new_state = handle_cast(msg, state)
      actor.Continue(State(new_state))
    }
  }
}

fn handle_call(msg: a, state: State(b)) -> #(a, b) {
  // TODO: Implement call handling here
  #(msg, state.data)
}

fn handle_cast(msg: a, state: State(b)) -> b {
  // TODO: Implement cast handling here
  state.data
}
