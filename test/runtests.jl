using PhysOcean
using Base.Test


@testset "PhysOcean" begin

    @test nansum([NaN,1.,2.]) ≈ 3
    @test nanmean([NaN,1.,2.]) ≈ 1.5

    @test datetime_matlab(730486) == DateTime(2000,1,1)

    @test_approx_eq_eps freezing_temperature(35) -1.9 0.1

    Ts = 10
    Ta = 20
    r = 0.9
    e = r * vaporpressure(Ta)
    tcc = 0.5
    w = 10
    pa = 1000

    # reference value from original matlab code
    @test_approx_eq_eps latentflux(r,Ta,Ts,w,pa)    -2.657651368068170e+02 1
    @test_approx_eq_eps longwaveflux(Ts,Ta,e,tcc)   -0.002148779943231 1 
    @test_approx_eq_eps sensibleflux(w,Ts,Ta)    -1.885000000000000e+02 1

    Q = 1000.
    al = 1.
    @test solarflux(Q,al) ≈ 0


    # reference value from https://en.wikipedia.org/w/index.php?title=Vapour_pressure_of_water&oldid=767455276
    @test_approx_eq_eps vaporpressure(10) 12.281 0.01

    # gausswin should be symmetric
    gw = gausswin(3)
    @test gw[2] ≈ 1
    @test gw[1] ≈ gw[3]

    # gaussfilter should reduce a peak
    @test all(gaussfilter([0,0,0,1,0,0,0],2) .< 1)
end
