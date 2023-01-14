class Sgappdemo < Formula
    desc "Code intelligence and search"
    license "Sourcegraph Enterprise License (portions licensed under Apache 2)"
    homepage "https://github.com/sourcegraph/sourcegraph"
    # url "https://github.com/sourcegraph/sourcegraph.git", :branch => "sg/single-binary"
    head "https://github.com/sourcegraph/sourcegraph.git", :branch => "sg/single-binary"
    # head "https://github.com/sourcegraph/sourcegraph.git", branch: "app/release-snapshot"

    depends_on "go" => :build
    
    def install
        ldflags = %W[
      -s -w
      -X github.com/sourcegraph/sourcegraph/internal/version.timestamp=$(date +%s)
      -X github.com/sourcegraph/sourcegraph/internal/version.version=${VERSION-0.0.0+dev}
      -X github.com/sourcegraph/sourcegraph/internal/conf/deploy.forceType=single-program
    ]

        system "go", "build", *std_go_args(output: bin/"sgappdemo"), "github.com/sourcegraph/sourcegraph/enterprise/cmd/sourcegraph"
    end
end
