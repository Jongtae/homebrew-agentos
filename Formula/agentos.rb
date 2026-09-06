class Agentos < Formula
  desc "Self-hosted personal agent with browser setup and Telegram"
  homepage "https://github.com/Jongtae/homebrew-agentos"
  url "https://github.com/Jongtae/homebrew-agentos/archive/b964b3f0cc37f767944b8130e39fedf3ecd2f3a9.tar.gz"
  version "0.2.0"
  sha256 "917873a39611c16b15b3f87206175ceb706b9280e695b03795590a112b4bab63"
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
