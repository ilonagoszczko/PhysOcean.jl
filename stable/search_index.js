var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "Sea-water properties",
    "title": "Sea-water properties",
    "category": "page",
    "text": "PhysOcean"
},

{
    "location": "index.html#PhysOcean.density-Tuple{Any,Any,Any}",
    "page": "Sea-water properties",
    "title": "PhysOcean.density",
    "category": "Method",
    "text": "density(S,T,p)\n\nCompute the density of sea-water (kg/m³) at the salinity S (psu, PSS-78), temperature T (degree Celsius, ITS-90) and pressure p (decibar) using the UNESCO 1983 polynomial.\n\nFofonoff, N.P.; Millard, R.C. (1983). Algorithms for computation of fundamental properties of seawater. UNESCO Technical Papers in Marine Science, No. 44. UNESCO: Paris. 53 pp. http://web.archive.org/web/20170103000527/http://unesdoc.unesco.org/images/0005/000598/059832eb.pdf\n\n\n\n"
},

{
    "location": "index.html#PhysOcean.secant_bulk_modulus-Tuple{Any,Any,Any}",
    "page": "Sea-water properties",
    "title": "PhysOcean.secant_bulk_modulus",
    "category": "Method",
    "text": "secant_bulk_modulus(S,T,p)\n\nCompute the secant bulk modulus of sea-water (bars) at the salinity S (psu, PSS-78), temperature T (degree Celsius, ITS-90) and pressure p (decibar) using the UNESCO polynomial 1983.\n\nFofonoff, N.P.; Millard, R.C. (1983). Algorithms for computation of fundamental properties of seawater. UNESCO Technical Papers in Marine Science, No. 44. UNESCO: Paris. 53 pp. http://web.archive.org/web/20170103000527/http://unesdoc.unesco.org/images/0005/000598/059832eb.pdf\n\n\n\n"
},

{
    "location": "index.html#PhysOcean.freezing_temperature-Tuple{Any}",
    "page": "Sea-water properties",
    "title": "PhysOcean.freezing_temperature",
    "category": "Method",
    "text": "freezing_temperature(S)\n\nCompute the freezing temperature (in degree Celsius) of sea-water based on the salinity S (psu).\n\n\n\n"
},

{
    "location": "index.html#Sea-water-properties-1",
    "page": "Sea-water properties",
    "title": "Sea-water properties",
    "category": "section",
    "text": "density(S,T,p)secant_bulk_modulus(S,T,p)freezing_temperature(S)"
},

{
    "location": "index.html#PhysOcean.latentflux-NTuple{5,Any}",
    "page": "Sea-water properties",
    "title": "PhysOcean.latentflux",
    "category": "Method",
    "text": "latentflux(Ts,Ta,r,w,pa)\n\nCompute the latent heat flux (W/m²) using the sea surface temperature Ts (degree Celsius), the air temperature Ta (degree Celsius), the relative humidity r (0 ≤ r ≤ 1, pressure ratio, not percentage), the wind speed w (m/s) and the air pressure (hPa).\n\n\n\n"
},

{
    "location": "index.html#PhysOcean.longwaveflux-NTuple{4,Any}",
    "page": "Sea-water properties",
    "title": "PhysOcean.longwaveflux",
    "category": "Method",
    "text": "longwaveflux(Ts,Ta,e,tcc)\n\nCompute the long wave heat flux (W/m²) using the sea surface temperature Ts (degree Celsius), the air temperature Ta (degree Celsius), the wate vapour pressure e (hPa) and the total cloud coverage ttc (0 ≤ tcc ≤ 1).\n\n\n\n"
},

{
    "location": "index.html#PhysOcean.sensibleflux-Tuple{Any,Any,Any}",
    "page": "Sea-water properties",
    "title": "PhysOcean.sensibleflux",
    "category": "Method",
    "text": "sensibleflux(Ts,Ta,w)\n\nCompute the sensible heat flux (W/m²) using the wind speed w (m/s), the sea surface temperature Ts (degree Celsius), the air temperature Ta (degree Celsius).\n\n\n\n"
},

{
    "location": "index.html#PhysOcean.solarflux-Tuple{Any,Any}",
    "page": "Sea-water properties",
    "title": "PhysOcean.solarflux",
    "category": "Method",
    "text": "solarflux(Q,al)\n\nCompute the solar heat flux (W/m²)\n\n\n\n"
},

{
    "location": "index.html#PhysOcean.vaporpressure-Tuple{Any}",
    "page": "Sea-water properties",
    "title": "PhysOcean.vaporpressure",
    "category": "Method",
    "text": "vaporpressure(T)\n\nCompute vapour pressure of water at the temperature T (degree Celsius) in hPa using Tetens equations. The temperature must be postive.\n\nMonteith, J.L., and Unsworth, M.H. 2008. Principles of Environmental Physics. Third Ed. AP, Amsterdam. http://store.elsevier.com/Principles-of-Environmental-Physics/John-Monteith/isbn-9780080924793\n\n\n\n"
},

{
    "location": "index.html#Heat-fluxes-1",
    "page": "Sea-water properties",
    "title": "Heat fluxes",
    "category": "section",
    "text": "latentflux(Ts,Ta,r,w,pa)longwaveflux(Ts,Ta,e,tcc)sensibleflux(Ts,Ta,w)solarflux(Q,al)vaporpressure(T)"
},

{
    "location": "index.html#PhysOcean.gausswin",
    "page": "Sea-water properties",
    "title": "PhysOcean.gausswin",
    "category": "Function",
    "text": "gausswin(N, α = 2.5)\n\nReturn a Gaussian window with N points with a standard deviation of  (N-1)/(2 α).\n\n\n\n"
},

{
    "location": "index.html#PhysOcean.gaussfilter-Tuple{Any,Any}",
    "page": "Sea-water properties",
    "title": "PhysOcean.gaussfilter",
    "category": "Method",
    "text": "gaussfilter(x,N)\n\nFilter the vector x with a N-point Gaussian window.\n\n\n\n"
},

{
    "location": "index.html#Filtering-1",
    "page": "Sea-water properties",
    "title": "Filtering",
    "category": "section",
    "text": "gausswin(N, α = 2.5)gaussfilter(x,N)"
},

]}