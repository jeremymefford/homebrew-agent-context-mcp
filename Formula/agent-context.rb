class AgentContext < Formula
  desc "Rust-native MCP code search server for Milvus-backed local code intelligence"
  homepage "https://github.com/jeremymefford/agent-context-mcp"
  version "0.1.19"
  url "https://github.com/jeremymefford/agent-context-mcp/releases/download/v0.1.19/agent-context-darwin-arm64.tar.gz"
  sha256 "7157239c5e5adb2cdab0f4cdd5247e20adc917dc6133251f4f85418f3f040a55"
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
