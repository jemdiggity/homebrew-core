class Janet < Formula
  desc "Dynamic language and bytecode vm"
  homepage "https://janet-lang.org"
  url "https://github.com/janet-lang/janet/archive/v1.5.0.tar.gz"
  sha256 "288abb63b25312bd248b3946fd47b6b0c26ebe4ae5b4a92a10a552d83c2a8714"
  head "https://github.com/janet-lang/janet.git"

  bottle do
    cellar :any
    sha256 "68e56a0cffa2921590b764eecd90d79385731d797ef331908beba8f589038f31" => :catalina
    sha256 "ede8d994b74b28adc233d213f7d48e1c271ef7c400b62a42d022843d38865474" => :mojave
    sha256 "05a44532d193e65e690b0318cbff6d8afb51920bd63bf64005c6d7e9ac2c4f81" => :high_sierra
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build

  def install
    system "meson", "setup", "build", "--buildtype=release", "--prefix=#{prefix}"
    cd "build" do
      system "ninja"
      system "ninja", "install"
    end
  end

  test do
    assert_equal "12", shell_output("#{bin}/janet -e '(print (+ 5 7))'").strip
  end
end
