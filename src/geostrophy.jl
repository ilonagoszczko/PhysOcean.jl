"""
Calculates geostrophic velocities
works with one or two horizontal dimensions and additional (time) dimensions
Dimensions are supposed to be ordered horizontal, vertical, other dimensions


# Input:
* rhop: density anomaly array
* pmnin: tuple of metrics as in divand, but should be in m 
* xiin: tuple position of the grid points.
* either provide level of no motion or ssh eta LEVEL IS INDEX NUMBER FOR THE MOMENT
* dimensions of ssh must be the same as rhop in which vertical dimension has been taken out
* If you force fillin=false, then you must have created the density array without missing values outside of this call


# Output:
* Velocity tuple components NORMAL and to the left of each coordinate line
* eta : sea surface height deduced
* fluxes: integrated velocities across sections.
# Note:


"""

function geostrophy(mask::BitArray,rhop,pmnin,xiin;dim::Integer=0,ssh=(),znomotion=0,fillin=true)

if dim==0
# assume depth is last dimension
dim=ndims(rhop)
end


#############################################
function myfilter3(A::AbstractArray,fillvalue,isfixed,ntimes=1)

    #
    function dvisvalue(x)
        if isnan(fillvalue)
            return !isnan(x);
        else
            return !(x==fillvalue);
        end
    end

    nd=ndims(A)
    # central weight
    cw=3^nd-1
    cw=1
    out = similar(A)
    if ntimes>1
        B=deepcopy(A)
    else
        B=A
    end

    R = CartesianRange(size(A))
    I1, Iend = first(R), last(R)
    for nn=1:ntimes

        for I in R
            w, s = 0.0, zero(eltype(out))
            # Define out[I] fillvalue
            out[I] = fillvalue
            if dvisvalue(B[I])
                for J in CartesianRange(max(I1, I-I1), min(Iend, I+I1))
                    # If not a fill value
                    #                if !(B[J] == fillvalue)
                    if dvisvalue(B[J])
                        s += B[J]
                        if (I==J)
                            w += cw
                        else
                            w += 1.
                        end
                    end
                    # end if not fill value
                end
				if isfixed[I]
				    out[I]=A[I]
				  else
				    if w>0.0 
                    out[I] = s/w
                    end
				end
            end
        end
        B=deepcopy(out);
    end


    return out
end
##########################################




rhof=deepcopy(rhop)

# If asked for, fill in density anomalies on land
# If not asked for the field must have already been filled in by other means
if fillin
	BBB=deepcopy(rhop)
	rhof[find(.~mask)]=NaN
	#maybe better to floodfill in all directions EXCEPT vertically. So loop on layers and indexing ?
	#floodfill!(rhof,B,NaN)
	for iz=1:size(BBB)[dim]
	  ind2 = [(j == dim ? (iz) : (:)) for j = 1:ndims(rhop)]
	  #@show ind2,iz,dim
	  #@show rhop[ind2...]
	  aaa=deepcopy(rhof[ind2...])
	  #@show size(BBB),size(rhof)
	  bbb=deepcopy(BBB[ind2...])
	  #@show size(aaa),size(bbb)
	  nanpos=isnan.(aaa)
	  #@show size(aaa),size(bbb)
	  aaa=floodfill!(aaa,bbb,NaN)
	  # @show size(aaa),size(bbb)
	 #  Now one also should filter in the places where originially NaN where found
	  # si using divand_filter3(,NaN,10)
	  
	  zzzz=fill(NaN,size(aaa))
	  #@show size(zzzz)
	  zzzz[nanpos]=aaa[nanpos]
	  isfixed=fill(true,size(aaa))
	  isfixed[nanpos]=false
	  
	  zzzz=myfilter3(zzzz,NaN,isfixed,20)
	  aaa[nanpos]=zzzz[nanpos]
	  #@show size(aaa),size(zzzz)
     #@show size(rhof)
	 rhof[ind2...]=deepcopy(aaa)
	  
	  
	  
	  
	end
	
end


# Now integrate in dimension dim

