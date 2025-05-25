using ShowTime
using Test
using Aqua

@testset "ShowTime.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(ShowTime)
    end
    # Write your tests here.
end
