class AgentContext < Formula
  desc "Rust-native MCP code search server for Milvus-backed local code intelligence"
  homepage "https://github.com/jeremymefford/agent-context-mcp"
  url "https://github.com/jeremymefford/agent-context-mcp/releases/download/v0.1.3/agent-context-darwin-arm64.tar.gz"
  sha256 "c0d77169ccd7de2f161ef728d6eb88ae3dcc9ba2a477c83ee2473573b2559db5"
  license "GPL-3.0-only"

  def install
    bin.install "agent-context"
  end

  def caveats
    <<~EOS
      agent-context expects:

        1. a running Milvus instance
        2. a config file, usually created with `agent-context init`
        3. an embedding provider configured via env vars or Ollama

      See the project README for the macOS quickstart.
    EOS
  end
end
