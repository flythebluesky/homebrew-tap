class GogcliMcp < Formula
  desc "MCP server for Google Workspace via gog CLI - connects to Claude Co-Work"
  homepage "https://github.com/flythebluesky/gogcli-mcp"
  url "https://github.com/flythebluesky/gogcli-mcp/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "8657cfba2a68739a5b4b7e10c6d724bbd0e6469bb89987eb115f8ef322b631ea"
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