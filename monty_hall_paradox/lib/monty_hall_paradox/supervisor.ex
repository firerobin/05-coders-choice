defmodule Mhp.Supervisor do
  use Supervisor

  def start_link() do
    import Supervisor.Spec, warn: false

    children = [
      worker(Mhp.Server, [])
    ]

    opts = [strategy: :one_for_one, name: Mhp.SubSupervisor]
    Supervisor.start_link(children, opts)
  end

end