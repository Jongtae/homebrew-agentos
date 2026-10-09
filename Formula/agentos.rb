class Agentos < Formula
  desc "Self-hosted personal agent with browser setup and Telegram"
  homepage "https://github.com/Jongtae/agentos"
  url "https://github.com/Jongtae/agentos/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "64cd09d1bbb2352e16b0ac56ec2fe96e5733d65ace2af300be80b5b2bbeb2682"
  depends_on "python@3.13"

  def install
    system Formula["python@3.13"].opt_bin/"python3.13", "-m", "venv", libexec
    system libexec/"bin/pip", "install", "#{buildpath}[mcp-host]"
    (bin/"agentos").write <<~PYTHON
      #!#{libexec}/bin/python
      from personal_agent.quickstart import main
      main()
    PYTHON
  end

  def caveats
    <<~EOS
      Run agentos start to open browser setup.
      Data: ~/.local/share/agentos
      Keep the process running to receive Telegram requests.
    EOS
  end

  test do
    assert_match "personal agent", shell_output("#{bin}/agentos --help")
    system libexec/"bin/python", "-c", "from mcp.server.stdio import stdio_server"
  end
end
