class Agentos < Formula
  desc "Self-hosted personal agent with browser setup and Telegram"
  homepage "https://github.com/Jongtae/personal-agentos"
  url "https://github.com/Jongtae/personal-agentos/archive/refs/tags/v0.2.7.tar.gz"
  sha256 "75d26d06e2e5a0b5fb37fca219fc949f67a82b53af24f1519d928f73eea99aa6"
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
