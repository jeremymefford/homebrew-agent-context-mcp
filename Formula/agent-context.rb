class AgentContext < Formula
  desc "Rust-native MCP code search server for Milvus-backed local code intelligence"
  homepage "https://github.com/jeremymefford/agent-context-mcp"
  version "0.1.13"
  url "https://github.com/jeremymefford/agent-context-mcp/releases/download/v0.1.13/agent-context-darwin-arm64.tar.gz"
  sha256 "af78517f5ad202be546dd81c526216585a982d34e5e72f4b4147a93f7995abb7"
  license "GPL-3.0-only"
  depends_on arch: :arm64

  def install
    bin.install "agent-context"
  end

  service do
    run [
      opt_bin/"agent-context",
      "--config",
      File.join(Dir.home, "Library", "Application Support", "agent-context", "config.toml"),
      "serve",
      "--listen",
      "127.0.0.1:8765",
    ]
    keep_alive true
    working_dir var
    log_path var/"log/agent-context.log"
    error_log_path var/"log/agent-context.err.log"
  end

  def caveats
    <<~EOS
      agent-context expects:

        1. a running Milvus instance
        2. a config file at ~/Library/Application Support/agent-context/config.toml
        3. an embedding provider configured for the Homebrew service

      Provider notes:

        - Voyage: prefer embedding.voyage.key_file in config
        - OpenAI: prefer embedding.openai.key_file in config
        - Ollama: no key required, but the Ollama server must be running

      Preferred local setup:

        brew services start agent-context

      Health check:

        curl http://127.0.0.1:8765/health

      See the project README for the macOS quickstart.
    EOS
  end
end
