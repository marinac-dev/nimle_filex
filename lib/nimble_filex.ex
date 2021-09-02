defmodule NimbleFilex do
  @moduledoc """
  This is documentation for `NimbleFilex`.\n
  Library will try to recognise file type from its binary fingerpring.
  """

  @doc """
  Returns either string with supposed file extension or nil

  ## Example

      iex> NimbleFilex.get_extension(binary_jpg_file)
      ".jpg"
      ie> NimbleFilex.get_extension(unsupported_file)
      nil

  """
  @spec get_extension(binary()) :: String.t()
  def get_extension(bin), do: file_extension(bin)

  # Helper fn to get file extension using magic numbers (linux only)
  # Source: https://en.wikipedia.org/wiki/List_of_file_signatures
  defp file_extension(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>), do: ".png"

  defp file_extension(<<0xFF, 0xD8, _::binary>>), do: ".jpg"
  defp file_extension(<<0x49, 0x46, 0x00, 0x01, _::binary>>), do: ".jpg"
  defp file_extension(<<0x69, 0x66, 0x00, 0x00, _::binary>>), do: ".jpg"

  defp file_extension(<<0x47, 0x49, 0x46, 0x38, 0x37, 0x61>>), do: ".gif"
  defp file_extension(<<0x47, 0x49, 0x46, 0x38, 0x39, 0x61>>), do: ".gif"

  defp file_extension(<<0x66, 0x74, 0x79, 0x70, 0x69, 0x73, 0x6F, 0x6D, _::binary>>), do: ".mp4"

  defp file_extension(<<0xFF, 0xFB, _::binary>>), do: ".mp3"
  defp file_extension(<<0xFF, 0xF3, _::binary>>), do: ".mp3"
  defp file_extension(<<0xFF, 0xF2, _::binary>>), do: ".mp3"

  defp file_extension(<<0x52, 0x61, 0x72, 0x21, 0x1A, 0x07, 0x00, _::binary>>), do: ".rar"
  defp file_extension(<<0x52, 0x61, 0x72, 0x21, 0x1A, 0x07, 0x01, 0x00, _::binary>>), do: ".rar"

  defp file_extension(<<0x37, 0x7A, 0xBC, 0xAF, 0x27, 0x1C, _::binary>>), do: ".7z"
  defp file_extension(<<0x1F, 0x8B, _::binary>>), do: ".xz"

  defp file_extension(<<0x75, 0x73, 0x74, 0x61, 0x72, 0x00, 0x30, 0x30, _::binary>>), do: ".tar"
  defp file_extension(<<0x75, 0x73, 0x74, 0x61, 0x72, 0x20, 0x20, 0x00, _::binary>>), do: ".tar"

  defp file_extension(<<0x25, 0x50, 0x44, 0x46, _::binary>>), do: ".pdf"

  defp file_extension(_), do: nil
end
