class Agentos < Formula
  desc "Self-hosted personal agent with browser setup and Telegram"
  homepage "https://github.com/Jongtae/homebrew-agentos"
  url "https://github.com/Jongtae/homebrew-agentos/archive/9d4e17b7e4abf212b30c679f898e37d2f76cd768.tar.gz"
  version "0.2.1"
  sha256 "a92c422057586e22431133959e4c81bc9d0c50df72c04f854ac4506da3eba83b"
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
