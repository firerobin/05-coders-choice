defmodule Mhp.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Mhp.State, arg),
      worker(Mhp.Supervisor, arg)
    ]

    opts = [strategy: :one_for_one, name: Mhp.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
