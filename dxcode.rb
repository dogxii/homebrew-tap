class Dxcode < Formula
  desc "A distinctive, URL-safe binary encoder with the signature `dx` prefix"
  homepage "https://dxc.dogxi.me"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/dogxii/dxcode/releases/download/v1.0.0/dxcode-v1.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "4e51f5b20caff6228d1660f4b5e4a72c2a8a470e31789ffcb2cfcc128d124802"
    end
    on_intel do
      url "https://github.com/dogxii/dxcode/releases/download/v1.0.0/dxcode-v1.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "9a8f49a14ead33c04a7cf09e47199bc5334aa68eca0a014f4e0e271ea94570c0"
    end
  end

  on_linux do
    url "https://github.com/dogxii/dxcode/releases/download/v1.0.0/dxcode-v1.0.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "53dac5a57445ba6b7b20bc33d298bc5ba7f98a7971f79708421258d39cacebd2"
  end

  def install
    bin.install "dxc"
  end

  def caveats
    <<~EOS
      dxcode CLI 已安装成功! (Native Rust binary)

      使用方法:
        dxc encode "Hello World"    # 编码
        dxc decode "dxQBpX..."      # 解码
        dxc check "dxQBpX..."       # 检查是否有效
        dxc info                    # 显示编码信息
        dxc --help                  # 查看帮助

      更多信息: https://dxc.dogxi.me
    EOS
  end
  
  test do
    assert_match "dxcode", shell_output("#{bin}/dxc --help")
    encoded = shell_output("#{bin}/dxc encode Hello").strip
    assert encoded.start_with?("dx")
    decoded = shell_output("#{bin}/dxc decode #{encoded}").strip
    assert_equal "Hello", decoded
  end
end
