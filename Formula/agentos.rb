class Agentos < Formula
  desc "Self-hosted personal agent with browser setup and Telegram"
  homepage "https://github.com/Jongtae/personal-agentos"
  url "https://github.com/Jongtae/personal-agentos/archive/refs/tags/v0.2.8.tar.gz"
  sha256 "a8c735363e7d426fd5927b4ae250959e02fe6bcd63c283e50a334dcdcd02df69"
  depends_on "python@3.13"

  def install
    libexec.install "personal_agent"
    (bin/"agentos").write <<~PYTHON
      #!#{formula_opt_bin("python@3.13")}/python3.13
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
