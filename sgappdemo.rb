class Sgappdemo < Formula
    # version "0.0.0"
    desc "Code intelligence and search"
    license "Sourcegraph Enterprise License (portions licensed under Apache 2)"
    homepage "https://github.com/sourcegraph/sourcegraph"
    # url "https://github.com/sourcegraph/sourcegraph.git", :branch => "sg/single-binary"
    head "https://github.com/sourcegraph/sourcegraph.git", :branch => "sg/single-binary"
    # head "https://github.com/sourcegraph/sourcegraph.git", branch: "app/release-snapshot"

    depends_on "go" => :build
    
    def install
        os = OS.kernel_name.downcase
        arch = Hardware::CPU.intel? ? "amd64" : "arm64"
        ENV["GOARCH"] = "#{arch}"
        ENV["ENTERPRISE"] = "1"
        ENV["DEV_WEB_BUILDER"] = "esbuild yarn run build-web"
        ldflags = %W[
            -X github.com/sourcegraph/sourcegraph/internal/conf/deploy.forceType=single-program
        ]

        system "go", "build", *std_go_args(output: bin/"sgappdemo", ldflags: ldflags), "github.com/sourcegraph/sourcegraph/enterprise/cmd/sourcegraph"
    end
end
