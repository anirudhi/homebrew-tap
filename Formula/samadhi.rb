class Samadhi < Formula
  desc "Samādhi: a calm, distraction-free, full-screen writing app with ambient music and typing sounds"
  homepage "https://github.com/anirudhi/samadhi"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/anirudhi/samadhi/releases/download/v0.2.0/samadhi-aarch64-apple-darwin.tar.xz"
      sha256 "832b9a714caa20b60fa8ffcd525c78bd4694d0a52c15a95321d01e97aac8a9eb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anirudhi/samadhi/releases/download/v0.2.0/samadhi-x86_64-apple-darwin.tar.xz"
      sha256 "c9c45d8d2eea40b0b7b020dde059d0a902b40ecfb68e0ba11613b8bd9288fe3e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/anirudhi/samadhi/releases/download/v0.2.0/samadhi-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "751f57a2a147f9b6bce2458306768cbc234e231b15942ba03017c1fd7fabbe19"
    end
    if Hardware::CPU.intel?
      url "https://github.com/anirudhi/samadhi/releases/download/v0.2.0/samadhi-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8fd2f8ab7e548ad14caa989bf251d9d083c7d535d964e28fe5a7d27fda6100a6"
    end
  end
  license "GPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "samadhi"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "samadhi"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "samadhi"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "samadhi"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
