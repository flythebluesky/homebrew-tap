class GogcliMcp < Formula
  desc "MCP server for Google Workspace via gog CLI - connects to Claude Co-Work"
  homepage "https://github.com/flythebluesky/gogcli-mcp"
  url "https://github.com/flythebluesky/gogcli-mcp/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "71e1ffd1c92b5997e9f28ad453d6cad420808ceb35bcf823f1b251fd96891a87"
  license "MIT"

  depends_on "go" => :build
  depends_on "steipete/tap/gogcli"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "./cmd/gogcli-mcp"
  end

  def caveats
    <<~EOS
      To get started, run:
        gogcli-mcp setup

      This will check your gog accounts, generate OAuth credentials,
      and set up the server to start automatically on login.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gogcli-mcp version")
  end
end