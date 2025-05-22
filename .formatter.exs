# .formatter.exs
#
# This file configures Elixir's built-in code formatter.
# It's used when running `mix format` or when formatting on save in your editor.
#
# The `:inputs` option defines which files and directories should be formatted.
# In this case:
# - "{mix,.formatter}.exs" includes the project's main config files
# - "{config,lib,test}/**/*.{ex,exs}" includes all .ex and .exs files
#   recursively in the config/, lib/, and test/ directories
#
# This setup ensures consistent formatting across your codebase.
# You can customize this file further if needed (e.g., to change line length,
# exclude files, or add specific formatting rules).
#
# For more information, see:
# - https://hexdocs.pm/mix/Mix.Tasks.Format.html

[
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"]
]
