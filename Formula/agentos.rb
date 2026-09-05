class Agentos < Formula
  desc "Self-hosted personal agent with browser setup and Telegram"
  homepage "https://github.com/Jongtae/homebrew-agentos"
  url "https://github.com/Jongtae/homebrew-agentos/archive/85f7c3c9d3f0b919389280da22f90201fdc844c6.tar.gz"
  version "0.1.7"
  sha256 "034826fb9679c0c874cc861522b1a6659cb687fde656d13ddb3dbdd19efc1af0"
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
