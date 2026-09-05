class Agentos < Formula
  desc "Self-hosted personal agent with browser setup and Telegram"
  homepage "https://github.com/Jongtae/homebrew-agentos"
  url "https://github.com/Jongtae/homebrew-agentos/archive/630ee25314110c673e9328a790e8ebac8d1d950f.tar.gz"
  version "0.1.3"
  sha256 "52900e5015a908ca9cb5940e82d16bb0c4fa160a0c911c20fb710ce1bd3927cb"
  depends_on "python@3.13"

  def install
    libexec.install "personal_agent"
    (bin/"agentos").write <<~PYTHON
      #!#{Formula["python@3.13"].opt_bin}/python3.13
      import sys
      sys.path.insert(0, "#{libexec}")
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