#@show size(rhop),size(rhof),typeof(rhop),typeof(rhof),mean(var(rhof,2))

rhoi=integraterhoprime(rhof,xiin[dim],dim)

#@show size(rhoi),size(rhof)

#@show mean(var(rhoi,2)),mean(var(rhop,2))

# If ssh provided use it, otherwise first calculate steric height

  if znomotion>0
    ssh=stericheight(rhoi,xiin[dim],znomotion,dim)
	    else
		if fillin
		 ind2 = [(j == dim ? (1) : (:)) for j = 1:ndims(mask)]
		 # @show ind2
		  ssh[find(.~mask[ind2...])]=NaN
		 # @show ssh
		 aaa=deepcopy(ssh)
		 bbb=deepcopy(ssh)
	  
	     nanpos=isnan.(aaa)
	    
	     aaa=floodfill!(aaa,bbb,NaN)
		 zzzz=fill(NaN,size(aaa))
	    #@show size(zzzz)
	     zzzz[nanpos]=aaa[nanpos]
	     isfixed=fill(true,size(aaa))
	     isfixed[nanpos]=false
	  
	    zzzz=myfilter3(zzzz,NaN,isfixed,20)
	    aaa[nanpos]=zzzz[nanpos]
		ssh=deepcopy(aaa)
		 
		end
  end

# Now add barotropic pressure onto the direction dim 

poverrho=similar(rhoi)

#@show var(rhoi),mean(rhoi)

# 
poverrhog=addlowtoheighdimension(ssh,rhoi/1025.,dim)

#@show mean(var(poverrhog,2))

goverf=earthgravity.(xiin[2])./coriolisfrequency.(xiin[2])
 
# Need to decide how to provide latitude if 1D ...



# Loop over dimensions 1 to dim-1



velocity=()
fluxes=()

for i=1:dim-1



#VN=0*similar(poverrhog)
VN=zeros(Float64,size(poverrhog))

#@show mean(VN),mean(poverrhog),typeof(poverrhog),typeof(VN)

Rpre = CartesianRange(size(poverrhog)[1:i-1])
Rpost = CartesianRange(size(poverrhog)[i+1:end])
n=size(poverrhog)[i]

    for Ipost in Rpost
        
        for j = 1:n-1
            for Ipre in Rpre
                 VN[Ipre, j, Ipost] = (poverrhog[Ipre, j+1 , Ipost]-poverrhog[Ipre, j , Ipost])*pmnin[i][Ipre, j , Ipost]*goverf[Ipre, j , Ipost]
			end
        end
    end
VN[find(.~mask)]=0.0

if isnan(mean(VN))
 @show mean(VN)
 warning("Problem in geostrophic calculation")
end

velocity=tuple(velocity...,(deepcopy(VN)))

#@show mean(VN)

# maybe add volume flux calculation using mask putting zero and integraterhoprime of VN/pnmin[i] with previous loop and then simple sum in remaining direction of # bottom value yep should work easily !!!

ind1 = [(j == dim ? (size(VN)[dim]) : (:)) for j = 1:ndims(VN)]

#@show ind1, size(VN),size(pmnin[i])

dummy=integraterhoprime(VN./pmnin[i],xiin[dim],dim)


#@show size(dummy),mean(VN),mean(dummy)

# now take deepast value for VN which is the integral

hjm=deepestpoint(mask,dummy)

#@show size(dummy[ind1...]),size(hjm)




fluxi=squeeze(sum(dummy[ind1...],i),i)

#@show size(fluxi), var(fluxi),mean(VN),var(VN)

#if isnan(var(fluxi))

#@show dummy[ind1...]
#@show VN[ind1...]./pmnin[i][ind1...]
#@show xiin[dim][ind1...]

#end

fluxes=tuple(fluxes...,(deepcopy(fluxi)))

end




return velocity,ssh,fluxes
 
end 


# Copyright (C)           2018 Alexander Barth 		<a.barth@ulg.ac.be>
#                              Jean-Marie Beckers 	<jm.beckers@ulg.ac.be>
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <http://www.gnu.org/licenses/>.


