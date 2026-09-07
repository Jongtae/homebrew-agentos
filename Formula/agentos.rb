class Agentos < Formula
  desc "Self-hosted personal agent with browser setup and Telegram"
  homepage "https://github.com/Jongtae/personal-agentos"
  url "https://github.com/Jongtae/personal-agentos/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "27f49cd55df4088aa1253f141f62a0c32e486f72dbe3147c73bfd100a94a6e7a"
  depends_on "python@3.13"

  def install
    system Formula["python@3.13"].opt_bin/"python3.13", "-m", "venv", libexec
    system libexec/"bin/pip", "install", buildpath
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
  end
end
