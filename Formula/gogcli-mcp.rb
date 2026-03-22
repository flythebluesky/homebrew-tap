class GogcliMcp < Formula
  desc "MCP server for Google Workspace via gog CLI - connects to Claude Co-Work"
  homepage "https://github.com/flythebluesky/gogcli-mcp"
  url "https://github.com/flythebluesky/gogcli-mcp/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "8ee9e5ec7ed86479b82d9bba2e9e768c4ef28226b46a5bed4f314ea2333d3e36"
  license "MIT"

  depends_on "go" => :build
  depends_on "steipete/tap/gogcli"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "./cmd/gogcli-mcp"
  end

  service do
    run [opt_bin/"gogcli-mcp"]
    environment_variables PATH: std_service_path_env
    keep_alive true
    log_path var/"log/gogcli-mcp/stdout.log"
    error_log_path var/"log/gogcli-mcp/stderr.log"
  end

  def caveats
    <<~EOS
      Before starting the service, run the setup wizard:
        gogcli-mcp setup

      Then start with:
        brew services start gogcli-mcp

      Logs:
        #{var}/log/gogcli-mcp/
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gogcli-mcp version")
  end
end
