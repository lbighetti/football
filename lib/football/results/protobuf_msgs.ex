defmodule Football.Results.ProtobufMsgs do
  @moduledoc """
  Module for holding Protocol Buffer Messages.

  It is another representation of `Football.Results.Result`.

  It's used as a intermediary format to be encoded by `Protobuf` package.
  """
  use Protobuf, from: Path.expand("result.proto", __DIR__)
end
