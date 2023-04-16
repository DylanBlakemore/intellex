defmodule Intellex.Agent do
  defstruct [:uuid, :chain, :toolkit, :llm]

  alias Intellex.{Action, Chain, Message, ResponseHandler}

  @type t :: %__MODULE__{}

  @spec new(keyword()) :: {:ok, %__MODULE__{}}
  def new(opts) do
    {:ok,
     %__MODULE__{
       uuid: opts[:uuid] || generate_uuid(),
       chain: init_chain(opts),
       toolkit: opts[:toolkit],
       llm: opts[:llm]
     }}
  end

  defp init_chain(opts) do
    Chain.new!()
    |> Chain.link(Message.system(opts[:system]))
    |> Chain.link(Message.human(opts[:human]))
  end

  defp generate_uuid do
    :crypto.strong_rand_bytes(16)
    |> Base.encode16(case: :lower)
  end

  @spec link(t(), Message.t()) :: t()
  def link(agent, message) do
    %__MODULE__{agent | chain: Chain.link(agent.chain, message)}
  end

  @spec run(t()) :: {atom(), String.t()}
  def run(agent) do
    with {:ok, response} <- chat(agent) do
      agent
      |> link(response.message)
      |> respond()
    else
      {:error, error} -> {:error, error}
    end
  end

  defp respond(agent) do
    case ResponseHandler.handle_response(agent.chain.messages |> List.last()) do
      {:action, message} -> handle_action(agent, message)
      {:complete, message} -> {:complete, message}
      {:failed, message} -> {:failed, message}
      {:error, error} -> {:error, handle_error(agent, error)}
    end
  end

  defp handle_error(agent, error) do
    agent
    |> link(Message.human(error))
    |> run()
  end

  defp handle_action(agent, message) do
    {_, result} =
      message.content
      |> Action.new!()
      |> Action.run(agent.toolkit)

    agent
    |> link(result)
    |> run()
  end

  defp chat(agent) do
    agent.llm.chat(agent.chain)
  end
end
