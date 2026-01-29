class Dxcode < Formula
  desc "A distinctive, URL-safe binary encoder with the signature `dx` prefix"
  homepage "https://dxc.dogxi.me"
  version "2.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/dogxii/dxcode/releases/download/v2.1.0/dxcode-v2.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    end
    on_intel do
      url "https://github.com/dogxii/dxcode/releases/download/v2.1.0/dxcode-v2.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    end
  end

  on_linux do
    url "https://github.com/dogxii/dxcode/releases/download/v2.1.0/dxcode-v2.1.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
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
