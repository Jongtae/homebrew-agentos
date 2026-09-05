class Agentos < Formula
  desc "Self-hosted personal agent with browser setup and Telegram"
  homepage "https://github.com/Jongtae/homebrew-agentos"
  url "https://github.com/Jongtae/homebrew-agentos/archive/e3fd9795f341fa19ceb17655b45b6744dea0961b.tar.gz"
  version "0.1.6"
  sha256 "80f864d684074850ff92d6a7fa68c7b02b7da500cdf6a0998873c1918c603f3a"
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
