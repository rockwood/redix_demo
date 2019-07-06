defmodule Demo.Application do
  use Application

  def start(_type, _args) do
    children = [
      Demo
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Demo.Supervisor)
  end
end
