import gleam/dynamic
import gleam/otp/process
import gleam/otp/supervisor
import gleam/result

import genserver

pub type ChildSpec {
  GenServer(initial_state: dynamic.Dynamic)
}

pub fn start_link() -> Result(process.Pid, supervisor.StartError) {
  let child_specs = [
    supervisor.worker(my_genserver.start_link, dynamic.from([])),
  ]

  supervisor.start_link(
    supervisor.OneForOne,
    child_specs,
    supervisor.period_and_intensity(5, 1),
  )
}

pub fn child_spec() -> supervisor.ChildSpec {
  supervisor.child_spec(
    id: "Supervisor",
    start: start_link,
    child_type: supervisor.Worker,
  )
}

pub fn init(
  children: List(ChildSpec),
) -> Result(supervisor.Spec, dynamic.Dynamic) {
  let child_specs =
    children
    |> result.try(fn(child) {
      case child {
        GenServer(initial_state) ->
          Ok(supervisor.worker(my_genserver.start_link, initial_state))
      }
    })

  case child_specs {
    Ok(specs) ->
      Ok(supervisor.spec(
        supervisor.OneForOne,
        specs,
        supervisor.period_and_intensity(5, 1),
      ))
    Error(e) -> Error(e)
  }
}
